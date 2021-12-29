<%@page import="com.member.model.DefAddressJDBCDAO"%>
<%@page import="com.member.model.DefAddressVO"%>
<%@page import="com.booking.model.BookingVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

<!DOCTYPE html>
<html>
<head>
<title>訂單資訊</title>
<%
	OrderMasterVO omVO = (OrderMasterVO) request.getAttribute("OrderMasterVO");
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
// 	out.println(omVO.getShipDate());
	
// 	OrderListVO olVO = (OrderListVO) request.getAttribute("OrderListVO");
// 	OrderListDAOImpl oldao = new OrderListDAOImpl();
// 	List<OrderListVO> olVO = oldao.getAllOrderList();
// 	for(OrderListVO ol : olVO){
		
// 	}
%>
<jsp:useBean id="prodSVC" scope="page" class="com.product.model.ProdService" />
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
			height:865px;
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
			display: block;
  			width: 50%;
  			height: auto;
  			margin: 0 auto
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
		
		.head{
			display: inline-block;
			width: 100%;
		}
		.head2{
			display: inline-block;
			width: 30%;
		}
		.head3{
/* 			border: 1px solid red; */
			display: inline-block;
			vertical-align:middle;
			text-align:justify;
			width: 55%;			
			position: absolute;
			bottom: 209px;
		}
		
		.div1{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 100%;
		}
		.div2{
/* 			border: 1px solid red; */
			vertical-align:top;
			display: inline-block;
			width: 35%;
		}
		.div3{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 35%;
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
<body bgcolor="white">
	<%@ include file="/includeFolder/header.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/leaseMemberAside.file"%>
		<main class="main">			
		<FORM METHOD="post"ACTION="<%=request.getContextPath()%>/BackEndOrderServlet" style="margin-bottom: 0px;">
			<h1>訂單編號 :<%=omVO.getOrdID()%></h1>
			<hr>
				<input type="hidden" name="ordID" value="<%=omVO.getOrdID()%>">
				<jsp:useBean id="olDAO"	class="com.order.model.OrderListDAOImpl" /> 
				<c:forEach var="olVO" items="${olDAO.getAllOrderList()}">
					<c:choose>
						<c:when test="${olVO.ordID == omVO.ordID}">
							<input type="hidden" name="listID" value="${olVO.listID}">
						</c:when>
					</c:choose>
				</c:forEach>
				<input type="hidden" name="action" value="getOne_For_Update">
			</FORM>
				<div class="div1">
			<div class="div2">
				<ul>
					<h4>
					<li>訂單日期 : <fmt:formatDate value="<%=omVO.getOrdDate()%>" pattern="yyyy-MM-dd HH:MM" /></li>
					<li>承租者編號 : <%=omVO.getRentID()%></li>
					<li>出租者編號 : <%=omVO.getLeaseID()%></li>
					<br>
					<li>交易方式 : <p id="payID"><%=omVO.getPayID()%><p></li>
					<li>付款狀態 : <p id="payS"><%=omVO.getPayStatus()%></p></li>
					<li>運送狀態 : <p id="shipS"><%=omVO.getShipStatus()%></p></li>
					<li>訂單狀態 : <p id="ordS"><%=omVO.getOrdStatus()%></p></li>
					</h4>
				</ul>
			</div>
			<div class="div3">
				<ul>
					<h4>
					<li>出貨代碼 : <%=omVO.getShipCode() == 0 ? "待出貨" : omVO.getShipCode()%></li>
					<li>歸還代碼 : <%=omVO.getReturnCode() == 0 ? "待歸還" : omVO.getReturnCode()%></li>
					<li>超商代碼 : <%=omVO.getStoreCode() == 0 ?"尚未至超商出貨" : omVO.getStoreCode()%></li>
					<br>
					<li>預計租借起日 : <%=omVO.getEstStart()%></li>
					<li>預計租借訖日 : <%=omVO.getEstEnd()%></li>
					<li>承租天數 : <%=omVO.getRentDays()%></li>
					<br>
					<li>實際出貨日期 : <fmt:formatDate value="<%=omVO.getShipDate()%>" pattern="yyyy-MM-dd HH:mm:ss" /></li>
					<li>實際到貨日期 : <fmt:formatDate value="<%=omVO.getArrivalDate()%>" pattern="yyyy-MM-dd HH:mm:ss" /></li>
					<li>實際歸還日期 : <fmt:formatDate value="<%=omVO.getReturnDate()%>" pattern="yyyy-MM-dd HH:mm:ss" /></li>
					<br>
					<li>折價券編號 : <%=omVO.getCouponID()%></li>
					<li>運費 : <%=omVO.getShipFee()%></li>
					<li>訂單金額 : <%=omVO.getOrdPrice()%></li>
					</h4>
					<br>
				</ul>
			</div>
		</div>
		<a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listAllOrderMaster.jsp">回到我的訂單</a>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file" %>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	/*=====運送狀態=====*/
	var payID = $("#payID");
	if (
<%=omVO.getPayID()%>
	== 1) {
		payID.text("信用卡");
	} else {
		payID.text("面交");
	}

	var shipS = $("#shipS");
	if (
<%=omVO.getShipStatus()%>
	== 0) {
		shipS.text("待出貨");
	} else if (
<%=omVO.getShipStatus()%>
	== 1) {
		shipS.text("已出貨");
	} else if (
<%=omVO.getShipStatus()%>
	== 2) {
		shipS.text("待取貨");
	} else if (
<%=omVO.getShipStatus()%>
	== 3) {
		shipS.text("取貨完成");
	} else {
		shipS.text("商品遺失");
	};

	/*=====付款狀態=====*/

	var payS = $("#payS");
	if (
<%=omVO.getPayStatus()%>
	== 0) {
		payS.text("待付款");
	} else {
		payS.text("已付款");
	};

	/*=====訂單狀態=====*/

	var ordS = $("#ordS");
	if (
<%=omVO.getOrdStatus()%>
	== 0) {
		ordS.text("已成立");
	} else if (
<%=omVO.getOrdStatus()%>
	== 1) {
		ordS.text("待歸還");
	} else if (
<%=omVO.getOrdStatus()%>
	== 2) {
		ordS.text("已完成");
	} else {
		ordS.text("已取消");
	};
</script>
</html>