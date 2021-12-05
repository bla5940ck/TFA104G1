<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>

<%
    MemberService memSvc = new MemberService();
    List<MemberVO> list = memSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<!--  <!DOCTYPE html> -->
<html>
<head>
<meta charset="UTF-8">
<title>後台會員資料 - listAllMember.jsp</title>

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


<table id="table-1">
	<tr><td>
		 <h3>所有會員資料- listAllMember.jsp</h3>
		 <h4><a href=""><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet"" >
        <b>輸入會員編號 :</b>
        <input type="text" name="memberId">
        <input type="hidden" name="action" value="getOneMember">
        <input type="submit" value="送出">
    </FORM>
  </li>

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
	<%@ include file="page1.file" %> 
	  <c:forEach var="memberVO"  items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
		<tr>
			<td>${memberVO.memberId}</td>
			<td>${memberVO.name}</td>
			<td>${memberVO.email}</td>
			<!-- <td>${memberVO.creatDate}</td>-->
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
			      <input type="hidden" name="action"  value="9"></FORM>
			</td>
		
		</tr>
</c:forEach> 
</table>
<%@ include file="page2.file" %>

</body>
</html>