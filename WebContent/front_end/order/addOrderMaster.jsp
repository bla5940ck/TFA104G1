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
	height:100%;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
/* 	border: 1px solid #999; */
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
				<div><h3>結帳頁面</h3></div>
				<h3>確認以下資訊</h3>
					
				<%List<CartVO> checkoutList = (List<CartVO>)request.getAttribute("checkoutList"); 		
				for(CartVO cartVO: checkoutList){
					
					Integer memID = (Integer)session.getAttribute("id"); 
					System.out.println("承租者編號 : " + memID);
					//會員名稱
					MemberService memSVC = new MemberService();
					System.out.println(cartVO.getLeaseID());
				 	MemberVO memVO = memSVC.getOneMember(cartVO.getLeaseID());
				 	System.out.println("出租者會員姓名  " + memVO.getName());
				 	String leaseName =  memVO.getName();
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
					pageContext.setAttribute("list", checkoutList);	
				%>
					
           		<label class="cart-lable" style="color:Navy; font-size:30px; border-color:blue; border-style:dotted;">賣場編號: shop1000<%=cartVO.getLeaseID()%> <%=leaseName%> </label>
               	<table class="table">
                <thead>
                  <tr>
                        <th>商品圖片</th>
                        <th>商品名稱</th>
                        <th>商品租金</th>
                        <th>預計租借日</th>
                        <th>預計歸還日</th>
                        <th>承租天數:</th>
                        <th>總計</th>
                      </tr>
				</thead>          
					<tr>
						<td><a class="cart-img" href="#" alt="img"></a></td>
						<td><a id="prodName" href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=<%=cartVO.getProdID()%>"><%=cartVO.getProdName()%></a></td>
						<td><input type="hidden" name="prodPrice" value="<%=rent%>"><%=rent%> 元</td>
						<td><input type="hidden" name="estStart" value="<%=cartVO.getEstStart()%>"><%=cartVO.getEstStart()%></td>
						<td><input type="hidden" name="estEnd" value="<%=cartVO.getEstEnd()%>"><%=cartVO.getEstEnd()%></td>
						<td><input type="hidden" name="rentDays" value="<%=rentDays%>"><%=rentDays%> 天</td>
						<td><input type="hidden" name="prodPrice" id="prodPrice" value="<%=totalPrice%>"><%=totalPrice%> 元</td>		
					</tr>
<%}%> 

			
					<table id="tabel-1">
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
						<td><select size="1"  id="coupon" >
								<option value="0">請選擇折價券
								<c:forEach var="mcVO" items="${mcDAO.getAll()}">
								<c:choose>
									<c:when test="${mcVO.member_id == id}">										
										<option value="${mcVO.coupon_id}">${mcVO.coupon_name}
										<option data-id="${mcVO.coupon_id}" value="${Math.round(mcVO.discount)}">${mcVO.coupon_name}
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
					<tr>
						<td>折扣:</td>
						<td><p id="discount"></p></td>
					</tr>
					<tr>
						<td>運費:</td>
						<td><input type="hidden" id="shipFee" name="shipFee" value="60">60 元</td>
					</tr>
					<tr>
						<td>訂單金額:</td>
						<td><p id="thisOrder"></p></td>
					</tr>
					</table>
			</table>
				<input type="hidden" name="action" value="submit_order">
<%-- 				<input type="hidden" name="leaseID" value="<%=cartVO.getLeaseID()%>">  --%>
<%-- 				<input type="hidden" name="prodID" value="<%=cartVO.getProdID()%>">  --%>
<%-- 				<input type="hidden" name="prodName" value="<%=cartVO.getProdName()%>"> --%>
				<input type="hidden" name="couponID" id="couponID">	
				<input type="hidden" name="ordPrice" id="ordPrice">
<%-- 				<input type="hidden" name="rentID" value="<%=memID%>"> --%>
				<input type="submit" value="送出訂單 !">
			</main>
		</div>
	</FORM>
	<%@ include file="/includeFolder/footer2.file" %>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>

var coupon = $("#coupon");	//折價券
var discount = $("#discount");	//折扣
var thisOrder = $("#thisOrder");	//前端顯示的訂單金額
var prodPrice = $("#prodPrice");	//商品小計
var orderPrice = $("#orderPrice");	//回傳servlet的訂單金額
<%-- var totalPrice = parseInt(<%=totalPrcice%>); --%>
// var totalPrice = parseInt((totalPrice).val());
//  consloe.log(totalPrice);
// cartVO.getTotalPrice()
var data_id = "";

coupon.change(function(){
	alert((coupon).val());
	discount.text(coupon.val()+"元");

	var finalPrice = parseInt(totalPrice-(coupon).val()+60);
	thisOrder.text(parseInt(totalPrice-(coupon).val()+ 60) + "元");
	document.getElementById("ordPrice").setAttribute('value', finalPrice);
	
	data_id = $("#coupon option:selected").attr('data-id');
	console.log(data_id);
	
	document.getElementById("couponID").setAttribute('value',data_id);
	
	});

	thisOrder.text(prodPrice.val());

// 	thisOrder.text(parseInt(totalPrice-(coupon).val()+ 60) + "元");
// 	thisOrder=parseInt(couponID.val() + prodPrice.val())+ 60 ;
// 	document.getElementById("ordPrice").setAttribute('value', totalPrice-(coupon).val() + 60);
</script>

</html>