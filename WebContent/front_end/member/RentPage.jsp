<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%--
  MemberVO memberVO = (MemberVO) session.getAttribute("MemberVO"); //LoginServlet.java (Concroller) 存入session的memberVO物件 (包括幫忙取出的memberVO, 也包括輸入資料錯誤時的memberVO物件)
  pageContext.setAttribute("memberVO",memberVO);
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>出租專區</title>
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
	background-color: white;
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
	<%-- 	<aside class="aside">
			<nav class="nav">
			<div>
				<a class="" href="<%=request.getContextPath()%>/front_end/member/RentPage.jsp">
					<td>
														<c:set var="img" value="${memberVO.pic}" />
														<%
														byte b[] = (byte[]) pageContext.getAttribute("img");
															String pic = Base64.encode(b);
															if (null == pic || "".equals(pic))
																pic ="123";
														%>
														<img class="idc" src="data:image/jpg;base64,<%=pic%>"width="120">
													</td>
												    <td>${memberVO.loginId}</td>
				</a>
			</div>
				<h1>出租專區</h1>
				<ul class="nav_list">
				<!-- 
					<li><a href="RentPage.jsp">我的帳戶</a>
						<ul class="nav_list">
							<li><a href="">個人檔案</a></li>
							<li><a href="">銀行帳號</a></li>
							<li><a href="">地址</a></li>
							<li><a href="">更改密碼</a></li>
						</ul>
					</li> -->
					<li><a href="">訂單資訊</a></li>
					<li><a href="">商品管理</a></li>
					<li><a href="">通知</a></li>
						<ul class="nav_list">
							<li><a href="">訂單更新通知</a></li>
							<li><a href="">評價通知</a></li>
							<li><a href="">款項通知</a></li>
						</ul>
					<li><a href="">問題回報查詢</a></li>
					
				</ul>
			</nav>
		</aside>--%>
		<main class="main">
		</main>

	</div>


<%@ include file="/includeFolder/footer2.file"%>
</body>
</html>