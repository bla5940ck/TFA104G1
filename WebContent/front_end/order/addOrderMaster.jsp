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
		
// 	MemberJDBCDAO medao = new MemberJDBCDAO();
// 	MemberVO meVO = medao.findByPrimaryKey(1);
	
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
	System.out.println(rd);
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
 	for(int i = 0; i< list2.size(); i++){
 		DefAddressVO daVO1 = list2.get(i);
 		if(daVO1.getMemberId() == memID){
 			System.out.println("超商選項 : " + daVO1.getName711());
 			String name711 = daVO1.getName711();
 		}
 	}
	// 折價券
// 	MemcouponDAO mcdao = new MemcouponDAO();
// 	List<MemcouponVO> list = mcdao.getAll();
// 	for(MemcouponVO memcou : list){
// 		if(memcou.getMember_id() == memID){
// 			PromolistDAO pldao = new PromolistDAO();
// 			PromolistVO plVO = pldao.findByPrimaryKey(memcou.getCoupon_id());
// 			System.out.println(plVO);
// 		}
// 	}

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
	height: 25px;
}

/***選單***/

.box select {
  background-color: #0563af;
  color: white;
  padding: 12px;
  width: 250px;
  border: none;
  font-size: 14px;
  box-shadow: 0 5px 25px rgba(0, 0, 0, 0.2);
  -webkit-appearance: button;
  appearance: button;
  outline: none;
}

.box::before {
  font-family: FontAwesome;
  position: absolute;
  width: 20%;
  height: 80%;
  text-align: center;
  font-size: 28px;
  line-height: 45px;
  color: rgba(255, 255, 255, 0.5);
  background-color: rgba(255, 255, 255, 0.1);
  pointer-events: none;
}

/* .box:hover::before { */
/*   color: rgba(255, 255, 255, 0.6); */
/*   background-color: rgba(255, 255, 255, 0.2); */
/* } */

.box select option {
  padding: 30px;
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
						<div class="box">
						<select size="1" name="payID" style="width:150px">
								<c:forEach var="poVO" items="${poDAO.getAllPaymentOptions()}">
									<option value="${poVO.payID}">${poVO.payName}
								</c:forEach>
						</select>
						</div>
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<td>選擇折價券:</td> -->
<!-- 						<td><select size="1" name="couponID" id="cpn"> -->
<!-- 								<option id="disc" value=""> -->
									<%
// 									for (int i = 0; i < list.size(); i++) {
// 										MemcouponVO mcVO = list.get(i);
// 										if (mcVO.getMember_id() == 3) {
// 											PromolistDAO pldao = new PromolistDAO();
// 											PromolistVO plVO = pldao.findByPrimaryKey(mcVO.getCoupon_id());
 								%> 
								
<%-- 								<option id="disc" value="<%=mcVO.getCoupon_id()%>">!!<%=plVO.getCoupon_name()%>!! --%>
<!-- 									 可折扣 : -->
<%-- 									<%=Math.round(plVO.getDiscount())%>元<br> --%>
<!-- 								</option> -->
<%-- 								<% --%>
// 									}
// 									}
<%-- 								%> --%>
<!-- 						</select></td> -->
<!-- 					</tr> -->		
					
					<jsp:useBean id="daDAO"	class="com.member.model.DefAddressJDBCDAO" /> 
					<jsp:useBean id="meDAO"	class="com.member.model.MemberJDBCDAO" /> 
					
					<tr>
						<td>選擇超商:</td>
						<td><select size="1" name="code711" style="width:150px">
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
<!-- 					<tr> -->
<!-- 						<td>折扣:</td> -->
<!-- 						<td><p id="discount"></p></td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>運費:</td> -->
<!-- 						<td><input type="hidden" name="shipFee" value="60">60</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>訂單金額:</td> -->
<!-- 						<td><input type="hidden" name="ordPrice" value="160">160</td> -->
<!-- 					</tr> -->
				</table>
<!-- 				<input type="hidden" name="action" value="submit_order"> -->
<%-- 				<input type="hidden" name="prodID" value="<%=prodVO.getProdID()%>">  --%>
<%-- 				<input type="hidden" name="prodName" value="<%=prodVO.getProdName()%>"> --%>
<!-- 				<input type="submit" value="送出訂單 !"> -->
			</main>
		</div>
	<%@ include file="/includeFolder/footer2.file" %>
	</FORM>
	</head>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
//         $.datetimepicker.setLocale('zh');
//         $('#f_date1').datetimepicker({
// 	       theme: '',              //theme: 'dark',
// 	       timepicker:false,       //timepicker:true,
// 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
// 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
// 		   value: new Date(),   // value:   new Date(),
//            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
//            //startDate:	            '2017/07/10',  // 起始日
//            //minDate:               '-1970-01-01', // 去除今日(不含)之前
//            //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
//         });
</script>

</html> 