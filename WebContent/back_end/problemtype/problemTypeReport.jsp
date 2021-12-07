<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memberservice.model.*"%>

<%
	MemberServiceVO memberserviceVO = (MemberServiceVO) request.getAttribute("memberserviceVO");
	Integer memID = (Integer)session.getAttribute("id");
	out.print(memID);
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
	width: 100%;
	margin-top: 5px;
	margin-bottom: 5px;	
	font-size: 12px;
}

table, th, td {
	border: 1px solid lightgrey;
}

th, td {
	padding: 5px;
	text-align: left;
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
				name="form1">
				<input type="hidden" name="action" value="problemTypeReport" />
				<table id="table-1">
					<tr>
					<td>反應會員編號</td>
					<td>
					<jsp:useBean id="memSVC" scope="page" class="com.member.model.MemberService" />
						<input type="hidden" name="memberID" value="memID">${memSVC.getOneMember(memID).name}
						
					</td>
					</tr>
					<tr>
						<td>問題類型:</td>
						<td><select id="sel" name="problemtype1">
								<option value="0">請選擇</option>
								<option value="1">訂單</option>
								<option value="2">會員</option>
								<option value="3">商品</option>
								<option value="4">其他</option>
						</select></td>
					</tr>
					<br>
					<tr>
						<td>選擇問題:</td>
						<td><select id="sel2" name="problemtype2"></select></td>
					</tr>
					<br>
					<tr>
						<td>問題描述:</td>
							<td><textarea class="problem1" name="action" value=""></textarea>
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
					</table>
				<br>
				<input type="hidden" name="action" value="insert">
				<input type="submit" value="送出新增">
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
					
					$("#sel").change(function() {
							switch (parseInt($(this).val())) {				
								case 0:
									$("#sel2 option").remove();
									break;
								case 1:
									$("#sel2 option").remove();
									
									var array = [ "未收到商品", "商品毀損", "商品不符合", "收到商品異常",
										"歸還商品異常", "未歸還商品", "取消訂單", "完成訂單" ];											
									$.each(array, function(i, val) {
										$("#sel2").append(
												$("<option value='" + i + "'>"
												+ array[i] + "</option>"));
									});
									break;
								case 2:
									$("#sel2 option").remove();
										var array = [ "違規", "無違規" ];
											//利用each遍歷array中的值並將每個值新增到Select中
									$.each(array, function(i, val) {
										$("#sel2").append(
											$("<option value='" + i + "'>"
												+ array[i] + "</option>"));
									});
									break;
								case 3:
									$("#sel2 option").remove();
										var array = [ "盜用圖片", "未依分類", "金額誇張" ];											
									$.each(array, function(i, val) {
										$("#sel2").append(
												$("<option value='" + i + "'>"
													+ array[i] + "</option>"));
									});
									break;
								case 4:
									$("#sel2 option").remove();
										var array = [ "歐洲", "亞洲", "非洲", "大洋洲", "南美洲",
													"北美洲", "南極洲" ];											
									$.each(array, function(i, val) {
										$("#sel2").append(
												$("<option value='" + i + "'>"
														+ array[i] + "</option>"));
									});
									break;
								}
							});
</script>
</html>