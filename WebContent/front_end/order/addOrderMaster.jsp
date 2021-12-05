<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="com.member.model.*"%>
<%@page import="com.member_coupon.model.*"%>
<%@page import="com.promo_list.model.*"%>
<%@page import="com.member.model.*"%>
<%@page import="com.order.model.*"%>
<%@ page import="com.product.model.*"%>
<%
	System.out.println("進入新增");

	//會員id
	Integer memID = (Integer)session.getAttribute("id"); 
	System.out.println("承租者編號 : " + memID);
	
	CartVO cartVO = (CartVO)request.getAttribute("cartVO");
	
	//商品編號+名稱
	ProdDAO prodDAO = new ProdDAO();
	ProdVO prodVO = prodDAO.findProductByPK(cartVO.getProdID());
	System.out.println("商品編號 : " + prodVO.getProdID());
	System.out.println("商品名稱 : " + prodVO.getProdName());
	
	//起訖日
	System.out.println("起始日 : " + cartVO.getEstStart());
	System.out.println("結束日 : " + cartVO.getEstEnd());
	Date esstr = cartVO.getEstStart();	
	Date eestr = cartVO.getEstEnd();
	long rd = ((eestr.getTime())-(esstr.getTime()));
	Date rdd = new Date(rd);
	Integer rentDays = new Integer((rdd.getDate()));
	Integer rentDay = new Integer((rdd.getDay()));
	System.out.println("租借天數Date : " + rentDays);
	System.out.println("租借天數Day : " + rentDay);
	
	// 出租者編號
	MemberService memSVC = new MemberService();
	MemberVO memVO = memSVC.getOneMember(cartVO.getLeaseID());
	System.out.println("出租者會員姓名 + " + memVO.getName());
	String leaseName =  memVO.getName();
	
	// 預設物流
	DefAddressJDBCDAO dadao = new DefAddressJDBCDAO();
	List<DefAddressVO> list2 = dadao.getAll();
 	DefAddressVO daVO = new DefAddressVO();
 	
	// 折價券
	MemcouponDAO mcdao = new MemcouponDAO();
	List<MemcouponVO> list = mcdao.getAll();
	MemcouponVO mcVO = new MemcouponVO();
	
	//商品租金+總金額
	Integer rent = cartVO.getRent();
	System.out.println("商品租金 : " + rent);
	Integer totalPrice = cartVO.getTotalPrice();
	System.out.println("總租金 : " + totalPrice);
	
%>

<html>
<head>
<title>結帳 :</title>
<style>
 body { 
 	margin: 0; 
 	padding: 10px; 
 } 

img {
	max-width: 100%;
}

button{
	font-size:13px;
	outline-width: 100%;
	background-color:white;
}

 div.main_content { 
 	width: 100%; 
 	margin: 0 auto; 
 	font-size: 0; 
 } 

/*-------------------aside區域------------------- */
aside.aside {
	width: 200px;
	height:620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align:center;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
	width: calc(100% - 200px - 10px);
	height:620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	width: 90%;
	margin-top: 5px;
	margin-bottom: 5px;	
}

table, th, td {
	border: 2px solid lightgrey;
}

th, td {
	padding: 5px;
	text-align: center;
	width: 200px;
	height: 35px;
}

</style>

</head>

<body bgcolor='white'>
<%@ include file="/includeFolder/header2.file" %>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet" name="form1">
		<div class="main_content">
			<aside class="aside">
				<nav class="nav">
					<h2>標題</h2>
					<ul class="nav_list">
						<h4><a href="#">連結</a></h4>
						<h4><a href="#">連結</a></h4>
					</ul>
				</nav>
			</aside>
			<main class="main">
				<div>
					<h3>結帳頁面</h3>
				</div>

				<table id="table-1">
					<h3>確認以下資訊</h3>
					<tr>
						<td>出租者:</td>
						<td><input type="hidden" name="rentID" value="<%=leaseName%>"><%=leaseName%></td>
					</tr>
					<tr>
						<td>商品名稱 :</td>
						<td><a id="prodName"
							href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=<%=cartVO.getProdID()%>"><%=cartVO.getProdName()%></a></td>
					</tr>
					</table>
					<table id="table-1">
					<tr>
						<td>預定租借起日:</td>
						<td><input type="hidden" name="estStart" value="<%=cartVO.getEstStart()%>"><%=cartVO.getEstStart()%></td>
					</tr>
					<tr>
						<td>預定租借訖日:</td>
						<td><input type="hidden" name="estEnd" value="<%=cartVO.getEstEnd()%>"><%=cartVO.getEstEnd()%></td>
					</tr>
					<tr>
						<td>承租天數:</td>
						<td>
						<input type="hidden" name="rentDays" value="<%=rentDays%>"><%=rentDays%> 天</td>
					</tr>
					</table>
					<table id="table-1">					
					<jsp:useBean id="poDAO"	class="com.order.model.PaymentOptionsDAOImpl" /> 
					<tr>
						<td>選擇付款方式:</td>
						<td>
						<select size="1" name="payID" style="width:120px">
								<c:forEach var="poVO" items="${poDAO.getAllPaymentOptions()}">
									<option value="${poVO.payID}">${poVO.payName}
								</c:forEach>
						</select>
						</td>
					</tr>
					<jsp:useBean id="plDAO"	class="com.promo_list.model.PromolistDAO" /> 					
					<jsp:useBean id="mcDAO"	class="com.member_coupon.model.MemcouponDAO" /> 					
					<tr>
						<td>選擇折價券:</td>
						<td><select size="1" name="couponID" id="couponID">
								<option>請選擇折價券
								<c:forEach var="mcVO" items="${mcDAO.getAll()}">
								<c:choose>
									<c:when test="${mcVO.member_id == id}">
										<option value="${Math.round(mcVO.discount)}">${mcVO.coupon_name}
									</c:when>
								</c:choose>
								</c:forEach>
						</select></td>
					</tr>
								
					<jsp:useBean id="daDAO"	class="com.member.model.DefAddressJDBCDAO" /> 
					<jsp:useBean id="meDAO"	class="com.member.model.MemberJDBCDAO" /> 
					
					<tr>
						<td>選擇超商:</td>
						<td><select size="1" name="code711" style="width:120px">
								<c:forEach var="daVO" items="${daDAO.getAll()}">
								<c:choose>
									<c:when test="${daVO.memberId == id}">
										<option value="${daVO.code711}">${daVO.name711}
									</c:when>
								</c:choose>
								</c:forEach>
						</select></td>
					</tr>
					</table>
					<table id="table-1">
					<tr>
						<td>商品小計:</td>
						<td><input type="hidden" name="prodPrice" value="<%=rent%>"><%=rent%> 元</td>
					</tr>
					<tr>
						<td>總租金:</td>
						<td><input type="hidden" name="prodPrice" value="<%=totalPrice%>"><%=totalPrice%> 元</td>
					</tr>
					<tr>
						<td>折扣:</td>
						<td><p id="discount"></p></td>
					</tr>
					<tr>
						<td>運費:</td>
						<td><input type="hidden" name="shipFee" value="60">60</td>
					</tr>
					<tr>
						<td>訂單金額:</td>
						<td><input type="hidden" name="ordPrice" id="ordPrice" value="">	</td>
					</tr>
				</table>
<!-- 				<input type="hidden" name="action" value="submit_order"> -->
<%-- 				<input type="hidden" name="prodID" value="<%=prodVO.getProdID()%>">  --%>
<%-- 				<input type="hidden" name="prodName" value="<%=prodVO.getProdName()%>"> --%>
<!-- 				<input type="hidden" name="discount" id="discount"> -->
<!-- 				<input type="submit" value="送出訂單 !"> -->
			</main>
		</div>
	<%@ include file="/includeFolder/footer2.file" %>
	</FORM>
	</head>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
var couponID = $("#couponID");
var discount = $("#discount");
couponID.change(function(){
	alert((couponID).val());
	discount.text(couponID.val()+ "元");
});

</script>

</html> 