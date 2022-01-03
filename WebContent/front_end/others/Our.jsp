<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>團隊介紹</title>
</head>
<style>
input.memberId {
	background-color: lightgray;
}

body {
	display: grid;
	grid-template-areas: "header header header" "nav section aside"
		"footer footer footer";
	/* 	grid-template-rows: 80px 1fr 50px; */
	grid-template-columns: 20% 60% 20%;
	grid-gap: 5px;
	height: 100vh;
	margin: 10px;
}

header {
	grid-area: header;
}

nav {
	grid-area: nav;
	margin-left: 45px;
}

section {
	grid-area: section;
	text-align: center;
	font-family: helvetica;
}

aside {
	grid-area: aside;
	margin-left: 15px;
}

footer {
	grid-area: footer;
}


</style>

<body>
	<header>
		<%@ include file="/includeFolder/header.file"%>
	</header>

<nav>
<br>
<br>
<br>
<img style= "weight: 170px; height: 136px;" src="<%=request.getContextPath()%>/includeFolder/img/hwa.png">
<h2>廖勁驊</h2>
<img style= "weight: 170px; height: 136px;" src="<%=request.getContextPath()%>/includeFolder/img/sam.png">
<h2>王勝平</h2>
<img style= "weight: 170px; height: 136px;" src="<%=request.getContextPath()%>/includeFolder/img/cheng.png">
<h2>江宇晟</h2>
</nav>

<section>
		
		<br>
		<center><h2>團隊介紹</h2></center>
		
		<center><img alt="基紐特戰隊"  style= "weight: 700px; height: 532px;" src="<%=request.getContextPath()%>/includeFolder/img/our.jpg"></center>
	<center><img alt="比對圖"  style= "weight: 700px; height: 527px;" src="<%=request.getContextPath()%>/includeFolder/img/compare.jpg"></center>
	
	
	<br>
	<br>

	<center><a class="aa-browse-btn" href="javascript:history.back()"><span class="fa fa-long-arrow-left"></span>&nbsp&nbsp&nbsp回上一頁</a></center>							<br>
	<br>
</section>
	
	<aside>
	<br>
<br>
<br>
	<img style= "weight: 170px; height: 136px;" src="<%=request.getContextPath()%>/includeFolder/img/ian.png">
	<h2>林家祥</h2>
	<img style= "weight: 170px; height: 136px;" src="<%=request.getContextPath()%>/includeFolder/img/ming.png">
	<h2>孫浣茗</h2>
	<img style= "weight: 170px; height: 136px;" src="<%=request.getContextPath()%>/includeFolder/img/wei.png">
	<h2>林昊葳</h2>
	</aside>
	
	<footer>
		<%@ include file="/includeFolder/footer2.file"%>
	</footer>
</body>
</html>