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
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"
	"type="text/javascript"></script>
<style>
* {
	box-sizing: border-box;
	text-decoration: none;
	list-style: none;
}

body {
	margin: 0;
	padding: 10px;
}

img {
	max-width: 100%;
}

header.header {
	background-color: #ddd;
	width: 100%;
	margin: 0 auto 10px auto;
	border: 1px solid #999;
}

@media all and (min-width:576px) and (max-width:767.98px) {
	header.header {
		width: 540px;
	}
}

@media ( max-width :575.98px) {
	header.header {
		width: 100%;
	}
}

div.main_content {
	width: 100%;
	margin: 0 auto;
	font-size: 0;
	/*   border:1px solid red; */
}

@media all and (min-width:576px) and (max-width:767.98px) {
	div.main_content {
		width: 540px;
	}
}

@media ( max-width :575.98px) {
	div.main_content {
		width: 100%;
	}
}
/*-------------------aside區域------------------- */
aside.aside {
	background-color: #ddd;
	width: 200px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: #ddd;
	width: calc(100% - 200px - 10px);
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

@media ( max-width : 575.98px) {
	aside.aside, main.main {
		display: block;
	}
	aside.aside {
		width: 100%;
		margin: 0 0 10px 0;
	}
	main.main {
		width: 100%;
	}
}

footer.footer {
	background-color: #ddd;
	width: 100%;
	margin: 10px auto 0 auto;
	border: 1px solid #999;
}

@media all and (min-width:576px) and (max-width:767.98px) {
	footer.footer {
		width: 540px;
	}
}

@media ( max-width :575.98px) {
	footer.footer {
		width: 100%;
	}
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

#preview {
	border: 1px solid lightgray;
	display: inline-block;
	width: 100px;
	min-height: 150px;
	position: relative;
}

#preview span.text {
	position: absolute;
	display: inline-block;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	z-index: -1;
	color: lightgray;
}

#preview img.preview_img {
	width: 100%;
}

img.preview {
	width: 100%;
}
</style>

</head>
<body bgcolor='white'>
<%@ include file="/includeFolder/header.file"%>
	<%-- -- <table id="table-1">
		<tr>
			<td>
				<h3>會員註冊 - MemRegister.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/front_end/member/Suss.jsp"><img
						src="<%=request.getContextPath()%>/front_end/member//img/LogingPIC.jpg" width="100"
						height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table> --%>

	

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

<section id="aa-myaccount">
		<div class="container">
			<div class="row" id="row1">
				<div class="col-md-12" id="col-md-12">
<!-- 					<div class="aa-myaccount-area" id="aa-myaccount-area"> -->
						<div class="row" id="row2">
							<!--<div class="col-md-6" id="col-md-6"> -->
								<div class="aa-myaccount-login" id="aa-myaccount-login">
								<h1>會員註冊</h1>


	<FORM class="aa-login-form" METHOD="post" enctype="multipart/form-data"
		ACTION="<%=request.getContextPath()%>/member/MemRegServlet"
		name="form1">
	<%-- 	<FORM METHOD="post" enctype="multipart/form-data"
		ACTION="<%=request.getContextPath()%>/member/MemRegServlet"
		name="form1">--%>
		

			<label for="">請輸入姓名<span>*</span></label> 
			<input type="text"
				name="name" placeholder="請輸入姓名"> <br> 
			<label for="">請輸入帳號<span>*</span></label>
			<input type="text" name="loginId" placeholder="請輸入帳號"> <br>
			<label for="">請輸入密碼<span>*</span></label> 
			<input type="password"
				name="password" placeholder="請輸入密碼"> <br> 
			<label for="">身分證字號<span>*</span></label>
			<input type="text" name="idcn" placeholder="請輸入身分證字號"> <br>
			<label for="">生日<span>*</span></label> 
			<input name="birthday"
				name="birthday" id="f_date1" type="text"> <br> <label
				for="">手機號碼<span>*</span></label> <input type="text" name="phoneNum"
				placeholder="請輸入手機號碼"> <br>

		
			<label for="">請輸入Email<span>*</span><br></label>
			<input type="text"  name="email" placeholder="請輸入Email"> 
			
			
			<label for="">請輸入郵遞區號<span>*</span></label> 
			<input type="text"
				name="addNum" placeholder="請輸入郵遞區號">
			
				 <br> 
			<div id="twzipcode"></div>
			<label for="">縣市行政區<span>*</span></label>
			<input type="text" name="add" placeholder="關聯郵遞區號預設帶入"> <br>
			<label for="">請輸入地址<span>*</span></label> 
			<input type="text"
				name="address" placeholder="請輸入地址"> <br>
			
			
			
			
			<div id="T" style="width:600px; height:auto; float:left; display:inline">
				 請上傳身分證正面:
				 <input type="file" class="file" accept="image/gif, image/jpeg, image/png" onchange="showPic(this.value);" value="idc_F"id='file_id1' name='file_name1'><br> <br> 
				<div id="preview1"
				style="text-align: center;width:300px; height:250px;border: 3px #cccccc dashed; ">
				<span class="text" style="text-align: center;">預覽圖</span>
				</div>
			</div>
			<div id="T" style="width:600px; height:auto; float:left; display:inline">
				請上傳身分證反面:
				<input type="file" class="file" accept="image/gif, image/jpeg, image/png" onchange="showPic(this.value);" value="idc_B"id='file_id2' name='file_name2'><br> <br>
				<div id="preview2" 
				style= "text-align: center;width:300px; height:250px;  border: 3px #cccccc dashed; ">
				<span class="text" style=”text-align: center;” >預覽圖</span>
				</div>
			</div>
				
				
		
	<!--  <FORM class="aa-login-form" >
		<div>

			<div id="preview1"
				style="text-align: center;width:300px; height:250px;border: 3px #cccccc dashed; ">
				<span class="text" style="text-align: center;">預覽圖</span>
			</div>
			<div id="preview2" 
				style= "text-align: center;width:300px; height:250px;  border: 3px #cccccc dashed; ">
				<span class="text" style=”text-align: center;” >預覽圖</span>
			</div>
		</div>
	</FORM> -->
			
			<hr>
			<div class="text-center">
				<a class="small" href="ForgetPW.jsp" >Forgot Password?</a>
			</div>
			<div class="text-center">
				<a class="small" href="LeaseLogin.jsp">Already have an account?
					Login!</a>
			</div>
			<input type="hidden" name="action" value="insert"> <input
				type="submit" value="註冊">
	</FORM>
</div>
<!-- 						</div> -->
						</div>
					</div>
				</div>
			</div>
<!-- 		</div> -->
	</section>
	


	<br>

<%@ include file="/includeFolder/footer2.file"%>
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
-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<script>
$("#twzipcode").twzipcode();
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
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
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
</html>