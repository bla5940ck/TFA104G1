<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.memberservice.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%
	MemberServiceService msSvc = new MemberServiceService();
	MemberServiceVO msVO = (MemberServiceVO) request.getAttribute("msVO");
	Integer id = Integer.valueOf(request.getParameter("prodID"));
	List<MemberServiceVO> list = msSvc.getByProdID(id);
	System.out.println(list.size());
	pageContext.setAttribute("list", list);
%>

<html>
<head>

<title>單一問題列表</title>
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
</style>
</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" >
			<h4>此頁練習採用 EL 的寫法取值:</h4>
			<table id="table-1">
				<tr>
					<td>
						
						<h4>
							<button><a href="<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp">回首頁</a></button>
						</h4>
					</td>
				</tr>
			
			</table>

			<%--錯誤列表 --%>
			
	
			<table>
				<tr>
					<th>商品編號</th>	
					<th>管理員編號</th>				
					<th>問題編號</th>
					<th>會員編號</th>					
					<th>問題類型編號</th>
					<th>訂單編號</th>
					<th>訊息時間</th>					
					<th>問題描述</th>
					<th>圖片一</th>
					<th>圖片二</th>
					<th>圖片三</th>
					<th>問題狀態</th>					
									
				</tr>
			<%@ include file="page1.file"%>
			<c:forEach var="msVO" items="${list}" begin="<%=pageIndex%>"
					end="<%=pageIndex+rowsPerPage-1%>">
				<tr>
					<td>${msVO.prodID}</td>
					<td>${msVO.managerID}</td>
					<td>${msVO.msgID}</td>
					<td>${msVO.memberID}</td>
					<td>${msVO.typeID}</td>
					<td>${msVO.ordID}</td>				
					<td>${msVO.msgDate}</td>
					<td>${msVO.problemMsg}</td>
					<td class="pic"><img alt="" 
								src="<%=request.getContextPath()%>/MemberServiceServlet?action=getOne_For_Display&pic=1&msgID=${msVO.msgID}"></td>
						
					<td class="pic"><img alt="" 
								src="<%=request.getContextPath()%>/MemberServiceServlet?action=getOne_For_Display&pic=2&msgID=${msVO.msgID}"></td>
						
					<td class="pic"><img alt="" 
								src="<%=request.getContextPath()%>/MemberServiceServlet?action=getOne_For_Display&pic=3&msgID=${msVO.msgID}"></td>
					<td>${msVO.problemStatus}</td>
				</tr>
				
						
					
			</c:forEach>
		</table>
			<%@ include file="page2.file"%>
			<button class="back_btn">返回上一頁</button>
			
			
		</main>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$("button.back_btn").click(function(){
		history.go(-1);
	});

</script>
</body>
</html>