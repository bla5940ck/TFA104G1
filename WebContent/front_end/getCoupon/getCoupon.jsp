<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<style>
table {
	width: 100%;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid lightgrey;
}

th, td {
	padding: 5px;
	text-align: center;
}

	input.memberId {
  			background-color: lightgray;
	}
	
</style>


<body>
		<%@ include file="/includeFolder/header.file"%>
<!-- 錯誤表列 -->


<!-- / catg header banner section -->

<!-- Cart view section -->
	<section id="aa-myaccount">
		<div class="container">
			<div class="row" id="row1">
				<div class="col-md-12" id="col-md-12">
<!-- 					<div class="aa-myaccount-area" id="aa-myaccount-area"> -->
						<div class="row" id="row2">
							<!--<div class="col-md-6" id="col-md-6"> -->
								<div class="aa-myaccount-login" id="aa-myaccount-login">
	<%
		session.setAttribute("id", 1);
	%>	
	<!-- 	<header class="header"> header區域 </header> -->
	<div class="main_content">
		<!-- 		<aside class="aside"> -->
		<!-- 			<nav class="nav"> -->
		<!-- 				<ul class="nav_list"> -->
		<!-- 					<h2>出租者專區</h2> -->
		<%-- 					<h4><a href="<%=request.getContextPath()%>/front_end/order/listAllOrderList.jsp">全部訂單</a></h4> --%>
		<!-- 				</ul> -->
		<!-- 			</nav> -->
		<!-- 		</aside> -->
		<main class="main">
		
		
<c:if test="${b==true }">

		<script>
 			alert("領取成功");
		</script>
	</c:if>

	<c:if test="${b==false}">
			<script>
			alert("已領取過");
		</script>
	</c:if>
	
			<table id="table-1">
				<tr>
					<td>
						<h3>折價券領取專區</h3>
					</td>
				</tr>
			</table>

			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<!-- coupon_id, promo_id, category_id, coupon_name, discount, amount, used, start_date, end_date -->
			<table>
				<tr>
<!-- 					<th>折價券編號</th> -->
<!-- 					<th>專案編號</th> -->
<!-- 					<th>商品類別編號</th> -->
					<th>折價券名稱</th>
					<th>折價金額</th>
<!-- 					<th>數量</th> -->
					<!-- 					<th>已領取數量</th> -->
<!-- 										<th>開始日期</th> -->
<!-- 										<th>結束日期</th> -->
				</tr>
				<jsp:useBean id="promo" class="com.promo_list.model.PromolistService" />
				
				<c:forEach var="promolistVO" items="${promo.getAmount(0)}">


					<tr>
<%-- 						<td>${promolistVO.coupon_id}</td> --%>
<%-- 						<td>${promolistVO.promo_id}</td> --%>
<%-- 						<td>${promolistVO.category_id}</td> --%>
						<td>${promolistVO.coupon_name}</td>
						<td>${Math.round(promolistVO.discount)}</td>
<%-- 						<td>${promolistVO.amount}</td> --%>
						<%-- 						<td>${promolistVO.used}</td> --%>
<%-- 												<td>${promolistVO.start_date}</td> --%>
<%-- 												<td>${promolistVO.end_date}</td> --%>
						<td>
							<FORM METHOD="post"
								ACTION="getcoupon.do"
								style="margin-bottom: 0px;">
								<input class="btn" type="submit" value="領取"> 
								<input type="hidden" name="member_id" value="1"> 
								<input type="hidden" name="category_id" value="${promolistVO.category_id}"> 
								<input type="hidden" name="coupon_id" value="${promolistVO.coupon_id}"> 
								<input type="hidden" name="coupon_name" value="${promolistVO.coupon_name}"> 
								<input type="hidden" name="discount" value="${promolistVO.discount}"> 
								<input type="hidden" name="status" value="0"> 
								<input type="hidden" name="start_date" value="${promolistVO.start_date}"> 
								<input type="hidden" name="end_date" value="${promolistVO.end_date}"> 
								<input type="hidden" name="action" value="insert">
								 <input type="hidden" name="amount"  value="0">
							</FORM>
						</td>

		</tr>
				</c:forEach>
			</table>


		</main>
		<br>
	<br>
		<center><a class="aa-browse-btn" href="/TFA104G1/front_end/product/homePage.jsp"><span class="fa fa-long-arrow-left"></span>回首頁</a></center>
								<br>
	<br>
				</div>
						</div>
						</div>
					</div>
				</div>
			</div>
<!-- 		</div> -->
	</section>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
</html>