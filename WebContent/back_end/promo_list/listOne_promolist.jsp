<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="com.promo_list.model.*"%>
<%
  PromolistVO promolistVO = (PromolistVO) request.getAttribute("promolistVO");
%>

<html>
<head>
<title>專案明細資料 - listOne_promolist.jsp</title>

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
	width: 600px;
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

<!-- <h4>此頁暫練習採用 Script 的寫法取值:</h4> -->
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - listOne_promolist.jsp</h3>
		 <h4><a href="select_promolist.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

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
	<tr>
<%-- 		<td><%=promoVO.getPromo_id()%></td> --%>
<%-- 		<td><%=promoVO.getPromo_name()%></td> --%>
<%-- 		<td><%=promoVO.getPromo_start()%></td> --%>
<%-- 		<td><%=promoVO.getPromo_end()%></td> --%>
<%-- 		<td><%=promoVO.getPromo_text()%></td> --%>
<%-- 		<td><%=promoVO.getStatus()%></td> --%>

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
</table>

</body>
</html>