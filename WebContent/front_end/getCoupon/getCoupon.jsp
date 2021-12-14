<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.promo_list.model.*"%>


<html>
<head>
<title>折價券領取頁面</title>
<style>
body {
	margin: 0;
	padding: 10px;
}

img {
	max-width: 100%;
}

button {
	font-size: 13px;
	outline-width: 100%;
	background-color: white;
}

div.main_content {
	width: 100%;
	margin: 0 auto;
	font-size: 0;
}

/*-------------------aside區域------------------- */
/* aside.aside { */
/* 	width: 200px; */
/* 	height:620px; */
/* 	display: inline-block; */
/* 	vertical-align: top; */
/* 	font-size: 1rem; */
/* 	margin-right: 10px; */
/* 	border: 1px solid #999; */
/* 	text-align:center; */
/* } */

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
	width: 100%;
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

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
</style>
</head>
<body>
	<%
		session.setAttribute("id", 1);
	%>
		<%@ include file="/includeFolder/header2.file"%>
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
	</div>
	<%@ include file="/includeFolder/footer2.file"%>
	<!-- 	<footer class="footer"> footer區域 </footer> -->
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	
</script>
</html>