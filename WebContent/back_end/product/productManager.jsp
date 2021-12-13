<%@page import="com.product.model.ProdService"%>
<%@page import="com.product.model.ProdVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.memberservice.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% 
	ProdService prodSvc = new ProdService();
	
	List<ProdVO> list =  prodSvc.getAll();
	pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>商品列表</title>
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
	height: 720px;
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
</style>
<style>
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


</style>

<style>
table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	font-size:10px;
	border: 1px solid #CCCCFF;
}

th, td {
height:100px
	padding: 5px;
	text-align: center;
}

.pic{
object-fit: contain;
	width: 95px;
	height: 80px;
}
</style>

</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" style="background-color:#C0C0C0;">
			<table id="table-1">
				<tr>
					<td>
						
						<h4>
							<a
								href="<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp">回首頁</a>
						</h4>
					</td>
				</tr>
			
			</table>

			
	<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/MemberServiceServlet"
				name="form1" enctype="multipart/form-data">
			<table>
				<tr>
					<th>商品編號</th>
					<th>商品名稱</th>					
					<th>商品租金</th>
					<th>商品價值</th>
					<th>商品類別</th>
					<th>訊息時間</th>					
					<th>問題描述</th>
					
				
				</tr>
				<jsp:useBean id="cateSvc" scope="page" class="com.category.model.ProdCategoryService" />
				<%@ include file="page1.file"%>
				
				<c:forEach var="prodVO" items="${list}" begin="<%=pageIndex%>"
					end="<%=pageIndex+rowsPerPage-1%>">
					<br>
					<tr>					
						<td>${prodVO.prodID}</td>
						<td>${prodVO.prodName}</td>
						<td>${prodVO.prodRent}</td>
						<td>${prodVO.prodPrice}</td>
						<td>${cateSvc.findCategoryByPK(prodVO.categoryID).categoryName}</td>
<%-- 						<td>${msVO.ordID}</td> --%>
<%-- 						<td><fmt:formatDate value="${msVO.msgDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
<%-- 						<td>${msVO.problemMsg}</td> --%>
						<td class="pic"><img alt="" src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=1&msgID=${msVO.msgID}"></td>
						<td><select name="problemStatus" size="1" id="s">
								<option value="0" >未處理</option>
								<option value="1" >已處理</option>
						</select></td>
						
						
					</tr>
				</c:forEach>
		</table>
		<input type="hidden" name="action" value="update" >
				<center><input type="submit" value="送出"></center>	
			</FORM>
			<%@ include file="page2.file"%>
		</main>
	</div>
	
</body>

</html>