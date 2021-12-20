<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<style>

	input.memberId {
  			background-color: lightgray;
	}
	
</style>


<body>
		<%@ include file="/includeFolder/header.file"%>
<!-- 錯誤表列 -->


<!-- / catg header banner section -->

<!-- Cart view section -->
	<section id="aa-myaccount">
		<div class="container">
			<div class="row" id="row1">
				<div class="col-md-12" id="col-md-12">
<!-- 					<div class="aa-myaccount-area" id="aa-myaccount-area"> -->
						<div class="row" id="row2">
							<!--<div class="col-md-6" id="col-md-6"> -->
								<div class="aa-myaccount-login" id="aa-myaccount-login">
		<br>
		
		<br>
		<h2>承租流程</h2>
		<img alt="承租流程" src="img/rent.jpg">
		<br>
		<br>
		<h2>承租流程</h2>
		<img alt="出租流程" src="img/lease.jpg">
		<br>
	<br>
								</div>
<!-- 						</div> -->
						</div>
					</div>
				</div>
			</div>
<!-- 		</div> -->
	</section>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
</html>