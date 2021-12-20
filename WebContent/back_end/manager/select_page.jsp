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
</style>

</head>
<body bgcolor='white'>

	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" >					

			<h3>管理員查詢:</h3>

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
				<li>
					<a href='<%=request.getContextPath()%>/back_end/manager/listAll.jsp'><h2>管理員列表</h2></a><br>
				</li>				
				<li>
					<a href='<%=request.getContextPath()%>/back_end/manager/addManager.jsp'><h2>新增管理員</h2></a><br>
				</li>
				<li>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/ManagerServlet">
						<b>輸入管理者編號 :</b> 
						<input type="text" name="managerID"> 
						<input type="hidden" name="action" value="getOne_For_Display"> 
						<input type="submit" value="送出">
					</FORM>
				</li>
					<jsp:useBean id="msSvc" scope="page" class="com.manager.model.ManagerService" />
				<li>
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/ManagerServlet">
						<b>選擇管理員編號:</b> 
						<select size="1" name="managerID">
							<c:forEach var="managerVO" items="${msSvc.all}">
								<option value="${managerVO.managerID}">${managerVO.managerID}
							</c:forEach>
						</select> 
						<input type="hidden" name="action" value="getOne_For_Display">
						<input type="submit" value="送出">
					</FORM>
				</li>
				<li>
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/ManagerServlet">
						<b>選擇管理員姓名:</b> 
						<select size="1" name="managerID">
							<c:forEach var="managerVO" items="${msSvc.all}">
								<option value="${managerVO.managerID}">${managerVO.managerName}
							</c:forEach>
						</select> 
						<input type="hidden" name="action" value="getOne_For_Display">
						<input type="submit" value="送出">
					</FORM>
				</li>
			</ul>			
		</main>
	</div>	
</body>
</html>