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
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;	
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
	background-color:#F5D998;;
	height:720px;
}



/*--------------------main區域-------------------- */
main.main {
	background-color: 	#F0F0F0;
	width: calc(100% - 200px - 10px);
	height: 720px;
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

table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: red;
	display: inline;
}

table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	font-size: 10px;
	border: 1px solid #CCCCFF;
}

th, td {
	height: 100px padding: 5px;
	text-align: center;
}

.pic {
	object-fit: contain;
	width: 95px;
	height: 80px;
}

.signOut{
background-color:	#FF7575;
}
.class1{
background-color:#FFF0AC;
}

input{
background-color:#FFF0AC;
}
</style>

</head>
<body bgcolor='white'>

	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" >	

		 <h3>修改成功  listOne_promolist.jsp</h3>


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
</main>
</div>
</body>
</html>