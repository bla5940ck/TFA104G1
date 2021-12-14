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
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<!-- <h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4> -->
<table id="table-1">
	<tr><td>
		 <h3>�浧�|�����- listOneMember.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
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


</body>
</html>