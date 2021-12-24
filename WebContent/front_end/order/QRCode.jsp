<%@page import="com.order.model.OrderMasterService"%>
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
<title>QR Code</title>
</head>
<body>
	<form METHOD="post" ACTION="/TFA104G1/QRCodeTest?action=toQRcode&ordID=<%=ordID%>" name="form1">
		<h4>
			會員<%=memID%>您好 !
		</h4>
		
		<h4>
			訂單編號 :<%=ordID%>
		</h4>
		
		<h4>
			確認收貨請掃QR CODE
		</h4>

		<td><img alt="" src="<%=request.getContextPath()%>/QRCodeTest?action=toQRcode&ordID=<%=ordID%>"> </td>
<!-- 		<input type="hidden" name="action" value="check">  -->
<%-- 		<input type="hidden" name="memID" value=<%=memID%>>  --%>
<!-- 		<input type="submit" value="確認收貨"> -->

	</form>
</body>
</html>