<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.memberservice.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<%
	MemberServiceService msSvc = new MemberServiceService();
	List<MemberServiceVO> list = msSvc.getAll();
	pageContext.setAttribute("list", list);
	for (MemberServiceVO mcVO : list) {
		System.out.println("圖1" + mcVO.getPic1());
	}
	MemberServiceVO msVO = (MemberServiceVO) request.getAttribute("msVO");
%>

<html>
<head>
<title>所有問題列表</title>
<!-- 載入sweet alert -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://www.dukelearntoprogram.com/course1/common/js/image/SimpleImage.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="/jquery-3.4.1.min.js"></script>

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
	border: 1px solid #CCCCFF;
}

th, td {
	height: 100px padding: 5px;
	text-align: center;
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
</style>
</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" >
		
				<div>
				<FORM id="DATE" METHOD="post" ACTION="<%=request.getContextPath()%>/MemberServiceServlet">
					<b>依歸還日期查詢訂單:
					<br>
						起始日期:<input name="startDate" id="f_date1" type="text" style="width: 73px;"> 
						<br>
						結束日期:<input name="endDate"id="f_date2" type="text" style="width: 73px;">
								<button>確認</button>
								<input type="hidden" name="action" value="get_date_manager_order">
					</b>
				</FORM>
			</div>
				
			<%--錯誤列表 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>

			<table>
				<tr>
					<th>問題編號</th>
					<th>商品編號</th>
					<th>會員編號</th>
					<th>管理者編號</th>
					<th>問題類型編號</th>
					<th>訂單編號</th>
					<th>訊息時間</th>
					<th>問題描述</th>
					<th>圖片一</th>
					<th>圖片二</th>
					<th>圖片三</th>
					<th>問題狀態</th>
					<th>回覆</th>

				</tr>
				<jsp:useBean id="ptSVC" scope="page"
					class="com.problemtype.model.ProblemTypeService" />
					
				<%@ include file="page1.file"%>

				<c:forEach var="msVO" items="${list}" begin="<%=pageIndex%>"
					end="<%=pageIndex+rowsPerPage-1%>">



					<tr>
						<td>${msVO.msgID}</td>
						<td><a href="<%=request.getContextPath()%>/msg/MsgProdServlet?prodID=${msVO.prodID}&action=selectItem&value=10">${msVO.prodID}</a></td>
						<td><a>${msVO.memberID}</a></td>
						<td>${msVO.managerID}</td>
						<td>${ptSVC.getOneProblemType(msVO.typeID).typeName}</td>
						
						<td><a href="<%=request.getContextPath()%>/back_end/order/updateOrderManager2.jsp?ordID=${msVO.ordID}">${msVO.ordID}</a></td>
						<td><fmt:formatDate value="${msVO.msgDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td><button id = "class1" class="class1" value="${msVO.problemMsg}">查詢</button></td>
						<td class="pic"><img alt=""
							src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=1&msgID=${msVO.msgID}">
						</td>
						<td class="pic"><img alt=""
							src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=2&msgID=${msVO.msgID}">
						</td>
						<td class="pic"><img alt=""
							src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=3&msgID=${msVO.msgID}">
						</td>
						<td>
							<FORM METHOD="post"
								ACTION="<%=request.getContextPath()%>/MemberServiceServlet"
								name="form1" enctype="multipart/form-data">
								<input type="hidden" name="msgID" value="${msVO.msgID}">
								<input type="hidden" name="prodID" value="${msVO.prodID}">
								<input type="hidden" name="problemMsg" value="${msVO.problemMsg}">
								<input type="hidden" name="memberID" value="${msVO.memberID}">
								<input type="hidden" name="ordID" value="${msVO.ordID}">
								<input type="hidden" name="managerID" value="${msVO.managerID}">
								<input type="hidden" name="typeID" value="${msVO.typeID}">
								<input type="hidden" name="msgDate" value="${msVO.msgDate}">
								<input type="hidden" name="pic1" value="${msVO.pic1}">
								<input type="hidden" name="pic2" value="${msVO.pic2}">
								<input type="hidden" name="pic3" value="${msVO.pic3}">
								
								<select name="problemStatus" size="1" id="s">
									<option value="0" ${msVO.problemStatus == 0 ? "selected" : "" }>未處理</option>
									<option value="1" ${msVO.problemStatus == 1 ? "selected" : "" }>已處理</option>									
								</select><br> 
									<input type="hidden" name="action" value="update"> 
									<input type="submit" value="送出">
							</FORM>
						</td>
						<td>
						<button class="class1">mail</button>
						</td>

					</tr>


				</c:forEach>
			</table>


			<%@ include file="page2.file"%>
			<br>
			<button class="back_btn">返回上一頁</button>
		</main>
	</div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="datetimepicker/jquery.datetimepicker.css" />
<script src="datetimepicker/jquery.js"></script>
<script src="datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>
<script >
$.datetimepicker.setLocale('zh'); // kr ko ja en
$("#f_date1").datetimepicker({
   theme: '',          //theme: 'dark',
   timepicker: false,   //timepicker: false,
   step: 1,            //step: 60 (這是timepicker的預設間隔60分鐘)
   format: 'Y-m-d H:i:s',
   value:'',
});
$("#f_date2").datetimepicker({
   theme: '',          //theme: 'dark',
   timepicker: false,   //timepicker: false,
   step: 1,            //step: 60 (這是timepicker的預設間隔60分鐘)
   format: 'Y-m-d H:i:s',
   value:'',
});




var problemMsg = $(".class1");
$(function(){	
    $(".class1").on("click",function(){

console.log($(this).val());
var val = $(this).val();
        Swal.fire({
            position: 'center',
            title: '檢舉內容',
            html: val,
            confirmButtonText: '確認',
            focusConfirm: false
        });            

    });

});
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$("button.back_btn").click(function(){
		history.go(-1);
	});

</script>

</html>