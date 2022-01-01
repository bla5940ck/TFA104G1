<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.stream.Collectors"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>歷史訂單</title>

<%
	Integer memID = (Integer) session.getAttribute("id");
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
	
	OrderMasterService omSVC = new OrderMasterService();
	List<OrderMasterVO> list = omSVC.getAll();

	List<OrderMasterVO> list2 = list.stream()
								.filter(o -> o.getLeaseID().equals(memID))
									.filter(o -> o.getOrdStatus() == 2)
										.collect(Collectors.toList());

	if (request.getAttribute("list") != null) {
		list2 = (List) request.getAttribute("list");
	}

	pageContext.setAttribute("list", list2);
%>
<jsp:useBean id="prodSVC" scope="page" class="com.product.model.ProdService" />
<jsp:useBean id="memSVC" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="mcoSVC" scope="page" class="com.member_coupon.model.MemcouponService" />
<jsp:useBean id="daSVC" scope="page" class="com.member.model.DefAddressService" />

<style>
		* {
			box-sizing: border-box;
			text-decoration: none;
			list-style: none;
		}
		
		body {
			margin: 0;
			padding: 0px;
		}
		
		img {
			max-width: 100%;
		}
		
		header.header {
			background-color: #ddd;
			width: 100%;
			margin: 0 auto 0px auto;
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
			height:765px;
			width: 200px;
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			margin-right: 6px;
			margin-left: 4px;
			border: 1px solid #999 ;
			border-color: transparent #191561 transparent transparent;
		}
		
		/*--------------------main區域-------------------- */
		main.main {
			background-color: white;
			width: calc(100% - 200px - 10px);
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			border: 1px solid white;
			padding: 0px;
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
		
		/*--------------------table區域-------------------- */
		table {
			width: 100%;
			background-color: white;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		
		table, th, td {
			border: 1px solid #CCCCFF;
		}
		
		.cart-img{
			height: 120px;
			width: 120px;
			
		}
		.dateBtn{
		    background-color: #191561;
   			border: 1px solid #191561;
   			color: white;
		}
		.check{
		    background-color: #191561;
   			border: 1px solid #191561;
   			color: white;
		}
	.div1{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 100%;
		}
		.div2{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 25%;
		}
		.div3{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 25%;
		}
		.div4{
/* 			border: 1px solid red; */
			display: inline-block;
			position:relative;
			left:300px;
			width: 15%;
		}
		.div5{
/* 			border: 1px solid red; */
			position: absolute;
			margin-top: 0;
			display: inline-block;
			width: 15%;
		}
		</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/leaseMemberAside.file"%>
		<main class="main">
		<h1>歷史訂單</h1>
			<jsp:useBean id="OrdserListSvc" scope="page" class="com.order.model.OrderListService" />
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<div>
				<FORM id="DATE" METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
				<h5>依歸還日期查詢訂單 : 
					起始日期 : <input name="startDate" id="f_date1" type="text" style="width: 73px;"> 
					結束日期 : <input name="endDate"id="f_date2" type="text" style="width: 73px;"> 
							<input type="button" class="dateBtn" value="確認">
						     <input type="hidden" name="action" value="get_date_forLease_order">
				</h5>
				</FORM>
				<div class="getTotal">
				<span class="sumFee"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span class="sum"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span class="all"></span>
				</div>
			</div>
			<%@ include file="pageForLease.file"%>
				<div class="div1">
			<hr style="border: 1px solid black;">
				<c:forEach var="omVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					<div class="div2">
					<ul>
						<h4>訂單編號 : ${omVO.ordID}</h4>
						<li>承租者 : ${memSVC.getOneMember(omVO.rentID).name}</li>
						<li>交易方式 :
							<c:choose>
								<c:when test="${omVO.payID == '1'}">超商店到店</c:when>
								<c:otherwise>面交</c:otherwise>
						</c:choose>
						</li>
						<li>折價券 :
						<jsp:useBean id="mcDAO" class="com.member_coupon.model.MemcouponDAO" />
						<c:set var="count" value="0" />
						<c:forEach var="mcVO" items="${mcoSVC.getAll()}">
							<c:if test="${count==0}">
								<c:choose>
									<c:when test="${omVO.couponID =='' || omVO.couponID == null}">無
									</c:when>
									<c:when test="${true}">${mcVO.coupon_name}</c:when>
								</c:choose>
								<c:set var="count" value="1" />
							</c:if>
						</c:forEach>
						</li>
						<li>折抵金額 : 
						<c:set var="count" value="0" />
						<c:forEach var="mcVO" items="${mcoSVC.getAll()}">
							<c:if test="${count==0}">
								<c:choose>
									<c:when test="${omVO.couponID =='' || omVO.couponID == null}">無</c:when>
									<c:when test="${true}">$${Math.round(mcVO.discount)}元</c:when>
								</c:choose>
								<c:set var="count" value="1" />
							</c:if>
						</c:forEach>
						</li>				
						<li>訂單狀態 : 
						<c:choose>
							<c:when test="${omVO.ordStatus == '0'}">已成立</c:when>
							<c:when test="${omVO.ordStatus == '1'}">待歸還</c:when>
							<c:when test="${omVO.ordStatus == '2'}">已完成</c:when>
							<c:otherwise>已取消</c:otherwise>
						</c:choose>
						</li>
					</ul>						
					</div>	
					<div class="div3">	
						<ul>
							<li>訂單日期 : <fmt:formatDate value="${omVO.ordDate}" pattern="yyyy-MM-dd" /></li>
							<li>歸還日期 : 
								<c:choose>
									<c:when test="${omVO.returnDate != null}">
										<fmt:formatDate value="${omVO.returnDate}" pattern="yyyy-MM-dd" />
									</c:when>
									<c:otherwise>待歸還</c:otherwise>
							</c:choose>
				</li>
							<li>承租天數 : ${omVO.rentDays}</li>
							<li>運費 : $${omVO.shipFee}元</li>
							<li>訂單金額 : $${omVO.ordPrice}元</li>	
						</ul>		
					</div>
					<div class="div5">
						<jsp:useBean id="olDAO"	class="com.order.model.OrderListDAOImpl" /> 
						<c:forEach var="olVO" items="${olDAO.findOrderListByOrdID(omVO.ordID)}">
							<img class="cart-img" src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=${olVO.prodID}"alt="img"></a>
						</c:forEach>
					</div>			
									
					<div class="div4">
						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet" style="margin-bottom: 0px;">
								<input class="aa-browse-btn" type="submit" value="評價"> 
								<input type="hidden" name="ordID" value="${omVO.ordID}"> 
								<input type="hidden" class="shipFee" name="shipFee" value="${omVO.shipFee}">
								<input type="hidden" class="price" name="price" value="${omVO.ordPrice}"> 
								<input type="hidden" class="ncFee" name="ncFee" value="${omVO.ordPrice - omVO.shipFee}"> 
								<input type="hidden" name="action" value="getComment_For_Display">
						</FORM>
					</div>	
						
						<hr style="border: 1px solid black;">
					</c:forEach>
				</div>
			<%@ include file="page2.file"%>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file"%>
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

<script>
var shipFee = $("input.shipFee");
var sumFee =$(".sumFee"); // 運費
var totalFee = 0;
shipFee.each(function(index, item){
	totalFee += parseInt($(item).val());
	sumFee.text("運費總額 : " + totalFee + "元");
})

var price = $("input.price"); // 金額
var sum = $(".sum");
console.log(price.val());
var total = 0;

price.each(function(index, item) {
	total += parseInt($(item).val());
// 	console.log($(item).val());
	console.log(total);
	
	sum.text("訂單總金額 : " + total + "元");
})
	
var ncFee = $("input.ncFee");
var all = $(".all");
var reSum = 0;
ncFee.each(function(index, item) {
	reSum += parseInt($(item).val());
	console.log(total);
	all.text("扣除運費後為 : " + reSum + "元");
})

// $("#f_date1").blur(function(){
// // 	alert(1);
// 	alert("起始日");
// 	console.log($("#f_date1").val());
// 	if($("#f_date1").val() != null && $("#f_date1") != '' && $("#f_date2").val != null && $("#f_date2") != ''){	
		
// 		$("#f_date2").blur(function(){
// 			console.log($("#f_date2").val());
			
// 			if($("#f_date2").val != null && $("#f_date2") != ''){
// 				$("#DATE").submit();

// 			}else{
// 				alert("請選擇起始日 !");
// 				return false;
// 			}
// 		})	
		
// 	}else{
// 		alert("請選擇起始日 !");
// 		return false;
// 	}	
// });

$(".dateBtn").click(function(){
	if($("#f_date1").val() == ""){
		alert("請選擇起始日 !");
		return false;
	}else if($("#f_date2").val() ==""){
		alert("請選擇起始日 !");
		return false;
	}else{
		$("#DATE").submit();	
	}		
});
	


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

</script>

</html>