<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.stream.Collectors"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<%
	// 	session.setAttribute("id", 1);
	Integer memID = (Integer) session.getAttribute("id");
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();

	OrderMasterService omSVC = new OrderMasterService();
	List<OrderMasterVO> list = omSVC.getAll();

	List<OrderMasterVO> list2 = 
						list.stream().filter(o -> o.getRentID() == memID)
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

<html>
<head>
<meta charset="UTF-8">
<title>訂單狀態查詢</title>
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
		</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/rentMemberAside.file"%>

		<main class="main">
	<h3>評價訂單</h3>

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
				<h5>依歸還日期查詢訂單</h5>
				<FORM id="DATE" METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
					起始日期:<input name="startDate" id="f_date1" type="text" style="width: 73px;"> 
					結束日期:<input name="endDate"id="f_date2" type="text" style="width: 73px;"> 
							<input type="button" class="dateBtn" value="確認">
						     <input type="hidden" name="action" value="get_date_forRent_order">
				</FORM>
			</div>
			<table id="table-1">
				<tr>
					<th>訂單編號</th>
					<th>出租者</th>
					<th>交易方式</th>
					<th>折價券</th>
					<th>折底金額</th>
					
					<th>訂單狀態</th>
					<th>訂單日期</th>
<!-- 					<th>出貨日期</th> -->
<!-- 					<th>到貨日期</th> -->
					<th>歸還日期</th>
					<th>承租天數</th>
<!-- 					<th>運費</th> -->
					<th>訂單金額</th>
				</tr>
				<%@ include file="pageForLease.file"%>
				<c:forEach var="omVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					<tr>
						<td>${omVO.ordID}</td>
						<td>${memSVC.getOneMember(omVO.leaseID).name}</td>
						<c:choose>
							<c:when test="${omVO.payID == '1'}">
								<td>信用卡</td>
							</c:when>
							<c:otherwise>
								<td>面交</td>
							</c:otherwise>
						</c:choose>

						<jsp:useBean id="mcDAO" class="com.member_coupon.model.MemcouponDAO" />
						<c:set var="count" value="0" />
						<c:forEach var="mcVO" items="${mcoSVC.getAll()}">
							<c:if test="${count==0}">
								<c:choose>
									<c:when test="${omVO.couponID =='' || omVO.couponID == null}">
										<td>無</td>
									</c:when>
									<c:when test="${true}">
										<td>${mcVO.coupon_name}</td>
									</c:when>
								</c:choose>
								<c:set var="count" value="1" />
							</c:if>
						</c:forEach>

						<c:set var="count" value="0" />
						<c:forEach var="mcVO" items="${mcoSVC.getAll()}">
							<c:if test="${count==0}">
								<c:choose>
									<c:when test="${omVO.couponID =='' || omVO.couponID == null}">
										<td>無</td>
									</c:when>
									<c:when test="${true}">
										<td>$${Math.round(mcVO.discount)}元</td>
									</c:when>
								</c:choose>
								<c:set var="count" value="1" />
							</c:if>
						</c:forEach>

						<c:choose>
							<c:when test="${omVO.ordStatus == '0'}">
								<td>已成立</td>
							</c:when>
							<c:when test="${omVO.ordStatus == '1'}">
								<td>待歸還</td>
							</c:when>
							<c:when test="${omVO.ordStatus == '2'}">
								<td>已完成</td>
							</c:when>
							<c:otherwise>
								<td>已取消</td>
							</c:otherwise>
						</c:choose>

						<td><fmt:formatDate value="${omVO.ordDate}" pattern="yyyy-MM-dd" /></td>
<%-- 						<td><fmt:formatDate value="${omVO.shipDate}" pattern="yyyy-MM-dd" /></td> --%>
<%-- 						<td><fmt:formatDate value="${omVO.arrivalDate}" pattern="yyyy-MM-dd" /></td> --%>
						<td><fmt:formatDate value="${omVO.returnDate}" pattern="yyyy-MM-dd" /></td>
						<td>${omVO.rentDays}</td>
						<td>${omVO.ordPrice}</td>
						<td>
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet" style="margin-bottom: 0px;">
								<input type="submit" value="評價"> 
								<input class="ordID" type="hidden" name="ordID" value="${omVO.ordID}">
								<input class="price" type="hidden" name="price" value="${omVO.ordPrice}"> 
								<input type="hidden" name="action" value="getRentComment_For_Display">
							</FORM>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div class="getTotal">
				<p class="sum"></p>
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
var price = $("input.price"); // 金額
var sum = $(".sum");
console.log(price.val());
var total = 0;

price.each(function(index, item) {
	total += parseInt($(item).val());
// 	console.log($(item).val());
	console.log(total);
	
	sum.text("總金額 : " + total + "元");
})
	
	
	
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