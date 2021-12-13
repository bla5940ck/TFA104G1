<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="com.promo_list.model.*"%>
<%
  PromolistVO promolistVO = (PromolistVO) request.getAttribute("promolistVO");
%>

<html>
<head>
<title>專案明細資料 - listOne_promolist.jsp</title>

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
aside.aside {
	width: 200px;
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
	width: calc(100% - 200px - 10px);
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	width: 80%;
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
<style>
table#table-1 {
	width: 80%;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h2 {
	color: blue;
	display: inline;
}

.signOut{
background-color:#6495ed;
}


</style>

</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" style="background-color:#C0C0C0;">	

<!-- <h4>此頁暫練習採用 Script 的寫法取值:</h4> -->
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - listOne_promolist.jsp</h3>
		 <h4><a href="select_promolist.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>折價券編號</th>
		<th>專案編號</th>
		<th>商品類別編號</th>
		<th>折價券名稱</th>
		<th>折價金額</th>
		<th>數量</th>
		<th>已領取數量</th>
		<th>開始日期</th>
		<th>結束日期</th>
	</tr>
	<tr>
<%-- 		<td><%=promoVO.getPromo_id()%></td> --%>
<%-- 		<td><%=promoVO.getPromo_name()%></td> --%>
<%-- 		<td><%=promoVO.getPromo_start()%></td> --%>
<%-- 		<td><%=promoVO.getPromo_end()%></td> --%>
<%-- 		<td><%=promoVO.getPromo_text()%></td> --%>
<%-- 		<td><%=promoVO.getStatus()%></td> --%>

			<td>${promolistVO.coupon_id}</td>
			<td>${promolistVO.promo_id}</td>
			<td>${promolistVO.category_id}</td>
			<td>${promolistVO.coupon_name}</td>
			<td>${Math.round(promolistVO.discount)}</td>
			<td>${promolistVO.amount}</td>
			<td>${promolistVO.used}</td> 
			<td>${promolistVO.start_date}</td>
			<td>${promolistVO.end_date}</td>
			<td>
			  <FORM METHOD="post" ACTION="promolist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="coupon_id"  value="${promolistVO.coupon_id}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="promolist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="coupon_id"  value="${promolistVO.coupon_id}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/promo_list/promolist.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="修改"> -->
<%-- 			     <input type="hidden" name="coupon_id"  value="${promolistVO.coupon_id}"> --%>
<!-- 			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/promo_list/promolist.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="刪除"> -->
<%-- 			     <input type="hidden" name="coupon_id"  value="${promolistVO.coupon_id}"> --%>
<!-- 			     <input type="hidden" name="action" value="delete"></FORM> -->
<!-- 			</td> -->

	</tr>
</table>

</body>
</html>