<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.promo_list.model.*"%>

<%
    PromolistService promolistSvc = new PromolistService();
    List<PromolistVO> list = promolistSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有專案明細資料 - listAll_promolist.jsp</title>

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
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>所有專案明細資料 - listall_promolist.jsp</h3>
		 <h4><a href="select_promolist.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<!-- coupon_id, promo_id, category_id, coupon_name, discount, amount, used, start_date, end_date -->
<table>
	<tr>
		<th>折價券編號</th>
		<th>專案編號</th>
		<th>商品類別編號</th>
		<th>折價券名稱</th>
		<th>折價金額</th>
		<th>數量</th>
		<th>已領取數量</th>
		<th>開始日期</th>
		<th>結束日期</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="promolistVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${promolistVO.coupon_id}</td>
			<td>${promolistVO.promo_id}</td>
			<td>${promolistVO.category_id}</td>
			<td>${promolistVO.coupon_name}</td>
			<td>${promolistVO.discount}</td>
			<td>${promolistVO.amount}</td>
			<td>${promolistVO.used}</td> 
			<td>${promolistVO.start_date}</td>
			<td>${promolistVO.end_date}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/promo_list/promolist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="coupon_id"  value="${promolistVO.coupon_id}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/promo_list/promolist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="coupon_id"  value="${promolistVO.coupon_id}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>