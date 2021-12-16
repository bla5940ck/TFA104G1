<%@page import="com.member_coupon.model.MemcouponVO"%>
<%@page import="com.member_coupon.model.MemcouponDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.member.model.DefAddressJDBCDAO"%>
<%@page import="com.member.model.DefAddressVO"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.member.model.MemberService"%>
<%@page import="com.member.model.MemberDAO_interface"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>
<%@page import="com.product.model.*"%>
<%@page import="java.util.stream.Collectors"%>


<%
	MemcouponDAO memDAO = new MemcouponDAO();
	List <MemcouponVO> memVO = memDAO.getAll();
	for(MemcouponVO name : memVO){
// 		System.out.println(name.getCoupon_name());
	}

// 	Integer memID = (Integer) session.getAttribute("id");
// 	System.out.println("會員編號 : " + memID);
	DefAddressJDBCDAO dadao = new DefAddressJDBCDAO();
	List<DefAddressVO> daVO = dadao.getAll();

	OrderMasterService omSVC = new OrderMasterService();
	
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
	List<OrderMasterVO> list = omSVC.getAll();
	List<OrderMasterVO> list1 = omSVC.getAll();
	
// 	List<OrderMasterVO> list2 =list.
// 								stream()
// 									.filter(o->o.getLeaseID()==memID)
// 										.collect(Collectors.toList());

	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="memSVC" scope="page"
	class="com.member.model.MemberService" />
<jsp:useBean id="mcoSVC" scope="page"
	class="com.member_coupon.model.MemcouponService" />
<jsp:useBean id="daSVC" scope="page"
	class="com.member.model.DefAddressService" />

<html>
<head>
<title>所有訂單資料 - listAllOrderMaster.jsp</title>
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
	background-color:#F0B594;
	height:720px;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
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
</style>
<style>
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
</style>

<style>
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

.signOut{
background-color:#6495ed;
}
</style>

</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
	<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main">
			<div>
				<jsp:useBean id="OrdserMasterSvc" scope="page" class="com.order.model.OrderMasterService" />
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
					<b>選擇訂單編號:</b> 
					<select size="1" name="ordID">
						<c:forEach var="OrderMasterVO" items="${OrdserMasterSvc.all}">
<%-- 							<c:if test="${OrderMasterVO.leaseID == id}"> --%>
								<option value="${OrderMasterVO.ordID}">${OrderMasterVO.ordID}
<%-- 							</c:if> --%>
						</c:forEach>
					</select> 
					<input type="hidden" name="action" value="getOne_For_Display">
					<input type="submit" value="送出">
				</FORM>

				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
					<b>輸入訂單編號 (如1):</b> 
					<input type="text" name="ordID"> 
					<input type="hidden" name="action" value="getOne_For_Display"> 
					<input type="submit" value="送出">
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
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
						<tr>
							<td><a href="<%=request.getContextPath()%>/back_end/order/listAllOrderMaster.jsp">全部</a></td>
							<td><button name="ordStatus" value="0">已成立</button></td>
							<td><button name="ordStatus" value="1">待歸還</button></td>
							<td><button name="ordStatus" value="2">已完成</button></td>
							<td><button name="ordStatus" value="9">已取消</button></td>
						</tr>
						<input type="hidden" name="action" value="get_Status_Display_Manager">
					</FORM>
				</div>
			</table>

			<table id="table-1">
				<tr>
					<th>訂單編號</th>
					
					<th>出租者</th>
					<th>承租者</th>
					<th>交易方式</th>
					<th>折價券</th>
					<th>運送狀態</th>
					<th>付款狀態</th>
					<th>訂單狀態</th>
					<th>訂單日期</th>
					<th>出貨碼</th>
					<th>歸還碼</th>
					<th>超商碼</th>
	
					<th>出貨日期</th>
					<th>到貨日期</th>
					<th>歸還日期</th>
					<th>承租天數</th>

					<th>訂單金額</th>
				</tr>
				<%@ include file="page1.file"%>
				<c:forEach var="omVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">		 
							<tr>
								<td>${omVO.ordID}</td>


								<td>${memSVC.getOneMember(omVO.leaseID).name}</td>
								<td>${memSVC.getOneMember(omVO.rentID).name}</td>

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

								<td>${omVO.shipCode}</td>
								<td>${omVO.returnCode}</td>
								<td>${omVO.storeCode}</td>

								<%-- 						<td>${omVO.estStart}</td> --%>
								<%-- 						<td>${omVO.estEnd}</td> --%>
								<td><fmt:formatDate value="${omVO.shipDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${omVO.arrivalDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${omVO.returnDate}"
										pattern="yyyy-MM-dd" /></td>
								<td>${omVO.rentDays}</td>
								<td>${omVO.ordPrice}</td>
								<td>
									<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/OrderMasterServlet"
										style="margin-bottom: 0px;">
										<input type="submit" value="狀態修改"> 
										<input type="hidden" name="ordID" value="${omVO.ordID}">
										<%-- 								<input type="hidden" name="listID" value="${omVO.ordID}">  --%>
										<input type="hidden" name="action" value="getOne_For_Manager_Update">
									</FORM>
								</td>
								<td>
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/OrderListServlet"
										style="margin-bottom: 0px;">
										<input type="submit" value="查看明細"> 
										<input type="hidden" name="ordID" value="${omVO.ordID}"> 
										<input type="hidden" name="action" value="getlist_For_Manager">
									</FORM>
								</td>
							</tr>
				</c:forEach>
			</table>
			<%@ include file="page2.file"%>
		</main>
	</div>
	<%@ include file="/includeFolder/managerFooter.file"%>
</body>
</html>