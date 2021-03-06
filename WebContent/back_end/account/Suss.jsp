<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.member_coupon.model.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="com.member.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="java.util.stream.Collectors"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>已付款訂單資料</title>
</head>
 <a href="Suss.jsp?exportToExcel=YES">Export to Excel</a>
<body bgcolor='white'>
<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
	<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" >
		
<%
	MemcouponDAO memDAO = new MemcouponDAO();
	List <MemcouponVO> memVO = memDAO.getAll();
	for(MemcouponVO name : memVO){
// 		System.out.println(name.getCoupon_name());
	}

	DefAddressJDBCDAO dadao = new DefAddressJDBCDAO();
	List<DefAddressVO> daVO = dadao.getAll();

	OrderMasterService omSVC = new OrderMasterService();
	
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
	List<OrderMasterVO> list = omSVC.getAll();
	
// 	List<OrderMasterVO> list2 =list.
// 								stream()
// 									.filter(o->o.getLeaseID()==memID)
// 										.collect(Collectors.toList());

	if (request.getAttribute("list") != null) {
		list = (List) request.getAttribute("list");
	}

	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="memSVC" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="mcoSVC" scope="page" class="com.member_coupon.model.MemcouponService" />
<jsp:useBean id="daSVC" scope="page" class="com.member.model.DefAddressService" />

 <%
 String exportToExcel = request.getParameter("exportToExcel");
 if (exportToExcel != null
 && exportToExcel.toString().equalsIgnoreCase("YES")) {
 response.setContentType("application/vnd.ms-excel");
 response.setHeader("Content-Disposition", "inline; filename="
 + "excel.xls");
 
 }
 %>
 
	<div>
				<jsp:useBean id="OrdserMasterSvc" scope="page" class="com.order.model.OrderMasterService" />
		

				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/account/ArAcServlet">
					<b>輸入訂單編號 :</b><br> 
					<input type="text" name="ordID"> 
					<input type="hidden" name="action" value="getOne_For_Display"> 
					<input type="submit" value="送出">
				</FORM>
			</div>
			<div>
				<FORM id="DATE" METHOD="post" ACTION="<%=request.getContextPath()%>/account/ArAcServlet">
					<b>依訂單日期查詢訂單 :
					<br>
						起始日期 : <input name="startDate" id="f_date3" type="text" style="width: 73px;"> 
						<br>
						結束日期 : <input name="endDate"id="f_date4" type="text" style="width: 73px;">
								<button>確認</button>
								<input type="hidden" name="action" value="get_orDdate_order">
					</b>
				</FORM>
			</div>
			<div>
				<FORM id="DATE" METHOD="post" ACTION="<%=request.getContextPath()%>/account/ArAcServlet">
					<b>依訂單完成日期查詢訂單 :
					<br>
						起始日期 : <input name="startDate" id="f_date1" type="text" style="width: 73px;"> 
						<br>
						結束日期 : <input name="endDate"id="f_date2" type="text" style="width: 73px;">
								<button>確認</button>
								<input type="hidden" name="action" value="get_arVdate_order">
					</b>
				</FORM>
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
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/BackEndOrderServlet">
						<tr>
							<td><a class="a1" href="<%=request.getContextPath()%>/back_end/account/AccountListDetile.jsp">第三方核帳</a></td>
							<td><a class="a1" href="<%=request.getContextPath()%>/back_end/account/ACRent.jsp">應付-出租者</a></td>
							<td><a class="a1" href="<%=request.getContextPath()%>/back_end/account/ACLease.jsp">應付-承租者</a></td>
							<td><a class="a1" href="<%=request.getContextPath()%>/back_end/account/ACFinish.jsp">已轉帳</a></td>
							
						</tr>
						<input type="hidden" name="action" value="get_Status_Display_Manager">
					</FORM>
				</div>
			</table>
 
 <table align="left" border="2" id="table-2">
 <thead>
 <tr>
					
					<th>訂單編號</th>
					<th>出租者</th>
					<th>承租者</th>
					<th>交易方式</th>
					<th>運送狀態</th>
					<th>付款狀態</th>
					<th>訂單狀態</th>
					<th>轉帳狀態</th>
					<th>訂單日期</th>
					<th>超商碼</th>
					<th>訂單完成日期</th>
					<th>訂單金額</th>
				</tr>
		
 </thead>
 <tbody>
 <%
 for (int i = 0; i < 1; i++) {
 %>
 	<c:forEach var="omVO" items="${list}" >		 
							<c:choose>
									<c:when test="${((omVO.payID == 1) and omVO.payStatus == 1) }">
							<tr>
								<td>${omVO.ordID}</td>
								<td>${memSVC.getOneMember(omVO.leaseID).loginId}</td>
								<td>${memSVC.getOneMember(omVO.rentID).loginId}</td>
								<td>信用卡</td>
									
								
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
								<td>${(omVO.trfStatus == 0)?'待轉帳':'已轉帳'}</td>
								<td><fmt:formatDate value="${omVO.ordDate}" pattern="yyyy-MM-dd" /></td>

								<td>${omVO.storeCode}</td>
								<td><fmt:formatDate value="${omVO.returnDate}" pattern="yyyy-MM-dd" /></td> 
								<td>${omVO.ordPrice}</td>
								<td>
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/BackEndOrderServlet"
										style="margin-bottom: 0px;">
										<input type="submit" value="查看明細"> 
										<input type="hidden" name="ordID" value="${omVO.ordID}"> 
										<input type="hidden" name="action" value="getlist_For_Manager">
									</FORM>
								</td>
							</tr>
							</c:when>

								</c:choose>
				</c:forEach>
 <%
 }
 %>
 </tbody>
 </table>
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> 
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <%
 if (exportToExcel == null) {
 %>
 <%
 }
 %>
 <button class="back_btn">返回上一頁</button>
		</main>
	</div>
</body>
</html>