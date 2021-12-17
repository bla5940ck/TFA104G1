<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memberservice.model.*"%>

<%
	MemberServiceVO memberserviceVO = (MemberServiceVO) request.getAttribute("memberserviceVO");
	Integer memID = (Integer)session.getAttribute("id");
	out.print(memID);
	String ordID = request.getParameter("ordID");
	if(ordID == null){
		ordID = "";
	}
	String prodID = request.getParameter("prodID");
	if(prodID == null){
		prodID = "";
	}
	
// 	if(request.getParameter("ordID")!=null){
// 	Integer ordID = Integer.valueOf(request.getParameter("ordID"));
// 		System.out.println("訂單編號" + ordID);
// 	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>問題狀態新增-addProblemType.jsp</title>
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
	width: 80%;
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
		<aside class="aside">
			<nav class="nav">
				<ul class="nav_list">
					<h2>出租者專區</h2>
					<h4>
						<a
							href="<%=request.getContextPath()%>/front_end/order/listAllOrderList.jsp">全部訂單</a>
					</h4>
				</ul>
			</nav>
		</aside>
		<main class="main">
			

			<h2>問題回報</h2>

			<%-- 錯誤表列 --%>
			
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/MemberServiceServlet"
				name="form1" enctype="multipart/form-data">
			
				<table id="table-1">
					<tr>
						<td>反應會員帳號</td>
						<td>
						<jsp:useBean id="memSVC" scope="page" class="com.member.model.MemberService" />
						<jsp:useBean id="ptSVC" scope="page" class="com.problemtype.model.ProblemTypeService" />
						<input type="hidden" name="memberID" value="<%=memID%>">${memSVC.getOneMember(id).loginId}					
						</td>
					</tr>
					<tr>
						<td>反應商品編號</td>
						<td>						
						<input type="hidden" name="prodID" size="45" value=<%=prodID %>><%=prodID %></td>
											
						</td>
					</tr>
					<br>
					<tr>
						<td>反應訂單編號</td>
						<td>						
						<input type="hidden" name="ordID" size="45" value=<%=ordID %>><%=ordID %></td>
										
						</td>
					</tr>
					<br>
					<tr>
						<td>問題類型</td>
						<td>					
							<select size="1" name="typeID">
								<c:forEach var="problemtypeVO" items="${ptSVC.getAll()}">
										<option value="${problemtypeVO.typeID}">${problemtypeVO.typeName}
								</c:forEach>
							</select>							
						</td>
					</tr>
					<br>
					<tr>
						<td>問題描述</td>
							<td><textarea class="problem1" name="problemmsg" placeholder="請輸入內容...."></textarea>
						</td>
					</tr>
					<br>
					<tr>
						<td>上傳圖片一</td>
						<div>
						<td><canvas id="canv1"></canvas>								
								<input type="file" multiple="false" accept="image/*"
									 onchange=upload1() id = "finput1" name = "pic1">							
						</td>
						</div>
					</tr>
					<tr>
						<td>上傳圖片二</td>
						<div>
						<td><canvas id="canv2"></canvas>								
								<input type="file" multiple="false" accept="image/*"
									 onchange=upload2() id = "finput2" name = "pic2">							
						</td>
						</div>
					</tr>
					<tr>
						<td>上傳圖片三</td>
						<div>
						<td><canvas id="canv3"></canvas>								
								<input type="file" multiple="false" accept="image/*"
									 onchange=upload3() id = "finput3" name = "pic3">
						</td>
						</div>
					</tr>
					<br>
					</table>
				<br>
				<input type="hidden" name="action" value="insert" >
				<center><input type="submit" value="送出"></center>

			</FORM>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file"%>

</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://www.dukelearntoprogram.com/course1/common/js/image/SimpleImage.js"></script>
<script type="text/javascript">

					
					function upload1(){
						  var imgcanvas = document.getElementById("canv1");
						  var fileinput = document.getElementById("finput1");
						  var image = new SimpleImage(fileinput);
						  image.drawTo(imgcanvas);
						}
					function upload2(){
						  var imgcanvas = document.getElementById("canv2");
						  var fileinput = document.getElementById("finput2");
						  var image = new SimpleImage(fileinput);
						  image.drawTo(imgcanvas);
						}
					function upload3(){
						  var imgcanvas = document.getElementById("canv3");
						  var fileinput = document.getElementById("finput3");
						  var image = new SimpleImage(fileinput);
						  image.drawTo(imgcanvas);
						}
					
					
</script>
</html>