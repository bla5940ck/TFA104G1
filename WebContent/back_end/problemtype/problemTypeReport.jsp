<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memberservice.model.*"%>

<%
	MemberServiceVO memberserviceVO = (MemberServiceVO) request.getAttribute("memberserviceVO");
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

button {
	font-size: 13px;
	outline-width: 100%;
	background-color: white;
}

div.main_content {
	width: 100%;
	margin: 0 auto;
	font-size: 0;
	/*   border:1px solid red; */
}
/*-------------------aside區域------------------- */
aside.aside {
	height: 620px;
	width: 200px;
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
	height: 100%;
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
}

table, th, td {
	border: 1px solid lightgrey;
}

th, td {
	padding: 5px;
	text-align: center;
}

/************上傳*************/
canvas{
		width:45%;
		height:35%;
		border:1px solid;
	}
canvas1{
		width:50%;
		height:40%;
		border:1px solid;
	}
canvas2{
		width:50%;
		height:40%;
		border:1px solid;
	}
canvas3{
		width:50%;
		height:40%;
		border:1px solid;
	}

</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header2.file"%>
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
			<table id="table-1">
				<tr>
					<td>
						<h3>問題狀態新增-addProblemType.jsp</h3>
					</td>
					<td>
						<h4>
							<a href="select_page.jsp"><img src="images/tomcat.png"
								width="100" height="100" border="0">回首頁</a>
						</h4>
					</td>
				</tr>
			</table>

			<h3>資料新增:</h3>

			<%-- 錯誤表列 --%>
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
				name="form1">
				<table>
					<tr>
						<td>問題類型:</td>
						<td><select id="sel">
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
						<td><select id="sel2"></select></td>
					</tr>
					<br>
					<tr>
						<td>問題描述:</td>
						<td><textarea style="width: 90%; height: 90%">
						
					</textarea></td>
					</tr>
					<br>
					<tr>
						<td>上傳圖片一</td>
						<td>
							<div>
								<canvas id="canv1"></canvas>
								<div>
									<input type="file" multiple="false" accept="image/*"
									 onchange=upload1() id = "finput1" name = "pic1">
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>上傳圖片二</td>
						<td>
							<div>
								<canvas id="canv2"></canvas>
								<div>
									<input type="file" multiple="false" accept="image/*"
									 onchange=upload2() id = "finput2" name = "pic2">
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>上傳圖片三</td>
						<td>
							<div>
								<canvas id="canv3"></canvas>
								<div>
									<input type="file" multiple="false" accept="image/*"
									 onchange=upload3() id = "finput3" name = "pic3">
								</div>
							</div>
						</td>
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
												$("<option value='" + array[i] + "'>"
												+ array[i] + "</option>"));
									});
									break;
								case 2:
									$("#sel2 option").remove();
										var array = [ "違規", "無違規" ];
											//利用each遍歷array中的值並將每個值新增到Select中
									$.each(array, function(i, val) {
										$("#sel2").append(
											$("<option value='" + array[i] + "'>"
												+ array[i] + "</option>"));
									});
									break;
								case 3:
									$("#sel2 option").remove();
										var array = [ "盜用圖片", "未依分類", "金額誇張" ];											
									$.each(array, function(i, val) {
										$("#sel2").append(
												$("<option value='" + array[i] + "'>"
													+ array[i] + "</option>"));
									});
									break;
								case 4:
									$("#sel2 option").remove();
										var array = [ "歐洲", "亞洲", "非洲", "大洋洲", "南美洲",
													"北美洲", "南極洲" ];											
									$.each(array, function(i, val) {
										$("#sel2").append(
												$("<option value='" + array[i] + "'>"
														+ array[i] + "</option>"));
									});
									break;
								}
							});
</script>
</html>