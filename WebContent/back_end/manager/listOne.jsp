<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.manager.model.*"%>

<%
	ManagerVO managerVO = (ManagerVO) request.getAttribute("managerVO");
%>

<html>
<head>
<title>管理者資料 - listOne.jsp</title>
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
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" style="background-color:#C0C0C0;">
			<h4>此頁暫練習採用 Script 的寫法取值:</h4>
			<table id="table-1">
				<tr>
					<td>
						
						<h4>
							<a href="<%=request.getContextPath()%>/back_end/manager/select_page.jsp">回首頁</a>
						</h4>
					</td>
				</tr>
			</table>

			<table>
				<tr>
					<th>管理者編號</th>
					<th>管理者帳號</th>
					<th>管理者姓名</th>
					<th>管理者密碼</th>
					<th>管理者狀態</th>
					<th>修改</th>
					<th>刪除</th>
				</tr>
				<tr>
					<td><%=managerVO.getManagerID()%></td>
					<td><%=managerVO.getManagerUser()%></td>
					<td><%=managerVO.getManagerName()%></td>
					<td><%=managerVO.getManagerPassword()%></td>
					<td><%=managerVO.getStatus() == 0 ? "停用中" : "使用中"%></td>

					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/ManagerServlet"
							style="margin-bottom: 0px;">
							<input type="submit" value="修改"> <input type="hidden"
								name="managerID" value="${managerVO.managerID}"> <input
								type="hidden" name="action" value="getOne_For_Update">
						</FORM>
					</td>
					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/ManagerServlet"
							style="margin-bottom: 0px;">
							<input type="submit" value="刪除"> <input type="hidden"
								name="managerID" value="${managerVO.managerID}"> <input
								type="hidden" name="action" value="delete">
						</FORM>
					</td>
				</tr>
			</table>
		</main>
	</div>
	
</body>
</html>