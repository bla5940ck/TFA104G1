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
		網站理念

<br>
你是否有產生這種想法的時候呢 . . . ?
<br>
當看到新遊戲上市，想玩只能看廣告過過乾癮，
<br>
想買新主機，但是錢包不允許 . . .
<br>
遊戲破關後，就收藏在電視櫃中，大掃除時又捨不得丟 . . .

<br>
因此我們想提供一個，讓玩家們能花小錢體驗不同類型的娛樂商品，也能產生收益的租賃平台。並透過我們得到交易安全的保障。


		
		<br>
	<br>
	<center><a class="aa-browse-btn" href="/TFA104G1/front_end/product/homePage.jsp"><span class="fa fa-long-arrow-left"></span>回首頁</a></center>
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