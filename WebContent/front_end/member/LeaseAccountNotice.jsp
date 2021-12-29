<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.order.model.*"%>
<%@ page import="java.sql.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%
Integer memID = (Integer) session.getAttribute("id");

OrderMasterService omSVC = new OrderMasterService();
	List<OrderMasterVO> list = omSVC.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="memSVC" scope="page"
	class="com.member.model.MemberService" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Account Notice</title>
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
			border-color: transparent #191561 #191561 transparent;
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
			width: 50%;
			background-color: white;
			margin-top: 5px;
			margin-bottom: 5px;
		}
			table, th, td {
			border: 1px solid lightgrey;
		}
		th, td {
	height: 50px;
	padding: 5px;
	text-align: center;
	font-size:15px;
}

        .li{
            font-size: 14px;
             outline: 0;
   background-color: lightgrey;
    background: 	#F0F0F0;
    text-decoration: none;
    color: #191561 ;
    font-weight: bold;
    		
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
<%@ include file="/includeFolder/rentMemberAside.file"%>
				
		
				<main class="main">
				
					
						<h1>承租款項通知</h1>
						<div style="font-size:22px;">可以留意您的帳務相關資訊</div>
						
						<hr>
						 <c:forEach var="OrderMasterVO"  items="${list}" > 
				<c:if test="${OrderMasterVO.trfStatus==1 }">
					<c:choose>
					 <c:when test="${((OrderMasterVO.rentID == id) and OrderMasterVO.ordStatus==9) 
					 and ((OrderMasterVO.shipStatus==0 or OrderMasterVO.shipStatus==3))}">
						<ul class="li">
					
							<li>訂單日期 : <fmt:parseDate value="${OrderMasterVO.ordDate}" pattern="yyyy-MM-dd" var="ordDate"/>
									<fmt:formatDate value="${ordDate}" pattern="yyyy-MM-dd"/></li>
							
							<li>訂單編號 : <a
								href="/TFA104G1/front_end/order/listAllOrderForRent.jsp?ordID=${OrderMasterVO.ordID}">${OrderMasterVO.ordID}</a></li>
							<li>收款人 : ${memSVC.getOneMember(OrderMasterVO.rentID).accountName}</li>
							<!--<li>金額 : NTD. ${OrderMasterVO.ordPrice}</li> ord_price-ship_fee -->
							<li>金額 : <fmt:formatNumber value= "${OrderMasterVO.ordPrice}" type="currency"/></li><!-- ord_price-ship_fee -->
							<li >預計匯款日期 : <font color="#FF0080"> <fmt:parseDate value="${OrderMasterVO.estTrfDa}" pattern="yyyy-MM-dd" var="estTrfDa"/>
									<fmt:formatDate value="${estTrfDa}" pattern="yyyy-MM-dd"/></font></li>
							
						</ul>
						
						<hr>
						</c:when>
						</c:choose>
					</c:if>
						</c:forEach> 
						
						
					
				 
				 </main>
		</div>
<%@ include file="/includeFolder/footer2.file"%>
	
</body>
</html>