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
<title>隱私權政策</title>
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
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; text-align: center; widows: 0; orphans: 0; font-size: 26pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">隱私權政策</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; text-align: center; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">一、本平台為保護會員之隱私權，就會員資料的蒐集、處理及利用，恪遵我國「個人資料保護法」及相關法規。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: 'MS Gothic'; font-weight: bold">​</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">二、本平台依善良管理人責任保護會員之隱私，除法律另有規定、緊急情況、維護會員或第三人之合法權益、會員同意外，本平台不會將會員資料向第三人揭露。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: 'MS Gothic'; font-weight: bold">​​</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">三、當使用者成為本服務之會員，其真實姓名、照片、身分證統一編號、出生日期、聯絡電話、聯絡地址、電子郵件信箱、信用卡資訊、銀行帳戶等資訊，</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">均將妥</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">適留存於本平台。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">四、當本服務之會員登錄帳號、密碼進入本服務平台時，本平台得蒐集會員之IP位置、交易記錄、收藏服務、信用卡卡號等資料，本平台將使用於金融交易授權、市場分析及本平台相關業務之開發，惟不會恣意向第三人揭露。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: 'MS Gothic'; font-weight: bold">​​</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">五、本服務會員之相關隱私資料，本平台僅於進行付款相關程序時，基於本平台與銀行、各服務提供業者的契約關係，依「個人資料保護法」的規定將會員的資料轉給信用卡收單銀行、提供服務的合作業者付款信用卡之發卡銀行。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: 'MS Gothic'; font-weight: bold">​​</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">六、本平台得將依據會員提供之資訊發送各項資訊至會員電子郵件信箱。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: 'MS Gothic'; font-weight: bold">​​</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">七、於交易爭議、行政及司法機關要求、執行本服務條款之需要、為維護本服務相關設備及軟體的正常運作與安全、或為保護其他第三人的合法權益，本平台得提供會員個人隱私資料予法院、行政機關、或提出適當證明主張其權利受侵之第三人。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: 'MS Gothic'; font-weight: bold">​</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">八、本服務所蒐集之會員資料或信用卡資訊，本平台將依法採取相關保護措施，並設有防火牆、防毒等各種資訊安全措施以保護會員資料安全，包括作業程序面、技術面及本平台人員的個人資料保護教育訓練，並簽有保密條款，以確保會員之隱私。</span>
		</p>
	<br>
	<br>
	<center><a class="aa-browse-btn" href="/TFA104G1/front_end/product/homePage.jsp"><span class="fa fa-long-arrow-left"></span>&nbsp&nbsp&nbsp回首頁</a></center>
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