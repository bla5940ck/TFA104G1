<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.memberservice.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	MemberServiceService msSvc = new MemberServiceService();
	List<MemberServiceVO> list = msSvc.getAll();
	pageContext.setAttribute("list", list);
	for(MemberServiceVO mcVO : list){
		System.out.println("圖1"  + mcVO.getPic1());
	}
	
	
	MemberServiceVO msVO = (MemberServiceVO) request.getAttribute("msVO");
	
%>

<html>
<head>
<title>所有問題列表</title>
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


</style>

<style>
table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	font-size:10px;
	border: 1px solid #CCCCFF;
}

th, td {
height:100px
	padding: 5px;
	text-align: center;
}

.pic{
object-fit: contain;
	width: 95px;
	height: 80px;
}
</style>

</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" style="background-color:#C0C0C0;">
			<h4>此頁練習採用 EL 的寫法取值:</h4>
			<table id="table-1">
				<tr>
					<td>
						
						<h4>
							<a
								href="<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp">回首頁</a>
						</h4>
					</td>
				</tr>
			
			</table>

			<%--錯誤列表 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
	<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/MemberServiceServlet"
				name="form1" enctype="multipart/form-data">
			<table>
				<tr>
					<th>問題編號</th>
					<th>商品編號</th>					
					<th>會員編號</th>
					<th>管理者編號</th>
					<th>問題類型編號</th>
					<th>訂單編號</th>
					<th>訊息時間</th>					
					<th>問題描述</th>
					<th>圖片一</th>
					<th>圖片二</th>
					<th>圖片三</th>
					<th>問題狀態</th>					
									
				</tr>
				<jsp:useBean id="ptSVC" scope="page" class="com.problemtype.model.ProblemTypeService" />
				<%@ include file="page1.file"%>
				
				<c:forEach var="msVO" items="${list}" begin="<%=pageIndex%>"
					end="<%=pageIndex+rowsPerPage-1%>">
					<br>
					<tr>					
						<td>${msVO.msgID}</td>
						<input type="hidden" name="msgID" value="${msVO.msgID}" >
						<td>${msVO.prodID}</td>
						<input type="hidden" name="prodID" value="${msVO.prodID}" >
						<td>${msVO.memberID}</td>
						<input type="hidden" name="memberID" value="${msVO.memberID}" >
						<td>${msVO.managerID}</td>
						<input type="hidden" name="managerID" value="${msVO.managerID}" >
						<td>${ptSVC.getOneProblemType(msVO.typeID).typeName}</td>
						<input type="hidden" name="typeID" value="${msVO.typeID}" >
						<td>${msVO.ordID}</td>
						<input type="hidden" name="ordID" value="${msVO.ordID}" >
						<td><fmt:formatDate value="${msVO.msgDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<input type="hidden" name="msgDate" value="${msVO.msgDate}" >
						<td>${msVO.problemMsg}</td>
						<input type="hidden" name="problemMsg" value="${msVO.problemMsg}" >
						<td class="pic"><img alt="" src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=1&msgID=${msVO.msgID}"></td>
						<input type="hidden" name="pic1" value="${msVO.pic1}" >
						<td class="pic"><img alt="" src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=2&msgID=${msVO.msgID}"></td>
						<input type="hidden" name="pic2" value="${msVO.pic2}" >
						<td class="pic"><img alt="" src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=3&msgID=${msVO.msgID}"></td>
						<input type="hidden" name="pic3" value="${msVO.pic3}" >
						<td><select name="problemStatus" size="1" id="s">
								<option value="0" >未處理</option>
								<option value="1" >已處理</option>
						</select></td>
						
						
					</tr>
				</c:forEach>
		</table>
		<input type="hidden" name="action" value="update" >
				<center><input type="submit" value="送出"></center>	
			</FORM>
			<%@ include file="page2.file"%>
		</main>
	</div>
	
</body>

</html>