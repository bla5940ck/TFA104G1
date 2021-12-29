<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.promo.model.*"%>

<%
    PromoService promoSvc = new PromoService();
    List<PromoVO> list = promoSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有專案資料 - listAll_promo.jsp</title>

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

		 <h3>所有專案資料 </h3>

	<h4>
  <a href='add_promo.jsp'>新增專案</a>
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

<table>
	<tr>
		<th>專案編號</th>
		<th>專案名稱</th>
		<th>專案內容</th>
<!-- 		<th>專案開始日期</th> -->
<!-- 		<th>專案結束日期</th> -->
<!-- 		<th>專案狀態</th> -->
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="promoVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	<!-- 			/*=====訂單狀態=====*/ -->

<!-- 	var ordS = $("#ordS"); -->
<!-- 	if ( -->
<%-- <%=omVO.getOrdStatus()%> --%>
<!-- 	== 0) { -->
<!-- 		ordS.text("已成立"); -->
<!-- 	} else if ( -->
<%-- <%=omVO.getOrdStatus()%> --%>
<!-- 	== 1) { -->
<!-- 		ordS.text("待歸還"); -->
<!-- 	} else if ( -->
<%-- <%=omVO.getOrdStatus()%> --%>
<!-- 	== 2) { -->
<!-- 		ordS.text("已完成"); -->
<!-- 	} else { -->
<!-- 		ordS.text("已取消"); -->
<!-- 	}; -->
		
		<tr>
			<td>${promoVO.promo_id}</td>
			<td>${promoVO.promo_name}</td>
			<td>${promoVO.promo_text}</td> 
<%-- 			<td>${promoVO.promo_start}</td> --%>
<%-- 			<td>${promoVO.promo_end}</td> --%>
<%-- 			<td>${(promoVO.status==0)?'進行中':'已結束'}</td> --%>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/promo_list/promolist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="專案明細">
			     <input type="hidden" name="promo_id"  value="${promoVO.promo_id}">
			     <input type="hidden" name="action"	value="getPromolist"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/promo/promo.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="promo_id"  value="${promoVO.promo_id}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/promo/promo.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="刪除"> -->
<%-- 			     <input type="hidden" name="promo_id"  value="${promoVO.promo_id}"> --%>
<!-- 			     <input type="hidden" name="action" value="delete"></FORM> -->
<!-- 			</td> -->
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>
</main>
</div>
</body>
</html>