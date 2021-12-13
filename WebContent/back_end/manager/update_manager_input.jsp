<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.manager.model.*"%>

<%
	ManagerVO managerVO = (ManagerVO) request.getAttribute("managerVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>管理員資料修改 - update_manager_input.jsp</title>
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
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 500px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
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
						<h3>員工資料修改 - update_manager_input.jsp</h3>
						<h4>
							<a href="<%=request.getContextPath()%>/back_end/manager/select_page.jsp">
							<img src="<%=request.getContextPath()%>/back_end/manager/images/back1.gif"
								width="100" height="32" border="0">回首頁
							</a>
						</h4>
					</td>
				</tr>
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
				ACTION="<%=request.getContextPath()%>/ManagerServlet" name="form1">
				<table>
					<tr>
						<td>管理員編號:<font color=red><b>*</b></font></td>
						<td><%=managerVO.getManagerID()%></td>
					</tr>
					<tr>
						<td>管理員帳號:</td>
						<td><input type="TEXT" name="managerUser" size="45"
							value="<%=managerVO.getManagerUser()%>" /></td>
					</tr>
					<tr>
						<td>管理員姓名:</td>
						<td><input type="TEXT" name="managerName" size="45"
							value="<%=managerVO.getManagerName()%>" /></td>
					</tr>
					<tr>
						<td>管理員密碼:</td>
						<td><input type="TEXT" name="managerPassword" size="45"
							value="<%=managerVO.getManagerPassword()%>" /></td>
					</tr>
					<tr>
						<td>管理員狀態:</td>
						<td><select name="status" size="1" id="s">
								<option value="1"
									<%=managerVO.getStatus() == 1 ? "selected" : ""%>>使用中</option>
								<option value="0"
									<%=managerVO.getStatus() == 0 ? "selected" : ""%>>停用中</option>
						</select></td>
					</tr>

				</table>
				<br> 
				<input type="hidden" name="action" value="update">
				<input type="hidden" name="managerID" value=<%=managerVO.getManagerID()%>>
				<input type="hidden" name="status" value=<%=managerVO.getStatus()%>> 
				<input type="submit" value="送出修改">
			</FORM>
			
		</main>
	</div>
	
</body>
</html>