<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
%>


<html>
<head>
<meta charset="UTF-8">
<title>會員註冊 MemRegister.jsp</title>
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"type="text/javascript"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>



</head>
<body bgcolor='white'>

<%@ include file="/includeFolder/header.file"%>
<section id="aa-myaccount">
		<div class="container">
			<div class="row" id="row1">
			<div class="col-md-12" id="col-md-12">
					<div class="aa-myaccount-area" id="aa-myaccount-area">
						<div class="row" id="row2">
							<!--<div class="col-md-6" id="col-md-6"> -->
								<div class="aa-myaccount-login" id="aa-myaccount-login">
								
	<h1>會員註冊</h1>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM  class="aa-login-form" METHOD="post" enctype="multipart/form-data"
		ACTION="<%=request.getContextPath()%>/member/MemRegServlet"
		name="form1">



			<label for="">姓名<span>*</span></label> 
			<input type="text"
				name="name" placeholder="請輸入姓名"> <br> 
			<label for="">登入帳號<span>*</span></label>
			<input type="text" name="loginId" placeholder="請設置登入帳號"> <br>
			<label for="">登入密碼<span>*</span></label> 
			<input type="password"
				name="password" placeholder="請輸入密碼"> <br> 
			<label for="">身分證號<span>*</span></label>
			<input type="text" name="idcn" placeholder="請輸入身分證號"> <br>
			<label for="">生日<span>*</span></label> 
			<input name="birthday"
				name="birthday" id="f_date1" type="text"> <br> <label
				for="">手機號碼<span>*</span></label> <input type="text" name="phoneNum"
				placeholder="請輸入手機號碼"> <br> 
			<label for="">請輸入Email<span>*</span></label>
			<input type="text" name="email" placeholder="請輸入Email"> <br>

			<label for="">縣市行政區<span>*</span></label>	 <br>
			  <div id="twzipcode"></div> 
			<label for="">請輸入地址<span>*</span></label> 
			<input type="text"
				name="address" placeholder="請輸入地址"> <br>
				
				 	
				  
				 請上傳身分證正面:
				 <input type="file" class="file" accept="image/gif, image/jpeg, image/png" onchange="showPic(this.value);" value="idc_F"id='file_id1' name='file_name1'><br> <br> 
		<div>
				請上傳身分證反面:
				<input type="file" class="file" accept="image/gif, image/jpeg, image/png" onchange="showPic(this.value);" value="idc_B"id='file_id2' name='file_name2'><br> <br>
		</div>
			<div><h1>圖片預覽</h1></div>

			<div id="preview1"
				style="text-align: center;width: 300px; height: 250px; border: 3px #cccccc dashed;float:left; display:inline">
				<span class="text"style=”text-align: center;”>預覽圖 </span>
			</div>
			<div style="width: 20px; height: 250px; float:left; display:inline"></div>
			
			<div id="preview2"
				style="text-align: center;width: 300px; height: 250px; border: 3px #cccccc dashed;float:left;display:inline">
				<span class="text"style=”text-align: center;”>預覽圖 </span>
			</div>
			<div style="width: 20px; height: 250px; "></div>
			<hr>
			<!--  
			<div class="text-center">
				<a class="small" href="ForgetPW.jsp" style="color:#191561;">Forgot Password?</a>
			</div>
			-->
			
			<input type="checkbox" name="chbox" > 
			<span>欲成為JoyLease會員時，請詳閱</span>
			<a  style="color:#191561;" href="<%=request.getContextPath()%>/front_end/others/Terms.jsp" target="_blank">【服務條款及會員契約】</a>
			<span> . </span>
			<a style="color:#191561;" href="<%=request.getContextPath()%>/front_end/others/Privacy.jsp" target="_blank">【隱私權政策】</a>
			<span> 點選註冊表示您同意條款所有內容 。 </span>
			<br>
			<br>
			<div class="text-center">
				<a class="small" href="LoginForgetPW.jsp" style="color:#191561;">已經有帳號?登入!</a>
			</div>
			
			<input   type="hidden" name="action" value="insert"> 
			<input class="aa-browse-btn"	type="submit" value="註冊">
	</FORM>
	
			
	
	 							</div>
				<!--		</div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>



	<br>

<%@ include file="/includeFolder/footer2.file" %>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<%
	java.sql.Date birthday = null;
	try {
		birthday = memberVO.getBirthday();
	} catch (Exception e) {
		birthday = new java.sql.Date(System.currentTimeMillis());
	}
%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>
 <!-- jQuery library -->
  <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
--><script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=birthday%>', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

	//      1.以下為某一天之前的日期無法選擇
	//      var somedate1 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      2.以下為某一天之後的日期無法選擇
	//      var somedate2 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
	//      var somedate1 = new Date('2017-06-15');
	//      var somedate2 = new Date('2017-06-25');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//		             ||
	//		            date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	$("#file_id1").change(
				function() {
					$("#preview1").html(""); // 清除預覽
					var fileCount = this.files.length;
					$("#fileCount").val(fileCount);
					if (this.files.length > 2) {
						alert("最多只能選兩張圖片喔");
						$("#file_id1").val("");
						$("#preview1").html("<span class='text'>預覽圖</span>");
					} else {

						if (this.files && this.files.length >= 0) {
							for (var i = 0; i < this.files.length; i++) {
								var reader = new FileReader();
								reader.onload = function(e) {
									var img = $("<img class = 'preview_img'>")
											.attr('src', e.target.result);
									$("#preview1").append(img);
								}
								reader.readAsDataURL(this.files[i]);
							}
						}
					}

				});

		$("#file_id2").change(
				function() {
					$("#preview2").html(""); // 清除預覽
					var fileCount = this.files.length;
					$("#fileCount").val(fileCount);
					if (this.files.length > 2) {
						alert("最多只能選兩張圖片喔");
						$("#file_id2").val("");
						$("#preview2").html("<span class='text'>預覽圖</span>");
					} else {

						if (this.files && this.files.length >= 0) {
							for (var i = 0; i < this.files.length; i++) {
								var reader = new FileReader();
								reader.onload = function(e) {
									var img = $("<img class = 'preview_img'>")
											.attr('src', e.target.result);
									$("#preview2").append(img);
								}
								reader.readAsDataURL(this.files[i]);
							}
						}
					}

				});
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<script>
$("#twzipcode").twzipcode({
//	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在地區
	css: ["city form-control", "town form-control"], // 自訂 "城市"、"地區" class 名稱 
	countyName: "city", // 自訂城市 select 標籤的 name 值
	districtName: "town" // 自訂地區 select 標籤的 name 值
	});


</script>

</html>