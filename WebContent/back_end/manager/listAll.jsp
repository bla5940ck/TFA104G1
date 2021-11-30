<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.manager.model.*"%>

<%
	ManagerService msSvc = new ManagerService();
	List<ManagerVO> list = msSvc.getAll();
	pageContext.setAttribute("list", list);

	ManagerVO managerVO = (ManagerVO) request.getAttribute("managerVO");
	// 	for(ManagerVO maVO : list){
	// 		out.println(maVO.getStatus());
	// 	};
%>

<html>
<head>
<title>所有管理者資料-listAllManager.jsp</title>
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

a {
	color: red;
}
</style>

<style>
table {
	width: 800px;
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

	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有管理者資料listAllManager.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back_end/manager/select_page.jsp"><img
						src="<%=request.getContextPath()%>/back_end/manager/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%--錯誤列表 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

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
		<%@ include file="page1.file"%>
		<c:forEach var="managerVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr>

				<td>${managerVO.managerID}</td>
				<td>${managerVO.managerUser}</td>
				<td>${managerVO.managerName}</td>
				<td>${managerVO.managerPassword}</td>
				<td>${(managerVO.status==0)?'停用中':'使用中'}</td>

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
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>
	
</body>
</html>