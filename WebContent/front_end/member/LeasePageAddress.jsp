<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>

<%
  MemberVO memberVO = (MemberVO) session.getAttribute("MemberVO"); //LoginServlet.java (Concroller) 存入session的memberVO物件 (包括幫忙取出的memberVO, 也包括輸入資料錯誤時的memberVO物件)
  pageContext.setAttribute("memberVO",memberVO);
  
  ServletContext context = getServletContext();
  context.setAttribute("memberId1", memberVO.getMemberId());
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
			padding: 0px;
		}
		
		img {
			max-width: 100%;
		}
		
		header.header {
			background-color: #ddd;
			width: 100%;
			margin: 0 auto 0px auto;
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
			
			width: 200px;
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			margin-right: 4px;
			margin-left: 4px;
			padding: 0px;
			border: 1px solid #999 ;
			border-color: transparent #191561 transparent transparent;
		}
		
		/*--------------------main區域-------------------- */
		main.main {
			background-color: white;
			width: calc(100% - 200px - 10px);
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			border: 1px solid white;
			padding: 0px;
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
			width: 50%;
			background-color: white;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		
		table, th, td {
			border: 1px solid lightgrey;
		}
		th, td {
	height: 50px;
	padding: 5px;
	text-align: center;
	font-size:15px;
}

        .li{
            font-size: 14px;
             outline: 0;
   background-color: lightgrey;
    background: 	#F0F0F0;
    text-decoration: none;
    color: #191561 ;
    font-weight: bold;
    		
        }

  
		</style>
	</head>
	<body bgcolor='white'>
			<%@ include file="/includeFolder/header.file"%>
		<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
			</c:if>
		<div class="main_content">
		
			<%@ include file="/includeFolder/rentMemberAside.file"%>
				
				<%
					DefAddressService dfaSvc = new DefAddressService();
					List<DefAddressVO> list = dfaSvc.getOneMemAll(memberVO.getMemberId());
					pageContext.setAttribute("list",list);
				%>
				<main class="main">
				
						<h1>地址</h1>
						<div style="font-size:22px;">管理你的寄送相關資訊</div>
						
					<a style="font-size:20px;" href="https://emap.presco.com.tw/c2cemap.ashx?eshopid=870&&servicetype=1&url=http://104.199.254.38:8081/TFA104G1/member/AddressFrontServlet"><input type="submit" value="新增超商地址"class="aa-browse-btn" ></a>
				<!--  
					<a style="font-size:20px;" href="<%=request.getContextPath()%>/member/AddressFrontServlet"><input type="submit" value="新增超商地址"class="aa-browse-btn" ></a>
						-->
						<hr>
						 <c:forEach var="defAddressVO"  items="${list}" >
						 <FORM METHOD="post"  ACTION="<%=request.getContextPath()%>/front_end/member/LeasePageAddAddress.jsp" name="form1">
						
						<ul class="li">
							<div style="font-size:16px; color:	#FF0080;">${(defAddressVO.status==1)?'預設':' '}</div>
							<li >姓名 : ${defAddressVO.recipient}</li>
							<li>電話 : ${defAddressVO.recptPhone}</li>
							<li>超商 : ${defAddressVO.name711}</li>
							<li>地址 : ${defAddressVO.add711}</li>
						</ul>
						<input type="hidden" name="action" value="delete">
						<input type="hidden" name="def711" value="${defAddressVO.def711}">
					<input type="submit" value="刪除"class="aa-browse-btn" ></FORM>
						<hr>
						</c:forEach> 
				

						
					
				 
				 </main>
		</div>
						
		<%@ include file="/includeFolder/footer2.file"%>
	</body>
<script>
	function showPic(picPath){
		pic = document.getElementById("imgShow");
		pic.src = "file:///" + picPath;
		pic.width = 300;
		pic.style.visibility = "visible";
		}
</script>
</html>