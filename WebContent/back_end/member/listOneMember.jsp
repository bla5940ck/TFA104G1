<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%-- 取出 Concroller EmpServlet.java已存入request的MemberVO物件--%>
<%

MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
MemberService memSVC = new MemberService();


if(request.getAttribute("memberVO") == null){
	Integer memID = Integer.valueOf(request.getParameter("memberID"));
	memberVO = memSVC.getOneMember(memID);
}
	pageContext.setAttribute("memberVO", memberVO);

%>


<%-- 取出 對應的DeptVO物件--%>


 
<html>
<head>
<title>單筆會員資料 - listOneMember.jsp</title>

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

/*-------------------aside區域------------------- */
aside.aside {
	width: 200px;	
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;	
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
	background-color:#F5D998;;
	height:720px;
}



/*--------------------main區域-------------------- */
main.main {
	background-color: 	#F0F0F0;
	width: calc(100% - 200px - 10px);
	height: 720px;
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

table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: red;
	display: inline;
}

table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	font-size: 10px;
	border: 1px solid #CCCCFF;
}

th, td {
	height: 100px padding: 5px;
	text-align: center;
}

.pic {
	object-fit: contain;
	width: 95px;
	height: 80px;
}


.class1{
background-color:#FFF0AC;
}

input{
background-color:#FFF0AC;
}

button{
background-color: #FFF0AC;
}
</style>
</head>
<body bgcolor='white'>
<%@ include file="/includeFolder/managerHeader.file"%>
<!-- <h4>此頁暫練習採用 Script 的寫法取值:</h4> -->
<div class="main_content">
<%@ include file="/includeFolder/managerAside.file"%>
<main class="main" >




<table>
	<tr>
		<th>會員編號</th>
		<th>會員姓名</th>
		<th>電子信箱</th>
		<th>註冊日期</th>
		<th>會員帳號</th>
		<th>手機號碼</th>
		<th>會員狀態</th>
		<th>修改</th>
		<th>停權</th>
	</tr>
	<tr>
			<td>${memberVO.memberId}</td>
			<td>${memberVO.name}</td>
			<td>${memberVO.email}</td>
			<!--  <td>${memberVO.creatDate}</td>-->
			<td><fmt:formatDate value="${memberVO.creatDate}" pattern="yyyy-MM-dd "/></td>
			<td>${memberVO.loginId}</td>
			<td>${memberVO.phoneNum}</td> 
			<!--<td>${memberVO.status}</td>-->
		    <td>${(memberVO.status==1)?'使用中':'未啟用/停用'}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			     <input type="hidden" name="action"	value="updateMember"></FORM>
			</td>
			<td>
			     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="停權">
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			      <input type="hidden" name="actionOne"  value="9"></FORM>
			</td>
	</tr>
</table>
<br>
<button class="back_btn">返回上一頁</button>
</main>
	</div>

</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$("button.back_btn").click(function(){
		history.go(-1);
	});

</script>
</html>