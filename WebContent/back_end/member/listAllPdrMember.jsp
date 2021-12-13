<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>

<%
    MemberService memSvc = new MemberService();
    List<MemberVO> list = memSvc.getPdrMember();
    //EL語法需要加上pageContext
    pageContext.setAttribute("list",list);
    if (list.size()<1){
    String redirectURL =request.getContextPath()+ "/back_end/member/listAllMember.jsp";
    response.sendRedirect(redirectURL);
    }
%>

<!--  <!DOCTYPE html> -->
<html>
<head>
<meta charset="UTF-8">
<title>所有待審核會員資料 listAllPdrMember.jsp</title>

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
		 <h3>待審核會員資料 listAllPdrMember.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back_end/member/listAllPdrMember.jsp"><img src="<%=request.getContextPath()%>/front_end/member/img/LogingPIC.jpg" width="200" height="90" border="0">回首頁</a></h4>
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

<table>
	<tr>
		<th>會員編號</th>
		<th>會員姓名</th>
		<th>電子信箱</th>
		<th>註冊日期</th>
		<th>會員帳號</th>
		<th>身分證正面</th>
		<th>身分證反面</th>
		<th>會員狀態</th>
		<th>查看</th>
	</tr>
	
	 <c:forEach var="memberVO" items="${list}" >
         

		<tr>
			<td>${memberVO.memberId}</td>
			<td>${memberVO.name}</td>
			<td>${memberVO.email}</td>
			<td><fmt:formatDate value="${memberVO.creatDate}" pattern="yyyy-MM-dd "/></td>
			<!-- <td>${memberVO.creatDate}</td>-->
			<td>${memberVO.loginId}</td>
			
			<!--  <td>${memberVO.idcF}</td>-->
			
			<!-- 身分證正面 -->
			<td>
					<c:set var="img" value="${memberVO.idcF}" />
					<%
					byte b[] = (byte[]) pageContext.getAttribute("img");
						String idcF = Base64.encode(b);
						if (null == idcF ||"".equals(idcF))
							idcF ="123";
					%>
					<img class="idc" src="data:image/jpg;base64,<%=idcF%>"width="120">
			</td>
			<!-- 身分證反面 -->
			<td>
					<c:set var="img" value="${memberVO.idcB}" />
					<%
					byte b2[] = (byte[]) pageContext.getAttribute("img");
						String idcB = Base64.encode(b2);
						if (null == idcB ||"".equals(idcB))
							idcB ="123";
					%>
					
					<img class="idc" src="data:image/jpg;base64,<%=idcB%>"width="120">
					
					
			</td>
			
			<td>${(memberVO.status == 0)?'待審核':'使用中'}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemPdrServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="審查">
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			     <input type="hidden" name=idcF  value="${memberVO.idcF}">
			     <input type="hidden" name=idcB  value="${memberVO.idcB}">
			     <input type="hidden" name="action"	value="updateStatus"></FORM>
			</td>	
		</tr>
</c:forEach> 
</table>


</body>
</html>