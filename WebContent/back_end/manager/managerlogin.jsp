<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.manager.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Insert title here</title>
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
	background-image:url("<%=request.getContextPath()%>/includeFolder/img/OIP3.jpg");
	background-repeat:no-repeat;
	background-size: cover;
	opacity:1;
	width: 100%;
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

.login1{
width:30%;
height:30%;
background-color:white;
}

.wrapper{
text-align: center;
margin-top: 190px;
}

.form-signin-heading{
color:	white;
} 
.login{
background-color:#FFF0AC
}
</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
<!-- 		<aside class="aside"> -->
<!-- 			<ul class="nav_list"  height: 100%"> -->
				
				
<!-- 			</ul> -->
<!-- 		</aside> -->
	
		<main class="main"  >
<%-- 		<img src="<%=request.getContextPath()%>/includeFolder/img/OIP.jpg"> --%>

			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>

			<div class="wrapper">
				<h2 class="form-signin-heading">請登入</h2>
				<form action="/TFA104G1/ManagerServlet" method="post" >
				<input class="login1" type="text" class="form-control" name="managerUser"	placeholder="請輸入帳號" /> 
				<br>
				<input class="login1" type="password" class="form-control"	name="managerPassword" placeholder="請輸入密碼" />				
				<br>
				<button class="login" type="submit">登入</button>
				<input type="hidden" name="action" value="login" />
				
				
				
				</form>
			</div>

		</main>
	</div>
</body>
</html>