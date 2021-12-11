<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
=======
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
>>>>>>> 84898b661e8ecb2d4b9102291d2ebf7fbf801ed0
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.problemtype.model.*"%>

<%
	ProblemTypeVO ptVO = (ProblemTypeVO) request.getAttribute("problemtypeVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<<<<<<< HEAD
<title>å“¡å·¥è³‡æ–™æ–°å¢ - addEmp.jsp</title>
=======
<title>­û¤u¸ê®Æ·s¼W - addEmp.jsp</title>
>>>>>>> 84898b661e8ecb2d4b9102291d2ebf7fbf801ed0

<style>
body {
	margin: 0;
	padding: 10px;
}

img {
	max-width: 100%;
}

button {
	font-size: 13px;
	outline-width: 100%;
	background-color: white;
}

div.main_content {
	width: 100%;
	margin: 0 auto;
	font-size: 0;
}



<<<<<<< HEAD
/*-------------------asideå€åŸŸ------------------- */
=======
/*-------------------aside°Ï°ì------------------- */
>>>>>>> 84898b661e8ecb2d4b9102291d2ebf7fbf801ed0
aside.aside {
	width: 200px;
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
}

<<<<<<< HEAD
/*--------------------mainå€åŸŸ-------------------- */
=======
/*--------------------main°Ï°ì-------------------- */
>>>>>>> 84898b661e8ecb2d4b9102291d2ebf7fbf801ed0
main.main {
	background-color: white;
	width: calc(100% - 200px - 10px);
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	width: 80%;
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

<style>



h2 {
	color: blue;
	display: inline;
}

.signOut{
	background-color:#6495ed;
}
</style>

</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
<<<<<<< HEAD
		<%@ include file="/includeFolder/managerAside.file"%>
=======
		<aside class="aside">
			<nav class="nav">
				<ul class="nav_list" style="background-color:#F0B594;height:100%">
					<h2>
						<a href='<%=request.getContextPath()%>/back_end/manager/select_page.jsp'>ºŞ²zªÌ±M°Ï</a> <br> 
						<a href='<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp'>°İÃD³B²z</a> <br> 
						<a>°Ó«~ºŞ²z</a> <br>
						<a>­q³æºŞ²z</a> <br> 
						<a>·|­ûºŞ²z</a> <br> 
						<a>±b°ÈºŞ²z</a> <br>
						<a>·|­û¼f®Ö</a> <br> 
						<a>±M®×±M°Ï</a>
					</h2>
					<form action="/TFA104G1/ManagerServlet" method="post" >
				<button class="signOut" type="submit">sign out</button>
				<input type="hidden" name="action" value="sign_out" />
				</form>
				</ul>
			</nav>
		</aside>
>>>>>>> 84898b661e8ecb2d4b9102291d2ebf7fbf801ed0
		<main class="main" style="background-color:#C0C0C0;">		
				<tr>					
					<td>
						<h4>
<<<<<<< HEAD
							<a href="select_page.jsp">å›é¦–é </a>
						</h4>
					</td>
				</tr>
			<%-- éŒ¯èª¤è¡¨åˆ— --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">è«‹ä¿®æ­£ä»¥ä¸‹éŒ¯èª¤:</font>
=======
							<a href="select_page.jsp">¦^­º­¶</a>
						</h4>
					</td>
				</tr>
				<br>
			<%-- ¿ù»~ªí¦C --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">½Ğ­×¥¿¥H¤U¿ù»~:</font>
>>>>>>> 84898b661e8ecb2d4b9102291d2ebf7fbf801ed0
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/ProblemTypeServlet" name="form1">
				<tr>
<<<<<<< HEAD
					<td>å•é¡Œé¡å‹:</td>
					<td><input type="TEXT" name="typeName" size="45" /></td>
						<input type="hidden" name="action" value="insert">
						<input type="submit" value="é€å‡ºæ–°å¢"></FORM>
=======
					<td>°İÃDÃş«¬:</td>
					<td><input type="TEXT" name="typeName" size="45" /></td>
						<input type="hidden" name="action" value="insert">
						<input type="submit" value="°e¥X·s¼W"></FORM>
>>>>>>> 84898b661e8ecb2d4b9102291d2ebf7fbf801ed0
				</tr>
				</FORM>
		</main>
	</div>
</body>
</html>