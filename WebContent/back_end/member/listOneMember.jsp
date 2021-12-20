<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%-- ���X Concroller EmpServlet.java�w�s�Jrequest��MemberVO����--%>
<%MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");%>

<%-- ���X ������DeptVO����--%>


 
<html>
<head>
<title>�浧�|����� - listOneMember.jsp</title>

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
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;	
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
	background-color:#F5D998;;
	height:720px;
}



/*--------------------main�ϰ�-------------------- */
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

.signOut{
background-color:	#FF7575;
}
.class1{
background-color:#FFF0AC;
}

input{
background-color:#FFF0AC;
}
</style>
</head>
<body bgcolor='white'>
<%@ include file="/includeFolder/managerHeader.file"%>
<!-- <h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4> -->
<div class="main_content">
<%@ include file="/includeFolder/managerAside.file"%>
<main class="main" >
<table id="table-1">
	<tr><td>
		 <h3>�浧�|�����- listOneMember.jsp</h3>
		<h4><a href="<%=request.getContextPath()%>/back_end/member/listAllMember.jsp"><img src="<%=request.getContextPath()%>/front_end/member/img/back.png" width="200" height="90" border="0"></a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>�|���s��</th>
		<th>�|���m�W</th>
		<th>�q�l�H�c</th>
		<th>���U���</th>
		<th>�|���b��</th>
		<th>������X</th>
		<th>�|�����A</th>
		<th>�ק�</th>
		<th>���v</th>
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
		    <td>${(memberVO.status==1)?'�ϥΤ�':'���ҥ�/����'}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			     <input type="hidden" name="action"	value="updateMember"></FORM>
			</td>
			<td>
			     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="���v">
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			      <input type="hidden" name="actionOne"  value="9"></FORM>
			</td>
	</tr>
</table>
</main>
	</div>

</body>
</html>