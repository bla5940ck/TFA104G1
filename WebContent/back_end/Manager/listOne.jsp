<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.manager.model.*"%>

<%
	ManagerVO managerVO = (ManagerVO) request.getAttribute("managerVO");

%>

<html>
<head>
<title>�޲z�̸�� - listOne.jsp</title>

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

	<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>�޲z�̸�� - ListOne.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/Manager/select_page.jsp"><img src="<%=request.getContextPath()%>/Manager/images/back1.gif"
						width="100" height="100" border="0">�^����</a>
				</h4>
			</td>		</tr>
	</table>

	<table>
		<tr>
			<th>�޲z�̽s��</th>
			<th>�޲z�̱b��</th>
			<th>�޲z�̩m�W</th>
			<th>�޲z�̱K�X</th>
			<th>�޲z�̪��A</th>

		</tr>
		<tr>
			<td><%=managerVO.getManagerID()%></td>
			<td><%=managerVO.getManagerUser()%></td>
			<td><%=managerVO.getManagerName()%></td>
			<td><%=managerVO.getManagerPassword()%></td>
			<td><%=managerVO.getStatus()==0?"���Τ�":"�ϥΤ�"%></td>

		</tr>
	</table>

</body>
</html>