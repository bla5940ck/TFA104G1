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

	<div>
	<br>
		<br>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; text-align: center; font-size: 24pt">
			<span
				style="font-family: '微軟正黑體'; font-weight: bold; color: #333333; background-color: #ffffff">網站理念</span>
		</p>
		<br>
		<br>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span
				style="font-family: '微軟正黑體'; font-weight: bold; color: #333333; background-color: #ffffff">你是否有產生這種想法的時候呢
				. . . ?</span><br />
			<span
				style="font-family: '微軟正黑體'; font-weight: bold; color: #333333; background-color: #ffffff">當看到新遊戲上市，想玩只能看廣告過過乾癮，</span><br />
			<span
				style="font-family: '微軟正黑體'; font-weight: bold; color: #333333; background-color: #ffffff">想買新主機，但是錢包不允許
				. . .</span><br />
			<span
				style="font-family: '微軟正黑體'; font-weight: bold; color: #333333; background-color: #ffffff">遊戲破關後，就收藏在電視櫃中，大掃除時又捨不得丟
				. . .</span><br />
			<span
				style="font-family: '微軟正黑體'; font-weight: bold; color: #333333; background-color: #ffffff">因此我們想提供一個，讓玩家們能花小錢體驗不同類型的娛樂商品，也能產生收益的租賃平台。</span><br />
			<span
				style="font-family: '微軟正黑體'; font-weight: bold; color: #333333; background-color: #ffffff">並透過我們得到交易安全的保障。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: Calibri">&#xa0;</span>
		</p>
	</div>




							<br> <br>
							<center>
								<a class="aa-browse-btn"
									href="/TFA104G1/front_end/product/homePage.jsp"><span
									class="fa fa-long-arrow-left"></span>&nbsp&nbsp&nbsp回首頁</a>
							</center>
							<br> <br>
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