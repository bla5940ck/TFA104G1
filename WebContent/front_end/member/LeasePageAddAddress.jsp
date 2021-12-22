<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>

<%
  MemberVO memberVO = (MemberVO) session.getAttribute("MemberVO"); //LoginServlet.java (Concroller) 存入session的memberVO物件 (包括幫忙取出的memberVO, 也包括輸入資料錯誤時的memberVO物件)
  pageContext.setAttribute("memberVO",memberVO);
  
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>承租專區</title>
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
			margin-right: 10px;
			border: 1px solid #999;
		}
		
		/*--------------------main區域-------------------- */
		main.main {
			background-color: white;
			width: calc(100% - 200px - 10px);
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			border: 1px solid #999;
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
				
				<%
					DefAddressService dfaSvc = new DefAddressService();
					List<DefAddressVO> list = dfaSvc.getOneMemAll(memberVO.getMemberId());
					pageContext.setAttribute("list",list);
				%>
				<main class="main">
				
					
						<h1>地址</h1>
						<div>管理你的寄送相關資訊</div>
						
					<FORM METHOD="post"  ACTION="<%=request.getContextPath()%>/member/MemFrontServlet" name="form1">
						<h1>新增超商地址</h1>
						<div>管理你的寄送相關資訊</div>
						<table>
								<tr>
									<td>是否設為預設取件資訊 : </td>
									<td><input type="checkbox" name="status" value="1"></td>
								</tr>
								<tr>
									<td>收件姓名 : <font color=red><b>*</b></font> </td>
									<td><input type="TEXT" name="recipient" size="45" value="" /></td>
								</tr>
								<tr>
									<td>收件電話 : </td>
									<td><input type="TEXT" name="recptPhone" size="45" value="" /></td>
								</tr>
								<tr>
									<td>收件超商代碼 : </td>
									<td><input type="TEXT" name="code711" size="45" value="" /></td>
								</tr>
								<tr>
									<td>收件超商 : </td>
									<td><input type="TEXT" name="name711" size="45" value="" /></td>
								</tr>
								<tr>
									<td>超商地址 : </td>
									<td><input type="TEXT" name="add711" size="45" value="" /></td>
								</tr>
						</table>
					<input type="hidden" name="action" value="insertAddress">
					<input type="hidden" name="memberId" value="${memberVO.memberId}">
					<input type="submit" value="增加"></FORM>
						
						
					
				 
				 </main>
		</div>
						
		<%@ include file="/includeFolder/footer2.file"%>
	</body>
<script>
	function showPic(picPath){
		pic = document.getElementById("imgShow");
		pic.src = "file:///" + picPath;
		pic.width = 300;
		pic.style.visibility = "visible";
		}
</script>
</html>