<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

<%
	Integer memID = (Integer) session.getAttribute("id");

	OrderListVO olVO = (OrderListVO) request.getAttribute("OrderListVO");

	OrderListDAOImpl oldao = new OrderListDAOImpl();
	List<OrderListVO> list = oldao.findOrderListByStatus(olVO.getOrdStatus());
	pageContext.setAttribute("list", list);
	
	ProdService prodSVC = new ProdService();
	ProdVO prodVO = prodSVC.findProductByPK(olVO.getProdID());
%>

<html>
<head>
<meta charset="BIG5">
<title>單筆訂單明細頁面</title>
</head>
<style>
body {
	margin: 0;
	padding: 10px;
}

img {
	max-width: 100%;
}

button{
	font-size:13px;
	outline-width: 100%;
	background-color: white;
}

div.main_content {
	width: 100%;
	margin: 0 auto;
	font-size: 0;
	/*   border:1px solid red; */
}
/*-------------------aside區域------------------- */
aside.aside {
	height:620px;
	width: 200px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align:center;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
	width: calc(100% - 200px - 10px);
	height:620px;
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
}

table, th, td {
	border: 1px solid lightgrey;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>
<body bgcolor="white">
	<%@ include file="/includeFolder/header.file"%>
<!-- 	<header class="header"> header區域 </header> -->
	<div class="main_content">
		<aside class="aside">
			<nav class="nav">
				<h3>出租者專區</h3>
				<h5>會員編號 : <%=memID%></h5>
				<ul class="nav_list">
					<h4><a href="<%=request.getContextPath()%>/front_end/order/listAllOrderMaster.jsp">全部訂單</a></h4>
					<h4><a href="<%=request.getContextPath()%>/front_end/order/listSuccessOrder.jsp">訂單評價</a></h4>
				</ul>
			</nav>
		</aside>
		<main class="main">
			<div>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/OrderListServlet">
					<h5>輸入訂單明細編號 (如1): 
					<input type="text" name="listID"> 
					<input type="hidden" name="action" value="getOne_For_Display"> 
					<input type="submit" value="送出"></h5>
				</FORM>
				<jsp:useBean id="OrdserListSvc" scope="page"
					class="com.order.model.OrderListService" />
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/OrderListServlet">
					<h5>選擇訂單明細編號: 
					<select size="1" name="listID">
						<c:forEach var="OrderListVO" items="${OrdserListSvc.all}">
							<option value="${OrderListVO.listID}">${OrderListVO.listID}
						</c:forEach>
					</select> 
					<input type="hidden" name="action" value="getOne_For_Display">
					<input type="submit" value="送出"></h5>
				</FORM>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/OrderListServlet">
					<h5>選擇訂單狀態: 
					<select size="1" name="ordStatus">
						<option value="0">已成立
						<option value="1">待歸還
						<option value="2">已完成
						<option value="9">已取消
					</select> 
					<input type="hidden" name="action" value="get_Status_Display">
					<input type="submit" value="送出"></h5>
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
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/OrderListServlet">
						<tr>
							<td><a href="listAllOrderList.jsp">全部</a></td>
							<td><button name="ordStatus" value="0">已成立</button></td>
							<td><button name="ordStatus" value="1">待歸還</button></td>
							<td><button name="ordStatus" value="2">已完成</button></td>
							<td><button name="ordStatus" value="9">已取消</button></td>
						</tr>
						<input type="hidden" name="action" value="get_Status_Display">
					</FORM>
				</div>
			</table>	
			<table id="table-1">
				<tr>
					<th>訂單明細編號</th>
					<th>商品編號</th>
					<th>商品名稱</th>
					<th>訂單編號</th>
					<th>訂單金額</th>
					<th>預計開始日期</th>
					<th>預計結束日期</th>
					<th>訂單狀態</th>
				</tr>
				<tr>
					<td><%=olVO.getListID()%></td>
					<td><%=olVO.getProdID()%></td>
					<td><%=prodVO.getProdName()%></td>
					<td><%=olVO.getOrdID()%></td>
					<td><%=olVO.getProdPrice()%></td>
					<td><%=olVO.getEstStart()%></td>
					<td><%=olVO.getEstEnd()%></td>
					<c:choose>
						<c:when test="<%=olVO.getOrdStatus() == 0%>">
							<td>已成立</td>
						</c:when>
						<c:when test="<%=olVO.getOrdStatus() == 1%>">
							<td>待歸還</td>
						</c:when>
						<c:when test="<%=olVO.getOrdStatus() == 2%>">
							<td>已完成</td>
						</c:when>
						<c:otherwise>
							<td>已取消</td>
						</c:otherwise>
					</c:choose>
					<td>
						<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/OrderMasterServlet" style="margin-bottom: 0px;">
						<input type="submit" value="查看明細"> 
						<input type="hidden" name="listID" value="<%=olVO.getListID()%>"> 
						<input type="hidden" name="ordStatus" value="<%=olVO.getOrdStatus()%>"> 
						<input type="hidden" name="ordID" value="<%=olVO.getOrdID()%>"> 
						<input type="hidden" name="action" value="getOne_For_Display">
						</FORM>
					</td>
				</tr>
			</table>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file" %>
<!-- 	<footer class="footer"> footer區域 </footer> -->
</body>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	
</script>
</html>