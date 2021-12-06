<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.order.model.*"%>

<%
	OrderMasterVO omVO = (OrderMasterVO) request.getAttribute("OrderMasterVO");
// 	OrderListVO olVO = (OrderListVO) request.getAttribute("OrderListVO");
// 	out.println(olVO.getListID());
%>

<% 
    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formatDate = df.format(new java.util.Date());
//     out.println(formatDate);
%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>訂單資料更新:</title>

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
	<FORM METHOD="post" ACTION="/TFA104G1/OrderMasterServlet" name="form1">

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
					<h4>訂單編號 :<%=omVO.getOrdID()%></h4>
				</div>
				<table>
					<tr>
						<th>運送狀態 :</th>
						<td><p id="shipS"><%=omVO.getShipStatus()%></p></td>
						<td><select name="shipStatus" size="1" id="s">
								<option value="0">待出貨</option>
								<option value="1">已出貨</option>
								<option value="2">待取貨</option>
								<option value="3">取貨完成</option>
								<option value="9">商品遺失</option>
						</select></td>
					</tr>
					<tr>
						<th>付款狀態 :</th>
						<td><p id="payS"><%=omVO.getPayStatus()%></p></td>
						<td><select name="payStatus" size="1">
								<option value="0">待付款</option>
								<option value="1">已付款</option>
						</select></td>
					</tr>
					<tr>
						<th>訂單狀態 :</th>
						<td><p id="ordS"><%=omVO.getOrdStatus()%></p></td>
						<td><select name="ordStatus" size="1">
								<option value="0">已成立</option>
								<option value="1">待歸還</option>
								<option value="2">已完成</option>
								<option value="9">已取消</option>
						</select></td>
					</tr>
				</table>
				<table>
					<tr>
						<th>出貨代碼</th>
						<td><input type="TEXT" name="shipCode" size="20"
							value="<%=omVO.getShipCode().equals(0) ? "" : omVO.getShipCode()%>"></td>

					</tr>

					<tr>
						<th>歸還代碼</th>
						<td><input type="TEXT" name="returnCode" size="20"
							value="<%=omVO.getReturnCode().equals(0) ? "" : omVO.getReturnCode()%>" /></td>
					</tr>

				</table>
					<input type="button" onclick="ShowShipDate()" value="出貨時間 ">
					<input type="button" onclick="ShowArrivalDate()" value="到貨時間 ">
					<input type="button" onclick="ShowReturnDate()" value="歸還時間 ">
				<table>
					<tr>
						<th>出貨日期</th>
						<td><input type="hidden"  id="getShipDate">
						<p id="shipDate">${OrderMasterVO.shipDate}</p></td>
					</tr>
					<tr>
						<th>實際到貨日期</th>
						<td><input type="hidden" id="getArrivalDate">
						<p id="arrivalDate">${OrderMasterVO.arrivalDate}</p></td>																	
					</tr>
					<tr>
						<th>實際歸還日期</th>
						<td><input type="hidden" id="getReturnDate">
						<p id="returnDate">${OrderMasterVO.returnDate}</p></td>
					</tr>
				</table>
				<table>
					<tr>
						<th>承租方評價</th>
						<td><p id="rr"><%=omVO.getRentRank()%></p></td>
						<td><select name="rentRank" size="1">
								<option value="${OrderMasterVO.rentRank}">評價</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
						</select></td>
					</tr>
					<tr>
						<th>出租方評價</th>
						<td><p id="lr"><%=omVO.getLeaseRank()%></p></td>
						<td><select name="leaseRank" size="1">
								<option value="${OrderMasterVO.leaseRank}">評價</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
						</select></td>
					</tr>
					<tr>
						<th>承租方評論</th>
						<td><p id="rc"><%=omVO.getRentComt() == null?"尚未評論":omVO.getRentComt()%></p></td>
						<td><select name="rentComt">
								<option value="${OrderMasterVO.rentComt}">請選擇</option>
								<option value="出貨快 !">出貨快 !</option>
								<option value="價格合理 !">價格合理 !</option>
								<option value="溝通良好 !">溝通良好 !</option>
								<option value="態度不佳 !">態度不佳 !</option>
								<option value="出貨速度慢 !">出貨速度慢 !</option>
								<option value="與照片不符 !">與照片不符 !</option>
								
						</select></td>
					</tr>
					<tr>
						<th>出租方評論</th>
						<td><p id="lc"><%=omVO.getLeaseComt() == null?"尚未評論":omVO.getLeaseComt() %></p></td>
						<td><select name="leaseComt">
								<option value="${OrderMasterVO.leaseComt}">請選擇</option>
								<option value="出貨快 !">歸還快速 !</option>
								<option value="價格合理 !">愉快的交易 !</option>
								<option value="溝通良好 !">溝通良好 !</option>
								<option value="態度不佳 !">態度不佳 !</option>
								<option value="出貨速度慢 !">還貨速度慢 !</option>
								<option value="不愛惜物品 !">不愛惜物品 !</option>
						</select></td>
					</tr>
				</table>
				<input type="hidden" name="action" value="update"> 
				<input type="hidden" name="ordID" value="<%=omVO.getOrdID()%>">
				<jsp:useBean id="olDAO"	class="com.order.model.OrderListDAOImpl" /> 
				<c:forEach var="olVO" items="${olDAO.getAllOrderList()}">
				<input type="hidden" name="listID" value="${olVO.listID}">
				</c:forEach>
<%-- 				<input type="hidden" name="listID" value="<%=olVO.getListID()%>"> --%>
				<input type="hidden" name="shipDate" id="shipTimelong" value="<%=omVO.getShipDate()== null ? "" : omVO.getShipDate().getTime()%>">
				<input type="hidden" name="arrivalDate" id="arrivalTimelong" value="<%=omVO.getArrivalDate()== null ? "" : omVO.getArrivalDate().getTime()%>">
				<input type="hidden" name="returnDate" id="returnTimelong" value="<%=omVO.getReturnDate()== null ? "" : omVO.getReturnDate().getTime()%>">
				<input type="hidden" name="rentComtdate" value="${OrderMasterVO.rentComtdate}">
				<input type="hidden" name="leaseComtdate" value="${OrderMasterVO.leaseComtdate}">
				<input type="submit" value="確認更新">
			</main>
		</div>
	<%@ include file="/includeFolder/footer2.file" %>
	</FORM>
</body>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

var shipDate = $("#shipDate");
var getShipDate = $("#getShipDate");
var shipTimelong = $("#shipTimelong");

function ShowShipDate(){
	
	var Today=new Date();
 	var shipTime = (Today.getFullYear()+ "-" + (Today.getMonth()+1) + "-" 
 	+ Today.getDate() + " " + Today.getHours() + ":" + Today.getMinutes() + ":" + Today.getSeconds());
	shipDate.text(shipTime);
	document.getElementById("getShipDate").setAttribute('value', shipTime);
	var shipTimelong = (Today.getTime());
	document.getElementById("shipTimelong").setAttribute('value', shipTimelong);
	
};
	
	
var arrivalDate = $("#arrivalDate");
var getArrivalDate = $("#getArrivalDate");
var arrivalTimelong = $("#arrivalTimelong");

function ShowArrivalDate(){
	var Today=new Date();
 	var arrivalTime = (Today.getFullYear()+ "-" + (Today.getMonth()+1) + "-" 
 	+ Today.getDate() + " " + Today.getHours() + ":" + Today.getMinutes() + ":" + Today.getSeconds());
 	arrivalDate.text(arrivalTime);	
	document.getElementById("getArrivalDate").setAttribute('value', arrivalTime);
	var arrivalTimelong = (Today.getTime());
	document.getElementById("arrivalTimelong").setAttribute('value', arrivalTimelong);

};

var returnDate = $("#returnDate");
var getReturnDate = $("#getReturnDate");
var returnTimelong = $("#returnTimelong");

function ShowReturnDate(){
	var Today=new Date();
 	var returnTime = (Today.getFullYear()+ "-" + (Today.getMonth()+1) + "-" 
 	+ Today.getDate() + " " + Today.getHours() + ":" + Today.getMinutes() + ":" + Today.getSeconds());
 	returnDate.text(returnTime);	
	document.getElementById("getReturnDate").setAttribute('value', returnTime);
	var returnTimelong = (Today.getTime());
	document.getElementById("returnTimelong").setAttribute('value', returnTimelong);

};	
	/*=====運送狀態=====*/

	var shipS = $("#shipS");
	if (<%=omVO.getShipStatus()%>== 0) {
		shipS.text("待出貨");
	} else if (<%=omVO.getShipStatus()%>== 1) {
		shipS.text("已出貨");
	} else if (<%=omVO.getShipStatus()%>== 2) {
		shipS.text("待取貨");
	} else if (<%=omVO.getShipStatus()%>== 3) {
		shipS.text("取貨完成");
	} else if (<%=omVO.getShipStatus()%>== 7) {
		shipS.text("物流商品遺失");
	} else if (<%=omVO.getShipStatus()%>== 8) {
		shipS.text("未取貨");
	} else {
		shipS.text("寄送異常");
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
	
	/*=====承租方評級=====*/
	var rr = $("#rr");
	if(<%=omVO.getRentRank()%> == 1){
		rr.text("1");
	}else if(<%=omVO.getRentRank()%> == 2){
		rr.text("2");
	}else if(<%=omVO.getRentRank()%> == 3){
		rr.text("3");
	}else if(<%=omVO.getRentRank()%> == 4){
		rr.text("4");
	}else if(<%=omVO.getRentRank()%> == 5){
		rr.text("5");
	}else{
		rr.text("尚未評分");
	}
	/*=====出租方評級=====*/
	var lr = $("#lr");
	if(<%=omVO.getLeaseRank()%> == 1){
		lr.text("1");
	}else if(<%=omVO.getLeaseRank()%> == 2){
		lr.text("2");
	}else if(<%=omVO.getLeaseRank()%> == 3){
		lr.text("3");
	}else if(<%=omVO.getLeaseRank()%> == 4){
		lr.text("4");
	}else if(<%=omVO.getLeaseRank()%> == 5){
		lr.text("5");
	}else{
		lr.text("尚未評分");
	}
	
	/*=====承租方評論=====*/

	
</script>
</html>
