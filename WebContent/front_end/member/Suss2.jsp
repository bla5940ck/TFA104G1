<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Export to Excel - Demo</title>
</head>
<body>
 <%
 String exportToExcel = request.getParameter("exportToExcel");
 if (exportToExcel != null
 && exportToExcel.toString().equalsIgnoreCase("YES")) {
 response.setContentType("application/vnd.ms-excel");
 response.setHeader("Content-Disposition", "inline; filename="
 + "excel.xls");
 
 }
 %>
 
 <table id="table-1">
	<tr><td>
		 <h3>所有會員資料- listAllMember.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back_end/manager/afterLogin.jsp"><img src="<%=request.getContextPath()%>/front_end/member/img/index.jpg" width="100" height="32" border="0"></a></h4>
	</td></tr>
</table>
 
 <table align="left" border="2">
 <thead>
 <tr bgcolor="lightgreen">
 <th>Sr. No.</th>
 <th>Text Data</th>
 <th>Number Data</th>
 </tr>
 </thead>
 <tbody>
 <%
 for (int i = 0; i < 10; i++) {
 %>
 <tr bgcolor="lightblue">
 <td align="center"><%=i + 1%></td>
 <td align="center">中文編碼測試This is text data <%=i%></td>
 <td align="center"><%=i * i%></td>
 </tr>
 <%
 }
 %>
 </tbody>
 </table>
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> 
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <%
 if (exportToExcel == null) {
 %>
 <a href="Suss.jsp?exportToExcel=YES">Export to Excel</a>
 <%
 }
 %>
</body>
</html>