<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%
  MemberVO memberVO = (MemberVO) session.getAttribute("MemberVO"); //LoginServlet.java (Concroller) 存入session的memberVO物件 (包括幫忙取出的memberVO, 也包括輸入資料錯誤時的memberVO物件)
  pageContext.setAttribute("memberVO",memberVO);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>承租專區</title>
		<style>
		* {
			box-sizing: border-box;
			text-decoration: none;
			list-style: none;
		}
		
		body {
			margin: 0;
			padding: 10px;
		}
		
		img {
			max-width: 100%;
		}
		
		header.header {
			background-color: #ddd;
			width: 100%;
			margin: 0 auto 10px auto;
			border: 1px solid #999;
		}
		
		@media all and (min-width:576px) and (max-width:767.98px) {
			header.header {
				width: 540px;
			}
		}
		
		@media ( max-width :575.98px) {
			header.header {
				width: 100%;
			}
		}
		
		div.main_content {
			width: 100%;
			margin: 0 auto;
			font-size: 0;
			/*   border:1px solid red; */
		}
		
		@media all and (min-width:576px) and (max-width:767.98px) {
			div.main_content {
				width: 540px;
			}
		}
		
		@media ( max-width :575.98px) {
			div.main_content {
				width: 100%;
			}
		}
		/*-------------------aside區域------------------- */
		aside.aside {
			background-color: #ddd;
			width: 200px;
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			margin-right: 10px;
			border: 1px solid #999;
		}
		
		/*--------------------main區域-------------------- */
		main.main {
			background-color: #ddd;
			width: calc(100% - 200px - 10px);
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			border: 1px solid #999;
			padding: 10px;
		}
		
		@media ( max-width : 575.98px) {
			aside.aside, main.main {
				display: block;
			}
			aside.aside {
				width: 100%;
				margin: 0 0 10px 0;
			}
			main.main {
				width: 100%;
			}
		}
		
		footer.footer {
			background-color: #ddd;
			width: 100%;
			margin: 10px auto 0 auto;
			border: 1px solid #999;
		}
		
		@media all and (min-width:576px) and (max-width:767.98px) {
			footer.footer {
				width: 540px;
			}
		}
		
		@media ( max-width :575.98px) {
			footer.footer {
				width: 100%;
			}
		}
		
		/*--------------------table區域-------------------- */
		table {
			width: 100%;
			background-color: white;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		
		table, th, td {
			border: 1px solid #CCCCFF;
		}
		
		
		</style>
	</head>
	<body bgcolor='white'>
		<header class="header"> header區域 </header>
		<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
			</c:if>
		<div class="main_content">
				<aside class="aside">
						<nav class="nav">
								<div>
									<a class="" href="<%=request.getContextPath()%>/front_end/member/LeasePage.jsp">
										<div>
												 <td>
														<c:set var="img" value="${memberVO.pic}" />
														<%
														byte b[] = (byte[]) pageContext.getAttribute("img");
															String pic = Base64.encode(b);
															if (null == pic || "".equals(pic))
																pic ="123";
														%>
														<img class="idc" src="data:image/jpg;base64,<%=pic%>"width="120">
													</td>
												    <td>${memberVO.loginId}</td>
											<%-- <img class="" src="<%=request.getContextPath()%>/front_end/member/img/LogingPIC.jpg"> --%>
										</div>
									</a>
								</div>
								<h1>承租專區</h1>
								<ul class="nav_list">
									<li><a href="<%=request.getContextPath()%>/front_end/member/LeasePage.jsp">我的帳戶</a>
										<ul class="nav_list">
											<li><a href="<%=request.getContextPath()%>/front_end/member/LeasePage.jsp">個人檔案</a></li>
											<li><a href="<%=request.getContextPath()%>/front_end/member/LeasePageAccount.jsp">銀行帳號</a></li>
											<li><a href="<%=request.getContextPath()%>/front_end/member/LeasePageAddress.jsp">地址</a></li>
											<li><a href="<%=request.getContextPath()%>/front_end/member/LeasePagePW.jsp">更改密碼</a></li>
										</ul>
									</li>
									<li><a href="<%=request.getContextPath()%>/front_end/order/listAllOrderMaster.jsp">訂單資訊</a></li>
									<li><a href="">通知</a></li>
										<ul class="nav_list">
											<li><a href="">訂單更新通知</a></li>
											<li><a href="">評價通知</a></li>
											<li><a href="<%=request.getContextPath()%>/front_end/member/LeaseAccountNotice.jsp">款項通知</a></li>
										</ul>
									<li><a href="<%=request.getContextPath()%>/back_end/memberservice/problemTypeReport.jsp">問題回報查詢</a></li>
									<li><a href="<%=request.getContextPath()%>/front_end/getCoupon/getmemid.do?member_id=${id}&action=getMemberid">我的折價券</a></li>
								</ul>
						</nav>
				</aside>
				<main class="main">
				
					<%-- <FORM METHOD="post"  ACTION="<%=request.getContextPath()%>/member/MemFrontServlet"   name="form1">--%>
					<FORM METHOD="post"  enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/member/MemFrontServlet" name="form1">
						<h1>我的帳戶</h1>
						<div>管理你的檔案以保護你的帳戶</div>
						<table>
								<tr>
								<td>會員編號 : <font color=red><b>*</b></font></td>
									<td>${memberVO.memberId}</td>	
								</tr>
								<tr>
									<td>姓名 : </td>
									<td>${memberVO.name}</td>
								</tr>
								<tr>
									<td>匿名 : </td>
									<td><input type="TEXT" name="nickName" size="45" value="${memberVO.nickName}" /></td>
								</tr>
								<tr>
									<td>EMAIL : </td>
									<td><input type="email" name="email" size="45"	value="${memberVO.email}" /></td>
								</tr>
								<tr>
									<td>手機號碼 : </td>
									<td><input type="TEXT" name="phoneNum" size="45"	value="${memberVO.phoneNum}" /></td>
								</tr>
								<tr>
									<td>生日 : </td>
									<td>${memberVO.birthday}</td>
								</tr>
						</table>
						
					<input type="hidden" name="action" value="updateBasic">
					<input type="hidden" name="memberId" value="${memberVO.memberId}">
					<input type="file" class="file" accept="image/gif, image/jpeg, image/png" onchange="showPic(this.value);" value="pic"id='file_id1' name='file_name1'>
					<!--  <img src="http://www2.blogger.com/" />-->
					
					<input type="submit" value="儲存"></FORM>					
					<FORM>
					<div >
						<h4>圖片預覽</h4>
							
							<div id="preview1"  style="width:300px;height:300px;border:3px #cccccc dashed;">
									<span class="text">預覽圖</span>
							</div>
					</div>
				 </FORM>
				 </main>
		</div>
						
		<footer class="footer"> footer區域 </footer>
	</body>
	<!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>

$("#file_id1").change(
		function() {
			$("#preview1").html(""); // 清除預覽
			var fileCount = this.files.length;
			$("#fileCount").val(fileCount);
			if (this.files.length > 1) {
				alert("最多只能選一張圖片喔");
				$("#file_id1").val("");
				$("#preview1").html("<span class='text'>預覽圖</span>");
			} else {

				if (this.files && this.files.length >= 0) {
					for (var i = 0; i < this.files.length; i++) {
						var reader = new FileReader();
						reader.onload = function(e) {
							var img = $("<img class = 'preview_img' width='280' >")
									.attr('src', e.target.result);
							$("#preview1").append(img);
						}
						reader.readAsDataURL(this.files[i]);
					}
				}
			}

		});
</script>
</html>