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
<title>服務條款及會員契約</title>
<style>

	input.memberId {
  			background-color: lightgray;
	}

        .shuffle_text {
            padding: 5% 5%;
            color: black;
            font-family: '微軟正黑體';
            font-weight: bold;
            line-height: 1.8em;
        }

        .rand_text {
            color: white;
            background-color: #555;
        }

        .yet_text {
            color: #2a2a2a;
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
							<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dat-gui/0.5/dat.gui.min.js" type="text/javascript"></script>
    <script>
    $(function(){
        // shaffle text
        var _runingShuffleEffects = "";               // for dat.gui
        var _ele = $('.shuffle_text');
        var _strDefault = _ele.text(); // for dat.gui
        var _shuffleEffectQueue = [];
        var _initDuration = 30; //速度 1-100,越小越慢

        
        jQuery.fn.extend({
        shuffleEffect: function(duration) {
          if(duration == null) duration = 50;
          var $this = jQuery(this);
          var strDefault = $this.text();
          var nLength = strDefault.length - 1;
          var i = 0;
          var strText = "";
          var tid = setInterval(function(){
            _runingShuffleEffects = tid;
            if(i < nLength+1){
              var slicedText = strDefault.slice(i+1,nLength);
              var textYet = strDefault.slice(i,nLength);
              // [" ", ".", "、", "。", "　"]
              var term = slicedText.match(/[^ \.、。　]+/g);
              var termRand = "";
              var strShuffle = "";
              if(term != null){
                termRand = term[0].split("").sort(function() {
                  return Math.random() - 0.5;
                });
                strShuffle = termRand.join("");
              }
              strText += strDefault.charAt(i);
              $this.css({opacity:1}).html(strText + "<span class='rand_text'>" + strShuffle + "</span><span class='yet_text'>" + textYet + "</span>");
                i++;
            } else {
              _runingShuffleEffects = "";
              _shuffleEffectQueue.shift().shuffleEffect(duration);
              clearInterval(tid);
            }
          }, duration);
        }});
        
      
        // dat.gui 
        var Setting = function(){
          this.duration = _initDuration;
        }
        var _setting = new Setting();
//         控制bar調整        
//         var gui = new dat.GUI();
//         gui.add(_setting, 'duration',1,100).onFinishChange(function(value){
//           init();
//         });
        
        var init = function(){
          _shuffleEffectQueue = [];
          if(_runingShuffleEffects != ""){
            // init
            clearInterval(_runingShuffleEffects);
            _runingShuffleEffects = "";
          }
          // run
          _ele.find("p").each(function(){
            var $this = jQuery(this);
            $this.css({opacity:0});
            _shuffleEffectQueue.push($this);
          });
          _shuffleEffectQueue.shift().shuffleEffect(_setting.duration);
      //  _ele.shuffleEffect(_setting.duration);
        };
        init();
      })
      </script>
     <div class="shuffle_text">

		<p
			style="margin-top: 0pt; margin-bottom: 0pt; text-align: center; widows: 0; orphans: 0; font-size: 26pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">服務條款及會員契約</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; text-align: center; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">本服務條款及會員契約係為規範樂借所(下稱本平台)、使用平台會員之權利及義務，及會員間使用樂借所軟體租賃之規定，俾利彼此共同遵守</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•會員註冊</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">員應提供本平台要求註冊樂借所平台會員所需之一切資料(包含身分證件，詳參見第二條規定)，經本平台審核通過後，始具備會員資格使用樂借所。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">至於本平台審核會員之條件，由本平台自行認定，申請者不得異議。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">3.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員之帳號、密碼不得提供予他人使用。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">4.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">本平台得限制同一自然人申請註冊之會員帳號數量。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•會員資料</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員為自然人者必須提供真實姓名、實拍照片、身分證統一編號、出生日期、聯絡電話、聯絡地址、電子郵件信箱、銀行帳戶信用卡資訊。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員同意就其使用樂借所平台之交易資訊，均授權予本平台使用於金融交易授權、市場分析及本平台相關業務之開發。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">3.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">本平台除因法律另有規定、緊急情況、維護會員及第三人之合法權益，或經會員之同意外，不會向第三人揭露會員之相關資料。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•會員服務</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">樂借所平台為提供網路租賃物品之平台服務，會員得上傳出租物件之資料、承租需求之資料於樂借所平台。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">經由樂借所平台所進行之租賃，本公司不負任何擔保責任。若發生爭議，除本契約另有規定外，會員應自行協調、解決。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">3.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">若本平台對會員上傳之資料具有疑義，會員應向本平台說明或提供相關資料。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">4.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">本平台不負擔會員因樂借所平台進行之租賃而生之稅賦。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">5.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">本平台得寄送有關樂借所平台之各項資訊予會員。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">6.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">本</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">平台因進行維護致無法提供服務時，本平台將事先以電子郵件或公告之方式告知會員。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•會員使用</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">自然人會員僅能使用自己之帳號登入樂借所平台系統，且不得將帳號移轉予他人或授權他人使用。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員使用樂借所平台上傳出租物件資訊時，應擔保有出租該商品之權利。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">3.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員應據實說明其使用樂借所平台上傳出租物件之資訊，不得有匿、飾、增、減之不實情形。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">4.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員使用樂借所平台上傳出租物件之資訊，應選擇物品類別，並輸入物品名稱、介紹、出租之日期、日租金價格設定、損害賠償費、選擇物品出租位置之範圍等，並設定收款帳號資料。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">5.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員使用樂借所平台上傳出租物件或承租資訊時，其內容不得有違反法令之虞。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">6.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員僅得以樂借所平台作為動產租賃之平台，惟不包括汽、機車(包含掛牌上路之電動車)，且不得於其上上傳有關不動產及汽、機車(包含掛牌上路之電動車)之出租或承租資訊</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">7.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員使用樂借所平台承租租賃物件，不得將該承租之租賃物件出售、轉租、設定權利予他人。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">8.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員使用樂借所平台上傳出租物件或承租資訊時，不得存有本平台認為不適合之訊息。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">9.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">出租物件之會員應於欲承租之會員提出承租請求(包含載明交付租賃物之時間)後24小時內回應。該承租請求經出租會員確認及付款後，訂單始告成立，並由本平台指定之第三方支付公司向承租之會員扣款，於承租之會員歸還租賃物件後，經本平台扣除出租會員應給付本平台之服務費用後每月結算撥予出租之會員；惟若扣款失敗，該訂單即失其效力。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">10.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員間使用樂借所平台進行租賃交易時，應依照會員於樂借所平台合意之時間交付、返還租賃物。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">11.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">若使用樂借所平台出租之會員未於原訂之時間、地點交付租賃物件，承租之會員應即回報通知客服並給予適當之評價。使用樂借所平台出租之會員未於原訂之時間交付租賃物件達3次，除本平台認有正當理由外，本平台得封鎖該會員之帳號。前開規定均無礙承租之會員另依法向該出租之會員為法律上之請求。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">12.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">使用樂借所平台承租之會員應於約定交付租賃物日前3日內(包括約定</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">交付租賃物日)取消訂單，再由本平台指定之第三方支付公司向承租之會員退還租金。若未並其於約定交付租賃物日前3日內(包括約定交付租賃物日)取消訂單，則須支付租金總額予出租租賃物件之會員。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">13.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員間使用樂借所平台進行租賃物件交付時，承租會員應立即檢查租賃物，若有租賃物件與出租之會員於樂借所平台上提供之資訊不符或有其他瑕疵之情形，承租之會員得無須經催告程序撤銷租賃訂單，並檢附租賃物件與出租會員上傳內容不符、瑕疵之照片向客服檢舉之；然雙方會員亦得於樂借所平台聊天處變更租賃物之現況而合意繼續租賃。惟承租之會員若於確認租賃物件後，除有不可抗力因素無從發現外，不得再行主張出租人存有與上傳內容不符之瑕疵或不完全給付責任。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">14.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員間使用樂借所平台進行租賃物交付時，若承租會員指出租賃物件有與出租資訊不符或有其他瑕疵之情形而不願確認並受領租賃物件時，出租之會員卻拒絕取消訂單、取回租賃物件：</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 40pt; margin-bottom: 0pt; text-indent: 24pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">一</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">.承租會員應即將該瑕疵之租賃物現況拍照上傳予客服審查，經客服審查確有前開瑕疵等情形，本平台得取消該訂單(訂單經取消即失效)，並退還款項予承租會員。該訂單遭取消後，若出租之會員拒絕取回租賃物件，嗣承租之會員應於3日內將該租賃物件寄至本平台，運送期間之危險負擔應由出租之會員承擔。一旦該租賃物件寄至本平台，承租會員即免除返還租賃物件予出租會員之義務。而本平台將於收到租賃物件後公告或通知出租會員至本平台領取該租賃物件，若出租會員遲至本公司通知之次日起算30日內未前往本平台領取該租賃物件，則該租賃物件無償歸本平台所有，出租會員不得異議。此外，於本平台保管期間，該租賃物品之危險負擔亦均由出租之會員承擔。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 40pt; margin-bottom: 0pt; text-indent: 24pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">二</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">.惟經客服審查並無承租之會員所指與出租資訊不符或之有其他瑕疵情形，該租賃訂單仍成立生效，縱承租會員拒絕受領租賃物件，仍不得請求退還租金。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">15.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">於租賃期滿後，使用樂借所平台承租之會員未於約定時間歸還租賃物件者，應自約定返還租賃物時間之次日起算至返還物品之日止，按日給付出租之會員該租賃物每日租金之1.5倍懲罰性違約金，並由本平台指定之第三方支付公司逕向承租之會員扣款，且若自約定返還租賃物時間之次日起算7日後，承租之會員仍未返還租賃物予出租之會員，承租之會員除應給付前開7日之懲罰性違約金外，尚須給付出租之會員於平台上載該租賃物之押金，且本公司得不經催告程序由本公司指定之第三方支付公司逕向</span><span
				style="font-family: '微軟正黑體'; font-weight: bold">承租之會員扣款並撥付出租之會員。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">16.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">若於返還租賃物時，使用平台出租之會員當日未依雙方約定之時間、地點到場，承租之會員應將租賃物移交本公司保管，且自租賃物移交本公司保管時，即免除返還租賃物予出租之會員之義務，而出租之會員即不得以租賃物有所損害而請求賠償或主張遲延之賠償。出租之會員若於租賃物移交本平台保管之30日內向本公司取回該租賃物，應按保管日數額外支付本公司每日訂單租金為保管費用。出租之會員若未於租賃物移交本公司之次日起算30日內向本公司取回，則由本平台無償取得該租賃物之所有權，出租之會員不得異議。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">17.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">於使用平台承租之會員返還租賃物時，出租會員應立即檢視租賃物是否受有損傷，若出租會員認租賃物件受有損傷，應由出租之會員及承租之會員先行協商損害之程度及賠償金額，若無法達成協商，出租之會員須立即上載租賃物品損傷之照片予客服，由客服判斷損害程度，決定承租會員就該損傷之賠償金額(惟不超過出租會員上傳之租賃物件價值)，承租會員及出租會員對於該損害之賠償金額，均同意由客服認定並由本平台指定之第三方支付公司予以扣款，不得異議。惟該租賃物品之損傷係因不可抗力因素或係正常耗損者，承租之會員不得請求損害賠償。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">18.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員如使用平台為租賃行為而有所得，會員應依據「網路交易課徵營業稅及所得稅規範」及「個人營利為駐地透過網路銷售貨物或勞務辦理營業登記作業說明」之規定繳納稅捐，而不由本公司負擔之。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•罰則</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員上傳之內容或交易之行為，經本平台認為具有違反法律或本服務條款及會員契約之虞，或有本平台認為不適合者，本平台均得逕予移除及為其他必要之措施，併停止該會員之資格、終止該會員之本服務條款及會員契約。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員在平台上傳規避給付本公司費用為目的之內容，本平台得逕予移除或採取其他必要措施。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">3.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員在平台上傳之內容涉及違反法令者，本平台得將之移送檢調機關偵查，並配合檢調及司法機關之偵查或審理。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">4.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員違反法律或本服務條款及會員契約所致之相關法律責任，逕由該會員自行承擔，概與本平台無涉。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•契約修改</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">本平台得隨時修改本服務條款及會員契約，修改之部分自本平台向會員公告時起生效。前述公告之方法，本平台得以電子郵件或於平台公告為之。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員於本平台公告修改之契約內容後，會員繼續使用平台即視為同意修改之內容。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•停止會員資格</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 24pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">會員於遭本平台停止會員資格後，該會員曾上傳至平台之資訊，本平台得予以刪除。但已與其他會員達成交易者，不再此限，本平台將另以訊息告知與之交易之會員，其有權取消該交易，而遭本公司停止會員資格者不得異議。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•平台責任</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">因不可歸責於本平台之事由(如平台進行維護及不可抗力因素等)，所導致無法提供服務等情形，除本平台之故意或重大過失所致者外，本平台不負賠償責任。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">如本平台依法應對會員負損害賠償責任，除因故意或重大過失所致者外，不得超出該會員該次給付予本平台之費用。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•授權事宜</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員未經本平台授權，不得使用、重製或散布平台內任何智慧財產權。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員一旦提供出租、承租物件之資料至平台，即視為將之授權本公司及平台使用，本平台得將之用於文宣、廣告等宣傳或行銷。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•其他</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; text-indent: 24pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">本服務條款及會員契約未盡之事宜，依中華民國法律予以補充。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">•準據法及管轄權</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">1.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">本服務條款及會員契約及其相關使用規範、辦法、處理原則、政策、及相關服務說明等，以中華民國法令為準據法。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-left: 20pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">2.</span><span
				style="font-family: '微軟正黑體'; font-weight: bold"> </span><span
				style="font-family: '微軟正黑體'; font-weight: bold">會員與本平台間因本服務、本服務條款及會員契約之爭議涉訟，以臺灣臺北地方法院為第一審管轄法院。</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
		<p
			style="margin-top: 0pt; margin-bottom: 0pt; widows: 0; orphans: 0; font-size: 12pt">
			<span style="font-family: '微軟正黑體'; font-weight: bold">&#xa0;</span>
		</p>
	
</div>
							
							<center><a class="aa-browse-btn" href="javascript:history.back()"><span class="fa fa-long-arrow-left"></span>&nbsp&nbsp&nbsp回上一頁</a></center>
							<br> <br>
						</div>

</div>
					</div>

				</div>
			</div>
		</div>
		</div>

	</section>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
</html>