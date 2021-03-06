<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.promo_list.model.*"%>

<%
// 	List<PromolistVO> promolistVO = (List<PromolistVO>) request.getAttribute("promolistVO");
//     List<PromolistVO> list = promolistVO;
//  	pageContext.setAttribute("list",list);
Integer promoID =(Integer)request.getAttribute("promoID");
pageContext.setAttribute("promoID",promoID);
System.out.println(promoID);
%>

<jsp:useBean id="promoSvc" scope="page" class="com.promo.model.PromoService" />
<jsp:useBean id="promolistSvc" scope="page" class="com.promo_list.model.PromolistService" />

<html>
<head>
<title>所有專案明細資料</title>

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


.class1{
background-color:#FFF0AC;
}

input{
background-color:#FFF0AC;
}

button{
background-color: #FFF0AC;
}
</style>

</head>
<body bgcolor='white'>

	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" >	

		 <h3>所有專案明細資料 </h3>


	<h4>  
<a href='add_promolist.jsp'>新增折價券</a>
	</h4>




<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<!-- coupon_id, promo_id, category_id, coupon_name, discount, amount, used, start_date, end_date -->
<table>
	<tr>
		<th>專案編號</th>
		<th>專案名稱</th>
<!-- 		<th>商品類別編號</th> -->
		<th>折價券名稱</th>
		<th>折價金額</th>
		<th>狀態</th>
<!-- 		<th>已領取數量</th> -->
<!-- 		<th>開始日期</th> -->
<!-- 		<th>結束日期</th> -->
	</tr>
<%-- 	<%@ include file="page1.file" %>  --%>
<%-- 	<c:forEach var="promolistVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> --%>
	<c:forEach var="promolistVO" items="${promolistSvc.getPromoid(promoID)}">
		
<%-- 			     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/promo_list/promolist.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="新增"> -->
<%-- 			     <input type="hidden" name="promo_id"  value="${promolistVO.promo_id}"> --%>
<!-- 			     <input type="hidden" name="action" value="getOne_For_Insert"></FORM> -->
		<tr>
			<td>${promolistVO.promo_id}</td>
			<td>
		<c:forEach var="promoVO" items="${promoSvc.all}">
				<c:if test="${promolistVO.promo_id==promoVO.promo_id}">
				<label>${promoVO.promo_name}</label>
			</c:if>
		</c:forEach>	
		</td>
<%-- 			<td>${promolistVO.category_id}</td> --%>
			<td>${promolistVO.coupon_name}</td>
			<td>${Math.round(promolistVO.discount)}</td>
			<td>${(promolistVO.amount==1)?'進行中':'已結束'}</td>
<%-- 			<td>${promolistVO.used}</td>  --%>
<%-- 			<td>${promolistVO.start_date}</td> --%>
<%-- 			<td>${promolistVO.end_date}</td> --%>
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
<!-- 		<td> -->
<!-- 	<FORM METHOD="post" ACTION="promolist.do" style="margin-bottom: 0px;"> -->
<!-- <input type="submit" value="新增"> -->
<%-- <input type="hidden" name="promo_id"  value="${promolistVO.promo_id}"> --%>
<!-- <input type="hidden" name="action"	value="getOne_For_Insert"></FORM> -->
<!-- </td> -->
	</c:forEach>

</table>
<%-- <%@ include file="page2.file" %> --%>

<!-- <h3>新增專案明細</h3> -->

<br>
<button class="back_btn">返回上一頁</button>
</main>
</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$("button.back_btn").click(function(){
		history.go(-1);
	});

</script>
</html>