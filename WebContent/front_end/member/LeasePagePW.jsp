<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%
	MemberVO memberVO = (MemberVO) session.getAttribute("MemberVO"); //LoginServlet.java (Concroller) 存入session的memberVO物件 (包括幫忙取出的memberVO, 也包括輸入資料錯誤時的memberVO物件)
	pageContext.setAttribute("memberVO", memberVO);
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
	padding: 3px;
	text-align: center;
		font-size:20px;
}
		</style>
</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file" %>
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

			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/member/MemFrontServlet"
				name="form1">
				<h1>更改密碼</h1>
				<div style="font-size:22px;">為確保你帳戶的安全</div>
				<hr>
				<table>
					<tr>
						<td><font color= #191561 ><b>現在密碼</b></font></td>
						<td><input type="password" name="password"
							placeholder="請輸入現在密碼" value=""></td>
					</tr>
					<tr>
						<td><font color= #191561 ><b>新密碼</b></font></td>
						<td><input type="password" name="newPW" placeholder="請輸入新密碼"
							value=""></td>
					</tr>
					<tr>
						<td><font color= #191561 ><b>確認密碼</b></font></td>
						<td><input type="password" name="newPW2"
							placeholder="請確認輸入新密碼" value=""></td>
					</tr>

				</table>

				<input type="hidden" name="action" value="updatePassword"> <input
					type="hidden" name="loginId" value="${memberVO.loginId}"> <input
					type="submit" value="儲存"class="aa-browse-btn" >
				<p class="aa-lost-password">
					<a style="font-size:20px; color:#191561 "
						href="<%=request.getContextPath()%>/front_end/member/LoginForgetPW.jsp">忘記密碼 ?</a>
									
				</p>
			</FORM>
											
		</main>
	</div>

	<%@ include file="/includeFolder/footer2.file" %>
</body>

<script language="javascript">
document.getElementById("password").value = document.getElementById("pwd2").value;
function checkvalue(){
if(docment.formname.password.value==''){
alert("現在密碼不能為空");
document.formname.password.fosus();
}else if(docment.formname.newPW.value==''){
alert("新密碼不能為空");
document.formname.newPW.fosus();
}else if(docment.formname.newPW2.value!=docment.formname.newPW.value){
alert("密碼不一致");
[color=#FF0000]document.formname.repassword.fosus();[/color] }else {
document.formname.action="<%=request.getContextPath()%>/member/MemFrontServlet"
document.formname.method="post";
document.formname.submit();
}
}


</script>
</html>