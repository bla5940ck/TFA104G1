<%@page import="com.member.model.DefAddressJDBCDAO"%>
<%@page import="com.member.model.DefAddressVO"%>
<%@page import="com.booking.model.BookingVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

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

<html>
<head>
<title>訂單資訊</title>
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
			height: 650px;
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
<body bgcolor="white">
	<%@ include file="/includeFolder/header.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/leaseMemberAside.file"%>
		<main class="main">			
		<FORM METHOD="post"ACTION="<%=request.getContextPath()%>/BackEndOrderServlet" style="margin-bottom: 0px;">
			<h4>訂單編號 :<%=omVO.getOrdID()%></h4>
				<input class="aa-browse-btn" type="submit" value="更新">
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
			<table id="table-1">
				<tr>
					<th>承租者編號</th>
					<th>出租者編號</th>
					<th>交易方式</th>
					<th>訂單日期</th>
				</tr>

				<tr>
					<td><%=omVO.getRentID()%></td>
					<td><%=omVO.getLeaseID()%></td>
					<td><p id="payID"><%=omVO.getPayID()%></p></td>
					<td><fmt:formatDate value="<%=omVO.getOrdDate()%>"
							pattern="yyyy-MM-dd HH:MM" /></td>
				</tr>
			</table>
			<br>
			<table>
				<tr>
					<th>付款狀態</th>
					<th>運送狀態</th>
					<th>訂單狀態</th>
				</tr>
				<tr>
					<td><p id="payS"><%=omVO.getPayStatus()%></p></td>
					<td><p id="shipS"><%=omVO.getShipStatus()%></p></td>
					<td><p id="ordS"><%=omVO.getOrdStatus()%></p></td>
				</tr>
			</table>
			<br>
			<table>
				<tr>
					<th>出貨代碼</th>
					<th>歸還代碼</th>
					<th>超商代碼</th>
				</tr>
				<tr>
					<td><%=omVO.getShipCode() == 0 ? "待出貨" : omVO.getShipCode()%></td>
					<td><%=omVO.getReturnCode() == 0 ? "待歸還" : omVO.getReturnCode()%></td>
					<td><%=omVO.getStoreCode()%></td>
				</tr>
			</table>
			<br>
			<table>
				<tr>
					<th>預計租借起日</th>
					<td><%=omVO.getEstStart()%></td>
				</tr>
				<tr>
					<th>預計租借訖日</th>
					<td><%=omVO.getEstEnd()%></td>
				</tr>
				<tr>
					<th>承租天數</th>
					<td><%=omVO.getRentDays()%></td>
				</tr>
				<tr>
					<th>實際出貨日期</th>
					<td><fmt:formatDate value="<%=omVO.getShipDate()%>" 
					pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
				<tr>
					<th>實際到貨日期</th>
					<td><fmt:formatDate value="<%=omVO.getArrivalDate()%>"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
				<tr>
					<th>實際歸還日期</th>
					<td><fmt:formatDate value="<%=omVO.getReturnDate()%>"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</table>
			<br>
			<table>
				<tr>
					<th>承租者評分</th>
					<td><%=omVO.getRentRank() == 0 ? "承租者尚未評分" : omVO.getRentRank()%></td>

					<th>出租者評分</th>
					<td><%=omVO.getLeaseRank() == 0 ? "出租者尚未評分" : omVO.getLeaseRank()%></td>
				</tr>
				<tr>
					<th>承租者評論</th>
					<td><%=omVO.getRentComt() == null?"尚未評論":omVO.getRentComt()%></td>
<%-- 						<td><%=omVO.getRentComt()%></td> --%>

					<th>出租者評論</th>
					<td><%=omVO.getLeaseComt() == null ?"尚未評論" : omVO.getLeaseComt()%></td>
<%-- 						<td><%=omVO.getLeaseComt()%></td> --%>
						
				</tr>
				<tr>
					<th>承租者評論日期</th>
					<td><fmt:formatDate value="<%=omVO.getRentComtdate()%>" pattern="yyyy-MM-dd" /></td>

					<th>出租者評論日期</th>
					<td><fmt:formatDate value="<%=omVO.getLeaseComtdate()%>" pattern="yyyy-MM-dd" /></td>
				</tr>
			</table>
			<br>
			<table>
				<tr>
					<th>折價券編號</th>
					<td><%=omVO.getCouponID()%></td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th>商品小計</th> -->
<%-- 					<td><%=omVO.getProdPrice()%></td> --%>
<!-- 				</tr> -->
				<tr>
					<th>運費</th>
					<td><%=omVO.getShipFee()%></td>
				</tr>
				<tr>
					<th>訂單金額</th>
					<td><%=omVO.getOrdPrice()%></td>
				</tr>
			</table>
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