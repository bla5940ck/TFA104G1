<%@ page contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.manager.model.*"%>

<%
  ManagerVO managerVO = (ManagerVO) request.getAttribute("managerVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�޲z����ƭק� - update_manager_input.jsp</title>
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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>
<table id="table-1">
	<tr><td>
		 <h3>���u��ƭק� - update_manager_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/Manager/select_page.jsp"><img src="<%=request.getContextPath()%>/Manager/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ManagerServlet" name="form1">
<table>
	<tr>
		<td>�޲z���s��:<font color=red><b>*</b></font></td>
		<td><%=managerVO.getManagerID()%></td>
	</tr>
	<tr>
		<td>�޲z���b��:</td>
		<td><input type="TEXT" name="managerUser" size="45" value="<%=managerVO.getManagerUser()%>" /></td>
	</tr>
	<tr>
		<td>�޲z���m�W:</td>
		<td><input type="TEXT" name="managerName" size="45"	value="<%=managerVO.getManagerName()%>" /></td>
	</tr>
	<tr>
		<td>�޲z���K�X:</td>
		<td><input type="TEXT" name="managerPassword" size="45"	value="<%=managerVO.getManagerPassword()%>" /></td>
	</tr>
	<tr>
				<td>�޲z�����A:</td>
				<td>
					<select name="status" size="1" id="s">
								<option value="1" <%=managerVO.getStatus()==1?"selected":""  %> >�ϥΤ�</option>
								<option value="0" <%=managerVO.getStatus()==0?"selected":""  %> >���Τ�</option>
					</select>
				</td>
			</tr>
	


	

</table>
<br>
<input type="hidden" name="action" value="update">
<input type ="hidden" name="managerID" value=<%=managerVO.getManagerID() %>>
			<input type ="hidden" name="status" value=<%=managerVO.getStatus() %>>

<input type="submit" value="�e�X�ק�">
</FORM>
</body>
</html>