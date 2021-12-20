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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account.JSP</title>
</head>
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


table {
	
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
    color: blue;
    display: inline;
  }
  .signOut{
background-color:#6495ed;
}
</style>

<style>
/*-------------------aside區域------------------- */
aside.aside {
	width: 200px;
	height: 720px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
	width: calc(100% - 200px - 10px);
	height: 720px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}


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
<body>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
	<%@ include file="/includeFolder/managerAside.file"%>
	<main class="main">
	<table id="table-1">
	<tr><td>
		 <h3>待轉帳資料- AccountList.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back_end/manager/afterLogin.jsp"><img src="<%=request.getContextPath()%>/front_end/member/img/index.jpg" width="100" height="32" border="0"></a></h4>
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
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet" >
        <b>輸入預計付款年月 :</b>
        <input type="text" name="memberId">
        <input type="hidden" name="action" value="getOneMemberMemberId">
        <input type="submit" value="送出">
 	</FORM>
    
  </li>

<table>
	<tr>
		<!--  <th>選擇</th>-->
		<th>會員編號</th>
		<th>收款人戶名</th>
		<th>付款金額</th>
		<th>收款銀行代號</th>
		<th>收款帳號</th>
		<th>預計轉帳日期</th>
		<th>轉帳狀態</th>
		

	</tr>
	<%@ include file="page1.file" %> 
	  <c:forEach var="memberVO"  items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
		<tr>
			<!--<td><input type="checkbox" value="修改"></td>  -->
			<td>${memberVO.memberId}</td>
			<td>${memberVO.name}</td>
			<td>${memberVO.email}</td>
			<!-- <td>${memberVO.creatDate}</td>-->
			<td><fmt:formatDate value="${memberVO.creatDate}" pattern="yyyy-MM-dd "/></td>
			<td>${memberVO.loginId}</td>
			<td>${memberVO.phoneNum}</td> 
			<!--<td>${memberVO.status}</td>-->
		    <td>${(memberVO.status==1)?'使用中':'未啟用/停用'}</td>
			
<%--
			<td>
			     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="停權" >
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			      <input type="hidden" name="action"  value="9"></FORM>
			</td>
		 --%>
		</tr>
</c:forEach> 
</table>
<%@ include file="page2.file" %>

			</main>
	</div>	
</body>
</html>