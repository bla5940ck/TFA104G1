<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member_coupon.model.*"%>

<%
	List<MemcouponVO> memcouponVO = (List<MemcouponVO>) request.getAttribute("memcouponVO");
	List<MemcouponVO> list = memcouponVO;
	pageContext.setAttribute("list", list);
%>

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




			<table id="table-1">
				<tr>
					<td>
						<h3>我的折價券</h3>
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
			<!-- mem_coupon_id, member_id, category_id, coupon_id, coupon_name, discount, status, start_date, end_date -->
			<table>
				<tr>
					<th>會員的折價券編號</th>
<!-- 					<th>會員編號</th> -->
<!-- 					<th>商品類別編號</th> -->
					<th>折價券編號</th>
					<th>折價券名稱</th>
					<th>折價金額</th>
					<th>折價券狀態</th>
					<th>開始日期</th>
					<th>結束日期</th>
				</tr>
				<c:forEach var="memcouponVO" items="${list}">

					<tr>
						<td>${memcouponVO.mem_coupon_id}</td>
<%-- 						<td>${memcouponVO.member_id}</td> --%>
<%-- 						<td>${memcouponVO.category_id}</td> --%>
						<td>${memcouponVO.coupon_id}</td>
						<td>${memcouponVO.coupon_name}</td>
						<td>${Math.round(memcouponVO.discount)}</td>
						<td>${memcouponVO.status}</td>
						<td>${memcouponVO.start_date}</td>
						<td>${memcouponVO.end_date}</td>
<!-- 						<td> -->
<!-- 							<FORM METHOD="post" -->
<%-- 								ACTION="<%=request.getContextPath()%>/back_end/promo_list/promolist.do" --%>
<!-- 								style="margin-bottom: 0px;"> -->
<!-- 								<input type="submit" value="領取"> <input type="hidden" -->
<%-- 									name="coupon_id" value="${promolistVO.coupon_id}"> <input --%>
<!-- 									type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 							</FORM> -->
<!-- 						</td> -->
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