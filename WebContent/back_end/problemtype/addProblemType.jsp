<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
=======
<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
=======
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
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
<<<<<<< HEAD
<title>ï¿½âˆªæ¥µéˆï¿½ï¿½ï¿½ï¿½å•£ï¿½ - addEmp.jsp</title>
=======
<title>å“¡å·¥è³‡æ–™æ–°å¢ - addEmp.jsp</title>
=======
<title>å“¡å·¥è³‡æ–™æ–°å¢ - addEmp.jsp</title>
=======
<title>­û¤u¸ê®Æ·s¼W - addEmp.jsp</title>
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
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
<<<<<<< HEAD
/*-------------------asideï¿½ï¿½ï¿½ï¿½------------------- */
=======
/*-------------------asideå€åŸŸ------------------- */
=======
/*-------------------asideå€åŸŸ------------------- */
=======
/*-------------------aside°Ï°ì------------------- */
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
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
<<<<<<< HEAD
/*--------------------mainï¿½ï¿½ï¿½ï¿½-------------------- */
=======
/*--------------------mainå€åŸŸ-------------------- */
=======
/*--------------------mainå€åŸŸ-------------------- */
=======
/*--------------------main°Ï°ì-------------------- */
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
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
<<<<<<< HEAD
						<a href='<%=request.getContextPath()%>/back_end/manager/select_page.jsp'>ç®¡ç†è€…å°ˆå€</a> <br> 
						<a href='<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp'>å•é¡Œè™•ç†</a> <br> 
						<a>å•†å“ç®¡ç†</a> <br>
						<a>è¨‚å–®ç®¡ç†</a> <br> 
						<a>æœƒå“¡ç®¡ç†</a> <br> 
						<a>å¸³å‹™ç®¡ç†</a> <br>
						<a>æœƒå“¡å¯©æ ¸</a> <br> 
						<a>å°ˆæ¡ˆå°ˆå€</a>
=======
						<a href='<%=request.getContextPath()%>/back_end/manager/select_page.jsp'>ºŞ²zªÌ±M°Ï</a> <br> 
						<a href='<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp'>°İÃD³B²z</a> <br> 
						<a>°Ó«~ºŞ²z</a> <br>
						<a>­q³æºŞ²z</a> <br> 
						<a>·|­ûºŞ²z</a> <br> 
						<a>±b°ÈºŞ²z</a> <br>
						<a>·|­û¼f®Ö</a> <br> 
						<a>±M®×±M°Ï</a>
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
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
<<<<<<< HEAD
							<a href="select_page.jsp">ï¿½ï¿½æ“ï¿½ï¿½ï¿½</a>
						</h4>
					</td>
				</tr>
			<%-- ï¿½èˆªç‚ŠéŠµå…¸ï¿½ï¿½ --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">éš¢ï¿½é½æ ¼è¿¤éšä¹©ï¿½ï¿½èˆªç‚Š:</font>
=======
=======
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
							<a href="select_page.jsp">å›é¦–é </a>
						</h4>
					</td>
				</tr>
				<br>
			<%-- éŒ¯èª¤è¡¨åˆ— --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">è«‹ä¿®æ­£ä»¥ä¸‹éŒ¯èª¤:</font>
<<<<<<< HEAD
=======
=======
							<a href="select_page.jsp">¦^­º­¶</a>
						</h4>
					</td>
				</tr>
				<br>
			<%-- ¿ù»~ªí¦C --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">½Ğ­×¥¿¥H¤U¿ù»~:</font>
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
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
<<<<<<< HEAD
					<td>ï¿½ï¿½æ†¿ï¿½æ†¿ï¿½ï¿½ï¿½:</td>
					<td><input type="TEXT" name="typeName" size="45" /></td>
						<input type="hidden" name="action" value="insert">
						<input type="submit" value="ï¿½ï¿½ï¿½ç®¸ï¿½å•£ï¿½"></FORM>
=======
=======
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
					<td>å•é¡Œé¡å‹:</td>
					<td><input type="TEXT" name="typeName" size="45" /></td>
						<input type="hidden" name="action" value="insert">
						<input type="submit" value="é€å‡ºæ–°å¢"></FORM>
<<<<<<< HEAD
=======
=======
					<td>°İÃDÃş«¬:</td>
					<td><input type="TEXT" name="typeName" size="45" /></td>
						<input type="hidden" name="action" value="insert">
						<input type="submit" value="°e¥X·s¼W"></FORM>
>>>>>>> c6342c80dffd60525c4d526ea3d78d378c0644a2
>>>>>>> 84898b661e8ecb2d4b9102291d2ebf7fbf801ed0
				</tr>
				</FORM>
		</main>
	</div>
</body>
</html>