<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>ProblemType</title>
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



/*-------------------aside�ϰ�------------------- */
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

/*--------------------main�ϰ�-------------------- */
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
table#table-1 {
	width: 80%;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

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
		<aside class="aside">
			<aside class="aside">
			<nav class="nav">
				<ul class="nav_list" style="background-color:#F0B594;height:100%">
					<h2>
						<a href='<%=request.getContextPath()%>/back_end/manager/select_page.jsp'>�޲z�̱M��</a> <br> 
						<a href='<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp'>���D�B�z</a> <br> 
						<a>�ӫ~�޲z</a> <br>
						<a>�q��޲z</a> <br> 
						<a>�|���޲z</a> <br> 
						<a>�b�Ⱥ޲z</a> <br>
						<a>�|���f��</a> <br> 
						<a>�M�ױM��</a>
					</h2>
					<form action="/TFA104G1/ManagerServlet" method="post" >
				<button class="signOut" type="submit">sign out</button>
				<input type="hidden" name="action" value="sign_out" />
				</form>
				</ul>
			</nav>
		</aside>
		<main class="main" style="background-color:#C0C0C0;">
		<ul>
			<li><a href='listAllProblemType.jsp'>�Ҧ����D����</a></li>
		</ul>
		<ul>
			<li><a href='addProblemType.jsp'>�s�W���D����</a></li>
		</ul>		
		<ul>
			<li><a href='listAllproblemmsg.jsp'>��D���D�B�z</a></li>
		</ul>		
	</main>
	</div>

</body>
</html>