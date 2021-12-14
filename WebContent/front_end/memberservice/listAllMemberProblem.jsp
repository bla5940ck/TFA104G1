<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memberservice.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	MemberServiceVO memberserviceVO = (MemberServiceVO) request.getAttribute("memberserviceVO");
	Integer memID = (Integer)session.getAttribute("id");

	MemberServiceService msSvc = new MemberServiceService();
	List<MemberServiceVO> list = msSvc.getAll();
	pageContext.setAttribute("list", list);
	for(MemberServiceVO mcVO : list){
		System.out.println("圖1"  + mcVO.getPic1());
	}	
	MemberServiceVO msVO = (MemberServiceVO) request.getAttribute("msVO");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>個人問題列表</title>
<style>
body { 
 	margin: 0; 
 	padding: 10px; 
 } 

img {
	max-width: 100%;
}

button{
	font-size:13px;
	outline-width: 100%;
	background-color:white;
}

 div.main_content { 
 	width: 100%; 
 	margin: 0 auto; 
 	font-size: 0; 
 } 

/*-------------------aside區域------------------- */
aside.aside {
	width: 150px;
	height:620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align:center;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
	width: calc(100% - 150px - 10px);
	height:920px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	width: 90%;
	margin-top: auto;
	margin-bottom: auto;	
	font-size: 12px;
	margin-left:auto;
	margin-right:auto;
	font-size:15px;
	text-align:center;
	
}

table, th, td {
	border: 1px solid lightgrey;
}

th, td {
width:40px;
height:
	padding: 5px;
	
}

canvas{
object-fit: contain;
	width: 185px;
	height: 140px;
}

.problem1{
	width:90%;
	height:90%;
}
</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/problemAside.file"%>
		<main class="main">
			

			<h2>個人問題列表</h2>

			<%-- 錯誤表列 --%>
			
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/MemberServiceServlet"
				name="form1" enctype="multipart/form-data">
			
				<table id="table-1">
				<tr>
					<th>會員編號</th>
					<th>問題編號</th>
					<th>商品編號</th>					
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
						<c:if test ="${msVO.memberID == id}">
						<td>${msVO.memberID}</td>
						
						<td>${msVO.msgID}</td>
						
						<td>${msVO.prodID}</td>						
						
						<td>${msVO.managerID}</td>
						
						<td>${ptSVC.getOneProblemType(msVO.typeID).typeName}</td>
						
						<td>${msVO.ordID}</td>
						
						<td><fmt:formatDate value="${msVO.msgDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						
						<td>${msVO.problemMsg}</td>
						
						<td class="pic"><img alt="" src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=1&msgID=${msVO.msgID}"></td>
						
						<td class="pic"><img alt="" src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=2&msgID=${msVO.msgID}"></td>
						
						<td class="pic"><img alt="" src="<%=request.getContextPath()%>/MemberServiceServlet?action=detail&pic=3&msgID=${msVO.msgID}"></td>
						
						<c:if test="${msVO.problemStatus==0}">
						<td style="color:red;">未處理</td>
						</c:if>
						<c:if test="${msVO.problemStatus==1}">
						<td >已處理</td>
						</c:if>
						
						
					</tr>
					</c:if>
				</c:forEach>
		</table>
			</FORM>
			<%@ include file="page2.file"%>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file"%>

</body>

					
					
</script>
</html>