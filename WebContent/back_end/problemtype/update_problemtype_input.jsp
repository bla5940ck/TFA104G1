<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.problemtype.model.*"%>

<%
	ProblemTypeVO ptVO = (ProblemTypeVO) request.getAttribute("problemtypeVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>問題類型修改</title>
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
	background-color:#F0B594;
	height:720px;
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
background-color:#6495ed;
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
							<a href="<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp">回首頁</a>
						</h4>
					</td>
				</tr>
				<br>
			</table>

			<h3>資料修改:</h3>

			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/ProblemTypeServlet" name="form1">
				<table>
					<tr>
						<td>類型編號:<font color=red><b>*</b></font></td>
						<td><%=ptVO.getTypeID()%></td>
					</tr>
					<tr>
						<td>類型名稱:</td>
						<td><input type="TEXT" name="typeName" size="45"
							value="<%=ptVO.getTypeName()%>" /></td>
					</tr>		
					
					

				</table>
				<br> 
				<input type="hidden" name="action" value="update">
				<input type="hidden" name="typeID" value=<%=ptVO.getTypeID()%>>
				<input type="hidden" name="typeName" value=<%=ptVO.getTypeName()%>> 
				<input type="submit" value="送出修改">
			</FORM>
		</main>
	</div>
	
</body>
</html>