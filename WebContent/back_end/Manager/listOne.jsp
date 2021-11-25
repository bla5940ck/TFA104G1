<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.manager.model.*"%>

<%
	ManagerVO managerVO = (ManagerVO) request.getAttribute("managerVO");

%>

<html>
<head>
<title>管理者資料 - listOne.jsp</title>

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
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body bgcolor='white'>

	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>管理者資料 - ListOne.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/Manager/select_page.jsp"><img src="<%=request.getContextPath()%>/Manager/images/back1.gif"
						width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>		</tr>
	</table>

	<table>
		<tr>
			<th>管理者編號</th>
			<th>管理者帳號</th>
			<th>管理者姓名</th>
			<th>管理者密碼</th>
			<th>管理者狀態</th>

		</tr>
		<tr>
			<td><%=managerVO.getManagerID()%></td>
			<td><%=managerVO.getManagerUser()%></td>
			<td><%=managerVO.getManagerName()%></td>
			<td><%=managerVO.getManagerPassword()%></td>
			<td><%=managerVO.getStatus()==0?"停用中":"使用中"%></td>

		</tr>
	</table>

</body>
</html>