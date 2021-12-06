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
	width: 450px;
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
<style>
@import "bourbon";

body {
	background: #eee !important;
}

.wrapper {
	margin-top: 80px;
	margin-bottom: 80px;
}

.form-signin {
	width: 100%;
	height: 100%;
	margin: 0 auto;
	background-color: #fff;
	border: 1px solid rgba(0, 0, 0, 0.1);
}

.form-control {
	position: relative;
	font-size: 16px;
	height: auto;
	padding: 10px;
	@
	include
	box-sizing(border-box);
	&:
	focus
	{
	z-index
	:
	2;
}

}
input[type="text"] {
	width: 50%;
	margin-bottom: -1px;
	border-bottom-left-radius: 0;
	border-bottom-right-radius: 0;
	margin-bottom: -1px;
}

input[type="password"] {
	width: 50%;
	margin-bottom: 20px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}

.login {
	width: 50%;
	font-size: 13px;
	outline-width: 100%;
	background-color: #6495ed;
}
</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<aside class="aside">
			<ul class="nav_list" style="background-color: #F0B594; height: 100%">
				<h2>
					<a>管理者專區</a> <br> <a>問題處理</a> <br> <a>商品管理</a> <br>
					<a>訂單管理</a> <br> <a>會員管理</a> <br> <a>帳務管理</a> <br> <a>會員審核</a>
					<br> <a>專案專區</a>
				</h2>
				
			</ul>
		</aside>
		<main class="main" style="background-color: #C0C0C0;">

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
				<h2 class="form-signin-heading">Please login</h2>
				<form action="/TFA104G1/ManagerServlet" method="post" >
				<input type="text" class="form-control" name="managerUser"	placeholder="user" /> 
				<input type="password" class="form-control"	name="managerPassword" placeholder="Password" />
				<button class="login" type="submit">Login</button>
				<input type="hidden" name="action" value="login" />
				
				
				
				</form>
			</div>

		</main>
	</div>
</body>
</html>