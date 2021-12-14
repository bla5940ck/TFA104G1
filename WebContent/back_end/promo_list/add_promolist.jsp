<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.promo_list.model.*"%>

<%
  PromolistVO promolistVO = (PromolistVO) request.getAttribute("promolistVO");
%>
<jsp:useBean id="promoSvc" scope="page" class="com.promo.model.PromoService" />
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>專案資料新增 - add_promolist.jsp</title>

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
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
	width: calc(100% - 200px - 10px);
	height: 620px;
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
</style>
<style>
table#table-1 {
	width: 80%;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h2 {
	color: blue;
	display: inline;
}

.signOut{
background-color:#6495ed;
}


</style>

</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" style="background-color:#C0C0C0;">	

	
	<c:if test="${b==true }">
		<script>
 			alert("新增成功");
		</script>
	</c:if>

	<c:if test="${b==false}">
			<script>
			alert("新增失敗");
		</script>
	</c:if>

		 <h3>專案明細資料新增 - add_promolist.jsp</h3>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<!-- coupon_id, promo_id, category_id, coupon_name, discount, amount, used, start_date, end_date -->
<FORM METHOD="post" ACTION="promolist.do" name="form1">
<table>
	
	<tr>
		<td>專案名稱:</td>
		<td><select size="1" name="promo_id">
			<c:forEach var="promoVO" items="${promoSvc.all}">
				<option value="${promoVO.promo_id}" ${(promolistVO.promo_id==promoVO.promo_id)? 'selected':'' } >${promoVO.promo_name}
			</c:forEach>
		</select></td>
	</tr>

<!-- 	<tr> -->
<!-- 		<td>專案編號:</td> -->
<!-- 		<td><input type="TEXT" name="promo_id" size="45"></td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>專案編號:<font color=red><b>*</b></font></td> -->
<%-- 		<td>${promolistVO}</td> --%>
<!-- 	</tr> -->

<!-- 		<td>商品類別編號:</td> -->
<!-- 		<td> -->
<!-- 		</td> -->


	<tr>
		<td>折價券名稱:</td>
		<td><input type="TEXT" name="coupon_name" size="10"/></td>
	</tr>
	<tr>
		<td>折扣金額:</td>
		<td><input type="TEXT" name="discount" size="2"></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>數量:</td> -->
<!-- 		<td> -->
<!-- 		</td> -->
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>已領取數量:</td> -->
<!-- 		<td> -->
<!-- 		</td> -->
<!-- 	</tr> -->
	
	<tr>
		<td>開始日期:</td>
		<td><input name="start_date" id="f_date1" type="text" size="10"></td>
	</tr>
	<tr>
		<td>結束日期:</td>
		<td><input name="end_date" id="f_date2" type="text" size="10"></td>
	</tr>
	
</table>
<br>
		<input type="hidden" name="category_id" value=1>
		<input type="hidden" name="amount" value=1>
		<input type="hidden" name="used" value=0>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->


<% 
  java.sql.Date start_date = null;
  try {
	  start_date = promolistVO.getStart_date();
   } catch (Exception e) {
	   start_date = new java.sql.Date(System.currentTimeMillis());
   }
%>
<% 
  java.sql.Date end_date = null;
  try {
	  end_date = promolistVO.getEnd_date();
   } catch (Exception e) {
	   end_date = new java.sql.Date(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back_end/promo_list/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/back_end/promo_list/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/back_end/promo_list/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>
<%-- <c:forEach var="promoVO" items="${promoSvc.all}"> --%>
<%-- 				<c:if test="${promolistVO.promo_id==promoVO.promo_id}"> --%>
<%-- 				<label>${promoVO.promo_start}</label> --%>
<%-- 			</c:if> --%>
<%-- 		</c:forEach>	 --%>
<%-- 				<c:forEach var="promoVO" items="${promoSvc.all}"> --%>
<%-- 				<c:if test="${promolistVO.promo_id==promoVO.promo_id}"> --%>
<%-- 				<label>${promoVO.promo_end}</label> --%>
<%-- 			</c:if> --%>
<%-- 		</c:forEach>	 --%>
<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=start_date%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
       	   //startDate:            //'2017/07/10',  // 起始日
         //  minDate:'promoVO.promo_start',   
        //	   '-1970-01-01', // 去除今日(不含)之前
        //   maxDate:'promoVO.promo_end',   
        //	   '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=end_date%>', // value:   new Date(),
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