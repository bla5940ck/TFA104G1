<%@page import="java.util.stream.Collectors"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

<%
	Integer memID = (Integer) session.getAttribute("id");
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
// 	OrderMasterVO omVO = (OrderMasterVO) request.getAttribute("OrderMasterVO");

	OrderMasterService omSVC = new OrderMasterService();
	List<OrderMasterVO> list = omSVC.getAll();
	List<OrderMasterVO> list1 = omSVC.getAll();
// 	for(OrderMasterVO leaseVO : list){
// 		if()
// 	}
	List<OrderMasterVO> list2 =list.
								stream()
									.filter(o->o.getLeaseID()==memID)
										.filter(o->o.getOrdStatus()==2)
											.collect(Collectors.toList());

	pageContext.setAttribute("list", list2);
%>
<jsp:useBean id="prodSVC" scope="page" class="com.product.model.ProdService" />
<%-- <jsp:useBean id="omSVC" scope="page" class="com.order.model.OrderMasterService" /> --%>
<jsp:useBean id="memSVC" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="mcoSVC" scope="page" class="com.member_coupon.model.MemcouponService" />
<jsp:useBean id="daSVC" scope="page" class="com.member.model.DefAddressService" />

<html>
<head>
<meta charset="UTF-8">
<title>訂單狀態查詢</title>
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
	width: 150px;
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
	width: calc(100% - 150px - 10px);
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	width: 100%;
	margin-top: 5px;
	margin-bottom: 5px;
	font-size: 12px;
}

table, th, td {
	border: 1px solid lightgrey;
}

th, td {
	padding: 5px;
	text-align: left;
}
</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
	<div class="main_content">
		<aside class="aside">
			<nav class="nav">
				<h3>出租者專區</h3>
				<h5>會員編號 : <%=memID%></h5>
				<ul class="nav_list">
					<h4><a href="<%=request.getContextPath()%>/front_end/order/listAllOrderMaster.jsp">全部訂單</a></h4>
					<h4><a href="listSuccessOrder.jsp">訂單評價</a></h4>
				</ul>
			</nav>
		</aside>
		<main class="main">


				<jsp:useBean id="OrdserListSvc" scope="page" class="com.order.model.OrderListService" />

			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<input type="date">
			<table id="table-1">
				<tr>
					<th>訂單編號</th>
					<th>承租者</th>
					<th>交易方式</th>
					<th>折價券</th>
<!-- 					<th>運送狀態</th> -->
<!-- 					<th>付款狀態</th> -->
					<th>訂單狀態</th>
					<th>訂單日期</th>
<!-- 					<th>出貨碼</th> -->
<!-- 					<th>歸還碼</th> -->
<!-- 					<th>超商碼</th> -->
					<th>出貨日期</th>
					<th>到貨日期</th>
					<th>歸還日期</th>
					<th>承租天數</th>
					<th>訂單金額</th>
				</tr>
				<%@ include file="pageForLease.file"%>
				<c:forEach var="omVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">		 
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${omVO.ordStatus == 2 && omVO.leaseID == id}"> --%>
							<tr>
								<td>${omVO.ordID}</td>
								<td>${memSVC.getOneMember(omVO.rentID).name}</td>
								<c:choose>
									<c:when test="${omVO.payID == '1'}">
										<td>信用卡</td>
									</c:when>
									<c:otherwise>
										<td>面交</td>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${omVO.couponID == ''}">
										<td>無</td>
									</c:when>
									<c:otherwise>
										<td>${mcoSVC.findByPrimaryKey(omVO.couponID).coupon_name}</td>
									</c:otherwise>
								</c:choose>

<%-- 								<c:choose> --%>
<%-- 									<c:when test="${omVO.shipStatus == '0'}"> --%>
<!-- 										<td>待出貨</td> -->
<%-- 									</c:when> --%>
<%-- 									<c:when test="${omVO.shipStatus == '1'}"> --%>
<!-- 										<td>已出貨</td> -->
<%-- 									</c:when> --%>
<%-- 									<c:when test="${omVO.shipStatus == '2'}"> --%>
<!-- 										<td>待取貨</td> -->
<%-- 									</c:when> --%>
<%-- 									<c:when test="${omVO.shipStatus == '3'}"> --%>
<!-- 										<td>取貨完成</td> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<td>商品遺失</td> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>

<%-- 								<c:choose> --%>
<%-- 									<c:when test="${omVO.payStatus == '0'}"> --%>
<!-- 										<td>待付款</td> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<td>已付款</td> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>

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

								<td><fmt:formatDate value="${omVO.ordDate}"
										pattern="yyyy-MM-dd" /></td>
<%-- 								<td>${omVO.shipCode}</td> --%>
<%-- 								<td>${omVO.returnCode}</td> --%>
<%-- 								<td>${omVO.storeCode}</td> --%>
								<td><fmt:formatDate value="${omVO.shipDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${omVO.arrivalDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${omVO.returnDate}"
										pattern="yyyy-MM-dd" /></td>
								<td>${omVO.rentDays}</td>
								<td>${omVO.ordPrice}</td>
								<td>
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/OrderMasterServlet"
										style="margin-bottom: 0px;">
										<input type="submit" value="評價"> 
										<input type="hidden" name="ordID" value="${omVO.ordID}"> 
<%-- 										<input type="hidden" name="listID" value="${olVO.listID}">  --%>
										<input type="hidden" name="action" value="getComment_For_Display">
									</FORM>
								</td>
							</tr>
<%-- 						</c:when> --%>
<%-- 					</c:choose> --%>
				</c:forEach>
			</table>
			<%@ include file="page2.file"%>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</html>