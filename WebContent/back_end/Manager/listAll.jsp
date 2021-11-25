<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.manager.model.*"%>

<%
	ManagerService msSvc = new ManagerService();
	List<ManagerVO> list = msSvc.getAll();
	// 	out.print(list);
	pageContext.setAttribute("list", list);
	
	ManagerVO managerVO = (ManagerVO) request.getAttribute("managerVO"); 
	for(ManagerVO maVO : list){
		out.println(maVO.getStatus());
	};
	
%>

<html>
<head>
<title>�Ҧ��޲z�̸��-listAllManager.jsp</title>
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
	color: red;
	display: inline;
}

a {
	color: red;
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

	<h4>�����m�߱ĥ� EL ���g�k����:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>�Ҧ��޲z�̸��listAllManager.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/Manager/select_page.jsp"><img
						src="<%=request.getContextPath()%>/Manager/images/back1.gif"
						width="100" height="32" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<%--���~�C�� --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>�޲z�̽s��</th>
			<th>�޲z�̱b��</th>
			<th>�޲z�̩m�W</th>
			<th>�޲z�̱K�X</th>
			<th>�޲z�̪��A</th>

			<th>�ק�</th>
			<th>�R��</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="managerVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr>

				<td>${managerVO.managerID}</td>
				<td>${managerVO.managerUser}</td>
				<td>${managerVO.managerName}</td>
				<td>${managerVO.managerPassword}</td>
				<td>${(managerVO.status==0)?'���Τ�':'�ϥΤ�'}</td>
				
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/ManagerServlet"
						style="margin-bottom: 0px;">
						<input type="submit" value="�ק�"> <input type="hidden"
							name="managerID" value="${managerVO.managerID}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/ManagerServlet"
						style="margin-bottom: 0px;">
						<input type="submit" value="�R��"> <input type="hidden"
							name="managerID" value="${managerVO.managerID}"> <input
							type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">



</script>
</html>