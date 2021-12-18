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
			<h4>此頁練習採用 EL 的寫法取值:</h4>
		
			<table id="table-1">
				<tr>
					<td>
						
						<h4>
							<a
								href="<%=request.getContextPath()%>/back_end/manager/select_page.jsp">回首頁</a>
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
								<input type="submit" value="修改"> 
								<input type="hidden" name="managerID" value="${managerVO.managerID}">
								<input type="hidden" name="action" value="getOne_For_Update">
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
		</main>
	</div>
	
</body>
</html>