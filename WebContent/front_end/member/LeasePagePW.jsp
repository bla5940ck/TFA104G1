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
	padding: 10px;
}

img {
	max-width: 100%;
}

header.header {
	background-color: #ddd;
	width: 100%;
	margin: 0 auto 10px auto;
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
	background-color: #ddd;
	width: 200px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: #ddd;
	width: calc(100% - 200px - 10px);
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
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
	<header class="header"> header區域 </header>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<div class="main_content">
		<aside class="aside">
			<nav class="nav">
				<div>
					<a class=""
						href="<%=request.getContextPath()%>/front_end/member/LeasePage.jsp">
						<div>
							<td><c:set var="img" value="${memberVO.pic}" /> <%
 	byte b[] = (byte[]) pageContext.getAttribute("img");
 	String pic = Base64.encode(b);
 	if (null == pic || "".equals(pic))
 		pic = "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";
 %> <img class="idc" src="data:image/jpg;base64,<%=pic%>" width="120"></td>
							<td>${memberVO.loginId}</td>
							<%-- <img class="" src="<%=request.getContextPath()%>/front_end/member/img/LogingPIC.jpg"> --%>
						</div>
					</a>
				</div>
				<h1>承租專區</h1>
				<ul class="nav_list">
					<li><a
						href="<%=request.getContextPath()%>/front_end/member/LeasePage.jsp">我的帳戶</a>
						<ul class="nav_list">
							<li><a
								href="<%=request.getContextPath()%>/front_end/member/LeasePage.jsp">個人檔案</a></li>
							<li><a
								href="<%=request.getContextPath()%>/front_end/member/LeasePageAccount.jsp">銀行帳號</a></li>
							<li><a
								href="<%=request.getContextPath()%>/front_end/member/LeasePageAddress.jsp">地址</a></li>
							<li><a
								href="<%=request.getContextPath()%>/front_end/member/LeasePagePW.jsp">更改密碼</a></li>
						</ul></li>
					<li><a href="">訂單資訊</a></li>
					<li><a href="">通知</a></li>
					<ul class="nav_list">
						<li><a href="">訂單更新通知</a></li>
						<li><a href="">評價通知</a></li>
						<li><a href="<%=request.getContextPath()%>/front_end/member/LeaseAccountNotice.jsp">款項通知</a></li>
					</ul>
					<li><a href="">問題回報查詢</a></li>
					<li><a href="">我的折價券</a></li>
				</ul>
			</nav>
		</aside>
		<main class="main">

			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/member/MemFrontServlet"
				name="form1">
				<h1>更改密碼</h1>
				<div>為確保你帳戶的安全</div>
				<table>
					<tr>
						<td>現在密碼 : <font color=red><b>*</b></font></td>
						<td><input type="password" name="password"
							placeholder="請輸入現在密碼" value=""></td>
					</tr>
					<tr>
						<td>新密碼 : <font color=red><b>*</b></font></td>
						<td><input type="password" name="newPW" placeholder="請輸入新密碼"
							value=""></td>
					</tr>
					<tr>
						<td>確認密碼 : <font color=red><b>*</b></font></td>
						<td><input type="password" name="newPW2"
							placeholder="請確認輸入新密碼" value=""></td>
					</tr>

				</table>

				<input type="hidden" name="action" value="updatePassword"> <input
					type="hidden" name="loginId" value="${memberVO.loginId}"> <input
					type="submit" value="儲存">
				<p class="aa-lost-password">
					<a
						href="<%=request.getContextPath()%>/front_end/member/ForgetPW.jsp">Forget
						Password ?</a>
				</p>
			</FORM>
		</main>
	</div>

	<footer class="footer"> footer區域 </footer>
</body>

document.getElementById("password").value = document.getElementById("pwd2").value;
<script language="javascript">
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