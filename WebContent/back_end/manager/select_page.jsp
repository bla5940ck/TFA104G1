<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<html>
<head>

<title>IBM Manager: Home</title>
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
	width: 80%;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h2 {
	color: blue;
	display: inline;
}
</style>

</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<aside class="aside">
			<nav class="nav">
				<ul class="nav_list" style="background-color:#F0B594;height:100%">
					<h2>
						<a>管理者專區</a> <br> <a>問題處理</a> <br> <a>商品管理</a> <br>
						<a>訂單管理</a> <br> <a>會員管理</a> <br> <a>帳務管理</a> <br>
						<a>會員審核</a> <br> <a>專案專區</a>
					</h2>
					<form action="/TFA104G1/ManagerServlet" method="post" >
				<button class="signOut" type="submit">sign out</button>
				<input type="hidden" name="action" value="sign_out" />
				</form>
				</ul>
			</nav>
		</aside>
		<main class="main" style="background-color:#C0C0C0;">					

			<h3>資料查詢:</h3>

			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>

			<ul>
				<li><a
					href='<%=request.getContextPath()%>/back_end/manager/listAll.jsp'>管理員列表</a><br>
				<br></li>


				<li>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/ManagerServlet">
						<b>輸入管理者編號 :</b> <input type="text" name="managerID"> <input
							type="hidden" name="action" value="getOne_For_Display"> <input
							type="submit" value="送出">
					</FORM>
				</li>

				<jsp:useBean id="msSvc" scope="page"
					class="com.manager.model.ManagerService" />

				<li>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/ManagerServlet">
						<b>選擇管理員編號:</b> <select size="1" name="managerID">
							<c:forEach var="managerVO" items="${msSvc.all}">
								<option value="${managerVO.managerID}">${managerVO.managerID}
							</c:forEach>
						</select> <input type="hidden" name="action" value="getOne_For_Display">
						<input type="submit" value="送出">
					</FORM>
				</li>

				<li>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/ManagerServlet">
						<b>選擇管理員姓名:</b> <select size="1" name="managerID">
							<c:forEach var="managerVO" items="${msSvc.all}">
								<option value="${managerVO.managerID}">${managerVO.managerName}
							</c:forEach>
						</select> <input type="hidden" name="action" value="getOne_For_Display">
						<input type="submit" value="送出">
					</FORM>
				</li>
			</ul>


			<h3>管理員管理</h3>

			<ul>
				<li><a href='<%=request.getContextPath()%>/back_end/manager/addManager.jsp'>新增管理員</a></li>
			</ul>
			
		</main>
	</div>
	
</body>
</html>