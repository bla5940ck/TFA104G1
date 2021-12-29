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
<title>Export to Excel - Demo</title>
</head>
<body>
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
 <a href="Suss.jsp?exportToExcel=YES">Export to Excel</a>
 
 <table id="table-1">
	<tr><td>
		 <h3>所有會員資料- listAllMember.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back_end/manager/afterLogin.jsp"><img src="<%=request.getContextPath()%>/front_end/member/img/index.jpg" width="100" height="32" border="0"></a></h4>
	</td></tr>
</table>
 
 <table align="left" border="2">
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
<%-- 								<td><fmt:formatDate value="${omVO.shipDate}" pattern="yyyy-MM-dd" /></td> --%>
<%-- 								<td><fmt:formatDate value="${omVO.arrivalDate}"	pattern="yyyy-MM-dd" /></td> --%>
								<td><fmt:formatDate value="${omVO.returnDate}" pattern="yyyy-MM-dd" /></td> 
<%-- 								<td>${omVO.rentDays}</td> --%>
								<td>${omVO.ordPrice}</td>
<%-- 								<td>
									<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/BackEndOrderServlet"
										style="margin-bottom: 0px;">
										<input type="submit" value="狀態修改"> 
										<input type="hidden" name="ordID" value="${omVO.ordID}">
																	<input type="hidden" name="listID" value="${omVO.ordID}"> 
										<input type="hidden" name="action" value="getOne_For_Manager_Update">
									</FORM>
								</td>--%>
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
</body>
</html>