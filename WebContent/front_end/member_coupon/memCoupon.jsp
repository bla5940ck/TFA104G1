<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member_coupon.model.*"%>

<%
	List<MemcouponVO> memcouponVO = (List<MemcouponVO>) request.getAttribute("memcouponVO");
	List<MemcouponVO> list = memcouponVO;
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<title>我的折價券</title>
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
			margin-right: 6px;
			margin-left: 4px;
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
				
		footer.footer {
			background-color: #ddd;
			width: 100%;
			margin: 10px auto 0 auto;
			border: 1px solid #999;
		}
		
			/*--------------------table區域-------------------- */
		table {
			width: 50%;
			background-color: white;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		
		table, th, td {
			border: 1px solid #CCCCFF;
		}
		th, td{
		height: 50px;
		text-align: center;
		}
		</style>

</head>
<body bgcolor='white'>

	<%@ include file="/includeFolder/header.file"%>

	<div class="main_content">
	<%@ include file="/includeFolder/rentMemberAside.file"%>

		<main class="main" >


<br>
<br>
						<center><h2>我的折價券</h2>
<br>

			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<!-- mem_coupon_id, member_id, category_id, coupon_id, coupon_name, discount, status, start_date, end_date -->
			<table>
				<tr>
<!-- 					<th>會員的折價券編號</th> -->
<!-- 					<th>會員編號</th> -->
<!-- 					<th>商品類別編號</th> -->
<!-- 					<th>折價券編號</th> -->
					<th>折價券名稱</th>
					<th>折價金額</th>
					<th>折價券狀態</th>
<!-- 					<th>開始日期</th> -->
<!-- 					<th>結束日期</th> -->
				</tr>
				<c:forEach var="memcouponVO" items="${list}">

					<tr>
<%-- 						<td>${memcouponVO.mem_coupon_id}</td> --%>
<%-- 						<td>${memcouponVO.member_id}</td> --%>
<%-- 						<td>${memcouponVO.category_id}</td> --%>
<%-- 						<td>${memcouponVO.coupon_id}</td> --%>
						<td>${memcouponVO.coupon_name}</td>
						<td>${Math.round(memcouponVO.discount)}元</td>
						<td>${(memcouponVO.status==0)?'未使用':'已使用'}</td>
<%-- 						<td>${memcouponVO.start_date}</td> --%>
<%-- 						<td>${memcouponVO.end_date}</td> --%>
<!-- 						<td> -->
<!-- 							<FORM METHOD="post" -->
<%-- 								ACTION="<%=request.getContextPath()%>/back_end/promo_list/promolist.do" --%>
<!-- 								style="margin-bottom: 0px;"> -->
<!-- 								<input type="submit" value="領取"> <input type="hidden" -->
<%-- 									name="coupon_id" value="${promolistVO.coupon_id}"> <input --%>
<!-- 									type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 							</FORM> -->
<!-- 						</td> -->
						</tr>
				</c:forEach>
			</table>

							<br> <br>
							
							<a class="aa-browse-btn" href="javascript:history.back()"><span class="fa fa-long-arrow-left"></span>&nbsp&nbsp&nbsp回上一頁</a>
							</center>
							<br> <br>
							</main>


</div>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	
</script>


</div>
<%@ include file="/includeFolder/footer2.file"%>
</body>
</html>