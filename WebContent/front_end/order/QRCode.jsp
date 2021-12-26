<%@ page import="com.order.model.OrderMasterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	Integer memID = (Integer) session.getAttribute("id");
	String ordID = request.getParameter("ordID");
	session.setAttribute("QRcodeOrdID", ordID);

	OrderMasterService omSVC = new OrderMasterService();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Joy Lease面交</title>
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
		
		.cart-img{
			height: 120px;
			width: 120px;
			
		}
		</style>
</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/leaseMemberAside.file"%>
		<main class="main">
			<form METHOD="post" ACTION="/TFA104G1/QRCodeTest?action=toQRcode&ordID=<%=ordID%>"
				name="form1">
				<h4>
					會員<%=memID%>您好 !
				</h4>

				<h4>
					訂單編號 :<%=ordID%>
				</h4>

				<h4>確認收貨請掃QR CODE</h4>

				<img alt=""
					src="<%=request.getContextPath()%>/QRCodeTest?action=toQRcode&ordID=<%=ordID%>">

			</form>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</html>