<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>
<%@page import="java.util.stream.Collectors"%>

<%
	Integer memID = (Integer) session.getAttribute("id");
// 	OrderMasterVO omVO = (OrderMasterVO) request.getAttribute("OrderMasterVO");
// 	System.out.println("狀態"+omVO.getOrdID());
		
// 	List<OrderMasterVO> list = omSVC.getStatus(omVO.getOrdStatus());

// 	pageContext.setAttribute("list", list);

	Integer ordStatus = Integer.valueOf(request.getParameter("ordStatus"));
	
	
	OrderMasterService omSVC = new OrderMasterService();
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();

	List<OrderMasterVO> list = omSVC.getAll();
	List<OrderMasterVO> list1 = omSVC.getAll();
	
	List<OrderMasterVO> list2 =list.
								stream()
									.filter(o->o.getRentID()==memID)
										.filter(o -> o.getOrdStatus() == ordStatus)
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
			<div>
			<jsp:useBean id="OrdserMasterSvc" scope="page" class="com.order.model.OrderMasterService" />
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
					<h5>選擇訂單編號:</h5> 
					<select size="1" name="ordID">
						<c:forEach var="OrderMasterVO" items="${OrdserMasterSvc.all}">
							<c:if test="${OrderMasterVO.rentID == id}">
								<option value="${OrderMasterVO.ordID}">${OrderMasterVO.ordID}
							</c:if>
						</c:forEach>
					</select> 
					<input type="hidden" name="action" value="getOne_For_Display">
					<input class="aa-browse-btn" type="submit" value="送出">
				</FORM>
				<jsp:useBean id="OrdserListSvc" scope="page" class="com.order.model.OrderListService" />
<!-- 				<FORM METHOD="post" -->
<%-- 					ACTION="<%=request.getContextPath()%>/OrderMasterServlet"> --%>
<!-- 					<h5> -->
<!-- 						選擇訂單狀態: <select size="1" name="ordStatus"> -->
<%-- 							<option value="0" <%=omVO.getOrdStatus() == 0 ? "selected" : ""%>>已成立</option> --%>
<%-- 							<option value="1" <%=omVO.getOrdStatus() == 1 ? "selected" : ""%>>待歸還</option> --%>
<%-- 							<option value="2" <%=omVO.getOrdStatus() == 2 ? "selected" : ""%>>已完成</option> --%>
<%-- 							<option value="9" <%=omVO.getOrdStatus() == 9 ? "selected" : ""%>>已取消</option> --%>
<!-- 						</select>  -->
<!-- 						<input type="hidden" name="action" value="get_Status_Display"> -->
<!-- 						<input type="submit" value="送出"> -->
<!-- 					</h5> -->
<!-- 				</FORM> -->
			</div>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<table id="table-1">
				<div>
<%-- 					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/OrderMasterServlet"> --%>
						<tr>
							<td><a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listAllOrderForRent.jsp">全部</a></td>
							<td><a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listStatusOrderMasterForRent.jsp?ordStatus=0">已成立</a></td>
							<td><a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listStatusOrderMasterForRent.jsp?ordStatus=1">待歸還</a></td>
							<td><a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listStatusOrderMasterForRent.jsp?ordStatus=2">已完成</a></td>
							<td><a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listStatusOrderMasterForRent.jsp?ordStatus=9">已取消</a></td>
						</tr>
<!-- 						<input type="hidden" name="action" value="get_Status_Display_ForRent"> -->
<!-- 					</FORM> -->
				</div>
			</table>
			<table id="table-1">
				<tr>
					<th>訂單編號</th>
					
					<th>出租者</th>
					<th>交易方式</th>
					<th>折價券</th>
					<th>運送狀態</th>
					<th>付款狀態</th>
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
					<c:choose>
						<c:when test="${omVO.rentID == id}">
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
							<c:set var="count" value="0"/>
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
										<c:set var="count" value="1"/>
									</c:if>
								</c:forEach>

								<c:choose>
									<c:when test="${omVO.shipStatus == '0'}">
										<td>待出貨</td>
									</c:when>
									<c:when test="${omVO.shipStatus == '1'}">
										<td>已出貨</td>
									</c:when>
									<c:when test="${omVO.shipStatus == '2'}">
										<td>待取貨</td>
									</c:when>
									<c:when test="${omVO.shipStatus == '3'}">
										<td>取貨完成</td>
									</c:when>
									<c:otherwise>
										<td>商品遺失</td>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${omVO.payStatus == '0'}">
										<td>待付款</td>
									</c:when>
									<c:otherwise>
										<td>已付款</td>
									</c:otherwise>
								</c:choose>

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
									<FORM METHOD="post"ACTION="<%=request.getContextPath()%>/OrderListServlet"style="margin-bottom: 0px;">
										<input class="aa-browse-btn" type="submit" value="查看明細"> 
										<input type="hidden" name="ordID" value="${omVO.ordID}"> 
<%-- 										<input type="hidden" name="listID" value="${olVO.listID}">  --%>
										<input type="hidden" name="action" value="getlist_For_Rent">
									</FORM>
								</td>
							</tr>
						</c:when>
					</c:choose>
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