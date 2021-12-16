<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

<%
	OrderListDAOImpl oldao = new OrderListDAOImpl();
	OrderListVO olVO = (OrderListVO) request.getAttribute("OrderListVO");
	
	OrderListService olSVC = new OrderListService();
	List<OrderListVO> list = olSVC.getOrdID(olVO.getOrdID());
	
// 	List<OrderListVO> list = oldao.findOrderListByStatus(olVO.getOrdStatus());
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="prodSVC" scope="page" class="com.product.model.ProdService" />
<jsp:useBean id="omSVC" scope="page" class="com.order.model.OrderMasterService" />


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

button{
	font-size:13px;
	outline-width: 100%;
	background-color:white;
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
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main">
			
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
		<FORM METHOD="post" ACTION="/TFA104G1/OrderListServlet" name="form1">
			<table id="table-1">
				<tr>
					<th>訂單明細編號</th>
					<th>商品編號</th>
					<th>商品名稱</th>
					<th>訂單編號</th>
					<th>商品金額</th>
					<th>預計開始日期</th>
					<th>預計結束日期</th>
					<th>訂單狀態</th>
				</tr>
				<%@ include file="page1.file"%>
				<c:forEach var="olVO" items="${list}" begin="<%=pageIndex%>"
					end="<%=pageIndex+rowsPerPage-1%>">
					<tr>

						<td>${olVO.listID}</td>
						<td>${olVO.prodID}</td>
						<td>
							${prodSVC.findProductByPK(olVO.prodID).prodName}
						</td>
						<td>${olVO.ordID}</td>
						<td>${olVO.prodPrice}</td>
						<td>${omSVC.getOneOrderMaster(olVO.ordID).estStart}</td>
						<td>${omSVC.getOneOrderMaster(olVO.ordID).estEnd}</td>
						
						<td class="status">
						<c:choose>
							<c:when test="${olVO.ordStatus == '0'}">已成立</c:when>
							<c:when test="${olVO.ordStatus == '1'}">待歸還</c:when>							
							<c:when test="${olVO.ordStatus == '2'}">已完成</c:when>							
							<c:when test="${olVO.ordStatus == '9'}">已取消</c:when>								
						</c:choose>
						</td>
						
						<td>
								
								<input type="hidden" id="ordID" name="ordID" value="${olVO.ordID}">
								<input type="hidden" id="listID" name="listID" value="${olVO.listID}">
								<input type="hidden" id="proID" name="prodID" value="${olVO.prodID}">
								<input type="hidden" name="action" value="updateList"> 
						</td>
					<tr>
				</c:forEach>
				</table>
<!-- 				<input type="submit" value="更新"> -->
				<button type="button" id="btn">更新</button>
			</FORM>
			<%@ include file="page2.file"%>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file" %>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

var ordStatus = $("select.ordStatus");

var map = new Map();
ordStatus.change(function(){
// 	console.log(ordStatus.val());
	if($(this).val() == 0){
		$(this).closest('tr').find('td.status').eq(0).text("已成立");
	}else if($(this).val() == 1){
		$(this).closest('tr').find('td.status').eq(0).text("待歸還");
	}else if($(this).val() == 2){
		$(this).closest('tr').find('td.status').eq(0).text("已完成");	
	}else if($(this).val() == 9){
		$(this).closest('tr').find('td.status').eq(0).text("已取消");
	}
	var ordID = $("#ordID").val();
	var listID = $(this).closest('tr').find('input').eq(1).val();
	
// 	console.log(ordID);
// 	console.log(listID);
	
	map.set(listID, $(this).val());
	
	
});
// console.log(map.size);

	$("#btn").click(function(){
	console.log(map);
	var obj = Object.create(null);
	
	var iterator = map.keys();
	for(var i = 0; i < map.size; i++){
		var key = iterator.next().value;
		obj[key] = map.get(key);
	}
	var mapString = JSON.stringify(obj);
	console.log(mapString);
	
		$.ajax({
			url:"<%=request.getContextPath()%>/OrderListServlet",
			type:"POST",
			data:{
				listMap: mapString,
				ordID: $("#ordID").val(),
				prodID: $("#prodID").val(),
				action: "updateList",
			},
			dataType: 'json',
			success: function(data){
			console.log("到這");
			},
	
		})

	})



</script>
</html>