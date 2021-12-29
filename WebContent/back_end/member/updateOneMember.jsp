<%@page import="com.member.model.*"%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>

<%
MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
MemberService memSVC = new MemberService();


if(request.getAttribute("memberVO") == null){
	Integer memID = Integer.valueOf(request.getParameter("memberID"));
	memberVO = memSVC.getOneMember(memID);
}
	pageContext.setAttribute("memberVO", memberVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員資料修改</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://www.itxst.com/js/jquery.js"></script>
<script src="https://www.itxst.com/package/artDialog/artDialog.js"></script>
<link href="https://www.itxst.com/package/artDialog/skins/default.css"
	rel="stylesheet" />
<style>
body {
	margin: 0;
	padding: 10px;
}

img {
	max-width: 100%;
}

button {
	font-size: 13px;
	outline-width: 100%;
	background-color: white;
}

div.main_content {
	width: 100%;
	margin: 0 auto;
	font-size: 0;
}

/*-------------------aside區域------------------- */
aside.aside {
	width: 200px;	
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;	
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
	background-color:#F5D998;;
	height:720px;
}



/*--------------------main區域-------------------- */
main.main {
	background-color: 	#F0F0F0;
	width: calc(100% - 200px - 10px);
	height: 720px;
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
	color: red;
	display: inline;
}

table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	font-size: 10px;
	border: 1px solid lightgrey;
}

th, td {
	height: 75px; 
	padding: 5px;
	text-align: center;
	font-size:18px;
}

.pic {
	object-fit: contain;
	width: 95px;
	height: 80px;
}


.class1{
background-color:#FFF0AC;
}

input{
background-color:#FFF0AC;

}

button{
background-color: #FFF0AC;
}
#table2 {
	background-color: #6A6AFF;
	color: white;
	font-weight: bold;
}

a.aa-add-to-cart-btn {
	width: 100%;
	height: 100%;
	margin: 0px;
}
</style>
</head>
<body bgcolor='white'>

	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" >					



		 <h3>會員資料修改</h3>



<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet"  name="form1">
<table>
	<tr>
		<td>會員編號</td>
		<td>${memberVO.memberId}</td>
	</tr>
	<tr>
		<td>帳號</td>
		<td>${memberVO.loginId}</td>
	</tr>
	
	<tr>
		<td>違規次數</td>
		<td><input  style="text-align:center" name="foul" id="foul" type="text" size="10"value="${memberVO.foul}"></td>
	</tr>
	<tr>
		<td>出租評價</td>
		<td><input  style="text-align:center" name="rentScore" id="rentScore" type="text" size="10"value="${memberVO.rentScore}"></td>
	</tr>
	<tr>
		<td>承租評價</td>
		<td><input  style="text-align:center" name="leaseScore" id="leaseScore" type="text" size="10"value="${memberVO.leaseScore}"></td>
	</tr>
	<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />
	<jsp:useBean id="memVO" scope="page" class="com.member.model.MemberVO" />
	<tr>
		<td>會員狀態</td>
			<td>  <span class="span_status"> <c:choose>
										<c:when test="${memberVO.status=='0'}">
											<label style='color: blue'>尚未啟用</label>
										</c:when>
										<c:when test="${memberVO.status=='1'}">
											<label style='color: green'>使用中</label>
										</c:when>
										<c:when test="${memberVO.status=='9'}">
											<label style='color: red'>停權</label>
										</c:when>

									</c:choose>

							</span>&nbsp&nbsp&nbsp 
							<!--  <input type="hidden" name="prodID"
								value="${prodVO.prodID}">-->
								<input type="hidden" name="memberID" value="${memberVO.memberId}">
								 <select name="status"
								size="1" class="status">

									<c:if test="${memberVO.status==0 }">
										<option value="0">尚未啟用</option>
										<option value="1">使用中</option>
										<option value="9">停權</option>
									</c:if>
									<c:if test="${memberVO.status==1 }">
										<option value="1">使用中</option>
										<option value="0">尚未啟用</option>
										<option value="9">停權</option>
									</c:if>
									<c:if test="${memberVO.status==9 }">
										<option value="9">停權</option>
										<option value="0">尚未啟用</option>
										<option value="1">使用中</option>
									</c:if>

							</select></td>

	</tr>
	

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="memberId" value="${memberVO.memberId}">
<input type="submit" value="修改"></FORM>
</main>
</div>
	<script>
		$("a.findmsg").click(function() {
			a();
			return false;
		});

		function a() {
			art.dialog({
				content : 'hello world!'
			})
		}

		$("select.prodStatus")
				.change(
						function() {

							var that = $(this).closest('td').find('input')
									.eq(0).val();
							var memberID =$(this).closest('td').find('input')
							.eq(1).val();
							console.log("m: "+memberID);
							console.log("p "+that)
							// 		alert("123")
							var status = $(this).val();
							console.log(status)
							var spanStatus = $(this).closest('tr').find(
									'span.span_status').eq(0);
							console.log(spanStatus);
							$
									.ajax({
										url : "/TFA104G1/member/MemServlet",
										type : "POST",
										cache : false,
										data : {
											prodID : that,
											action : "update",
											status : status,
											memberID: memberID
										},
										success : function(data) {
											console.log(data);
											if (data == 1) {
												$(spanStatus)
														.html(
																"<label style='color:green'>上架</label>");
											} else if (data == 9) {
												$(spanStatus)
														.html(
																"<label style='color:red'>停用</label>");
											} else if (data == 0) {
												$(spanStatus)
														.html(
																"<label style='color:blue'>下架</label>");
											}

										},
										error : function(e) {
											console.log("失敗");
										}
									});

						});
	</script>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<%
	java.sql.Date birthday = null;
	try {
		birthday = memberVO.getBirthday();
	} catch (Exception e) {
		birthday = new java.sql.Date(System.currentTimeMillis());
	}
%>
 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back_end/promo/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/back_end/promo/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/back_end/promo/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
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
        
</script>
</html>