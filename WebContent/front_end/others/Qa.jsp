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
		<p
			style="margin-top: 12pt; margin-bottom: 0pt; text-align: center; font-size: 28pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">Q&amp;A</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">一</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">.</span><span
				style="width: 8.95pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">什麼</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">是樂借所</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">?</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">樂借所</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">是個整合人與人之間物品租借的網路平台，提供用戶「將所擁有的自有
			</span><span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">
				物品上架出租」及「搜尋指定物件並租借」雙向的服務，讓物品發揮最大化的利用，以滿足出租</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">與承租雙方的需求。</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">二.</span><span
				style="width: 8.95pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">我能出租什麼樣的物品? </span><span
				style="width: 15.24pt; display: inline-block">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">在樂借所</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">上主要出租各種類的遊戲主機、軟體</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">及桌遊</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">，可上架出租給其他會員用戶。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">用戶所上架之物品及內容皆不得違反法律之規範，若有觸犯或觸及之疑慮，本平台將會將物品強制下架並向該用戶提出警告。</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">三.</span><span
				style="width: 8.95pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">為什麼需要</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">實名制登入</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">?</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">實名制之</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">登記方式可以有效的保障出租方及承租方之權益，確保用戶之間在款項交易及物品損壞或遺失等意外發生時，雙方皆有法律之效益，在租借行為上得到最大的保障及安心感。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">如有用戶之行為違反服務規範及會員條款或法律條文時，亦可有效的停權並隔絕該類用戶重複登記之使用權限，</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">提高樂借所</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">平台內所有用戶群的安全度及水平，打造舒適且安心的共享租借生活圈。</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">四.</span><span
				style="width: 8.95pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">為什麼我的帳戸被封鎖了?</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 16pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-size: 12pt; font-weight: bold">如有帳戶被封鎖之狀況發生時，可能在您過去上架之物品及內容或交易過程中曾違反服務條款及會員契約或法律條文。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">您可查閱會員登記之E-mail，由官方所寄送之停權通知。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">若欲解除帳號封鎖，請洽官方客服E-mail提出申請，並針對封鎖原因進行說明。</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 16pt">
			<span
				style="font-family: '微軟正黑體'; font-size: 12pt; font-weight: bold">五</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">.</span><span
				style="width: 7.93pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-size: 12pt; font-weight: bold">評價系統是如何運作?</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">在每次完成租借並且歸還物品後，將會進行雙方用戶對彼此的評價。出租方可以對承租方進行評價，而承租方則可對該次租借的物品及出租方進行評價。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">利用樂借所</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">完善的評價制度，讓您輕鬆簡單的了解其他用戶及架上物品的滿意程度，讓您在選擇物品及交易對象時能夠更加安心。</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">六.</span><span
				style="width: 8.95pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">物品上架是否需要費用?</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">在樂借所</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">上架物品不需要任何上架費用。</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">七.</span><span
				style="width: 8.95pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">如果歸還的物品損壞了，
				要怎麼賠償？ 是否需要押金？</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">樂借所</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">設有物品損壞賠償的費率基準。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">損壞賠償費分成以下等級:</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">1</span><span
				style="font-family: '微軟正黑體'; font-size: 10pt; font-weight: bold">.
				外觀損壞(功能正常)，支付押金之50%費用。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-size: 10pt; font-weight: bold">2.
				功能失效，支付押金之100%費用。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">出租方及承租方於歸還物品當下確認物品損壞之等級，遵照雙方所同意之費率，承租方即以信用卡支付損壞賠償費於出租方。</span><span
				style="font-family: '微軟正黑體'; font-size: 10pt; font-weight: bold">
			</span><span style="font-family: '微軟正黑體'; font-weight: bold"> </span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">如租借雙方有違背誠信之個人行為，在成立訂單時租借雙方已同意如有物品損傷情況，經由公司審查後可由平台要求</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">第三方金流</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">單位直接以信用卡支付損壞賠償費的金額。</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span
				style="font-family: '微軟正黑體'; font-size: 10pt; font-weight: bold">八</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> . </span><span
				style="width: 4.95pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">如果我取消租借訂單，取消的退款金額怎麼算？</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span><span
				style="width: 14.67pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-size: 11pt; font-weight: bold">所有訂單在用戶送出後，</span><span
				style="font-family: '微軟正黑體'; font-size: 11pt; font-weight: bold">一</span><span
				style="font-family: '微軟正黑體'; font-size: 11pt; font-weight: bold">直到出租者寄出物品前都可以取消</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">。</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">九.</span><span
				style="width: 8.95pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">訂單完成後，
				什麼時候能收到款項？</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">該月份所完成的交易款項將於該月份最後一日結算，並於次月的10日撥款至您所設定之指定帳戶。</span>
		</p>
		<p style="margin-top: 12pt; margin-bottom: 12pt; font-size: 12pt">
			<span style="width: 24pt; display: inline-block">&#xa0;</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">(遇假日或不可抗力之因素順延)</span><span
				style="width: 3.57pt; display: inline-block">&#xa0;</span>
		</p>
		<p style="margin-top: 0pt; margin-bottom: 0pt; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'">&#xa0;</span>
		</p>
			
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

