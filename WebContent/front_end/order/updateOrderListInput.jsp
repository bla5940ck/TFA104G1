<%@page import="com.product.model.ProdVO"%>
<%@page import="com.product.model.ProdService"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.order.model.*"%>

<%
	OrderListVO olVO = (OrderListVO) request.getAttribute("OrderListVO");
	out.println("訂單明細狀態 :" + olVO.getOrdStatus());
	
	OrderListDAOImpl oldao = new OrderListDAOImpl();
	List<OrderListVO> list = oldao.findOrderListByStatus(olVO.getOrdStatus());
	pageContext.setAttribute("list", list);
	
	ProdService prodSVC = new ProdService();
	ProdVO prodVO = prodSVC.findProductByPK(olVO.getProdID());
%>

<% 
    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formatDate = df.format(new java.util.Date());
//     out.println(formatDate);
%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>訂單明細更新:</title>

<style>
 body { 
 	margin: 0; 
 	padding: 10px; 
 } 

img {
	max-width: 100%;
}

 div.main_content { 
 	width: 100%; 
 	margin: 0 auto; 
 	font-size: 0; 
 } 

/*-------------------aside區域------------------- */
aside.aside {
	width: 200px;
	height:620px;
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
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 100px;	
}

table, th, td {
	border: 1px solid lightgrey;
	width: 800px; 
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>
</head>

<body bgcolor='white'>
<%@ include file="/includeFolder/header2.file" %>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<FORM METHOD="post" ACTION="/TFA104G1/OrderListServlet" name="form1">

		<div class="main_content">
			<aside class="aside">
				<nav class="nav">
					<h2>出租者專區</h2>
					<ul class="nav_list">
						<h4><a href="http://localhost:8081/TFA104G1/front_end/order/listAllOrderMaster.jsp">全部訂單</a></h4>
					</ul>
				</nav>
			</aside>
			<main class="main">
			
			
				<div>
					<h4>更新訂單</h4>
					<h4>訂單編號 :<%=olVO.getListID()%></h4>
				</div>
				<table id="table-1">
					<tr>
						<th>訂單明細狀態 :</th>
						<c:choose>
							<c:when test="<%=olVO.getOrdStatus() == 0 %>"><td>已成立</td></c:when>
							<c:when test="<%=olVO.getOrdStatus() == 1 %>"><td>待歸還</td></c:when>							
							<c:when test="<%=olVO.getOrdStatus() == 2 %>"><td>已完成</td></c:when>							
							<c:otherwise><td>已取消</td></c:otherwise>							
						</c:choose>
						
						<td>
						<select size="1" name="ordStatus">
							<option value="0" <%=olVO.getOrdStatus()==0?"selected":"" %>>已成立</option>
							<option value="1" <%=olVO.getOrdStatus()==1?"selected":"" %>>待歸還</option>
							<option value="2" <%=olVO.getOrdStatus()==2?"selected":"" %>>已完成</option>
							<option value="9" <%=olVO.getOrdStatus()==9?"selected":"" %>>已取消</option>
						</select> 
						</td>
					</tr>
			</table>
			<table>
					<tr>
						<th>商品名稱 :</th>
						<td><%=prodVO.getProdName()%></td>
					</tr>
					
					<tr>
						<th>訂單編號 :</th>
						<td><%=olVO.getOrdID()%></td>
					</tr>
					
					<tr>
						<th>商品金額 :</th>
						<td><%=olVO.getProdPrice()%></td>
					</tr>
					
					<tr>
						<th>預計開始日期 :</th>
						<td><%=olVO.getEstStart()%></td>
					</tr>

					<tr>
						<th>預計結束日期 :</th>
						<td><%=olVO.getEstEnd()%></td>
					</tr>
				</table>
			
				<input type="hidden" name="action" value="update"> 
				<input type="hidden" name="listID" value="<%=olVO.getListID()%>">
				<input type="hidden" name="ordID" value="<%=olVO.getOrdID()%>">
			
				<input type="submit" value="確認更新">
			</main>
		</div>
	<%@ include file="/includeFolder/footer2.file" %>
	</FORM>
</body>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

	
</script>
</html>
