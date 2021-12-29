<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單狀態查詢</title>
<%
	Integer memID = (Integer) session.getAttribute("id");

	OrderListDAOImpl oldao = new OrderListDAOImpl();
	OrderListVO olVO = (OrderListVO) request.getAttribute("OrderListVO");
	
	OrderListService olSVC = new OrderListService();
	List<OrderListVO> list = olSVC.getOrdID(olVO.getOrdID());
	
// 	List<OrderListVO> list = oldao.findOrderListByStatus(olVO.getOrdStatus());
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="prodSVC" scope="page" class="com.product.model.ProdService" />
<jsp:useBean id="omSVC" scope="page" class="com.order.model.OrderMasterService" />


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
		.back_btn{
			background-color: #191561;
   			border: 1px solid #191561;
   			color: white;
		}
		</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
	<div class="main_content">
	<%@ include file="/includeFolder/leaseMemberAside.file"%>
		<main class="main">
		<br>		
			<h1>訂單明細</h1>
			<hr>
			<c:forEach var="olVO" items="${list}">
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/memberservice/problemTypeReport.jsp" name="form1">
					<ul>
						<h4>
						<li>商品名稱 : ${prodSVC.findProductByPK(olVO.prodID).prodName}</li>
						<li>商品金額 : ${olVO.prodPrice}</li>
						<li>預計開始日期 : ${omSVC.getOneOrderMaster(olVO.ordID).estStart}</li>
						<li>預計結束日期 : ${omSVC.getOneOrderMaster(olVO.ordID).estEnd}</li>
						<li>出貨碼 : ${omSVC.getOneOrderMaster(olVO.ordID).shipCode == 0 ?"尚未出貨" :omSVC.getOneOrderMaster(olVO.ordID).shipCode} </li>
						<li>歸還碼 : ${omSVC.getOneOrderMaster(olVO.ordID).returnCode == 0 ?"尚未歸還 " :omSVC.getOneOrderMaster(olVO.ordID).returnCode}</li>
						<li>超商碼 : ${omSVC.getOneOrderMaster(olVO.ordID).storeCode == 0 ?"還未至超商寄貨" :omSVC.getOneOrderMaster(olVO.ordID).storeCode}</li>
						<li class="status">訂單狀態 : 
						<c:choose>
							<c:when test="${olVO.ordStatus == '0'}">已成立</c:when>
							<c:when test="${olVO.ordStatus == '1'}">待歸還</c:when>							
							<c:when test="${olVO.ordStatus == '2'}">已完成</c:when>							
							<c:when test="${olVO.ordStatus == '9'}">已取消</c:when>								
						</c:choose>
						</li>
						</h4>
					</ul>
					<br>
						<input class="aa-browse-btn" type="submit" value="提出問題">
						<input type="hidden" id="ordID" name="ordID" value="${olVO.ordID}">
						<input type="hidden" id="listID" name="listID" value="${olVO.listID}">
						<input type="hidden" id="proID" name="prodID" value="${olVO.prodID}">
						<input type="hidden" name="action" value="updateList"> 
				</FORM>	
			</c:forEach>
			<hr>
			<center><button class="back_btn" href="<%=request.getContextPath()%>/front_end/order/listAllOrderForRent.jsp">回上頁</button></center>
		</main>
		</div>
	<%@ include file="/includeFolder/footer2.file" %>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

$("button.back_btn").click(function(){
	history.go(-1);
});

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