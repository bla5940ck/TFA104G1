<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%
 	System.out.println(request.getAttribute("pbVO"));
	PostBoardVO pbVO = (PostBoardVO) request.getAttribute("pbVO");
// 	System.out.print(pbVO.getPostId());
%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JoyLease | I want to play game!</title>

</head>

<style>
/* 	section #aa-myaccount-area{ */
/* 		background-color: #CCCCFF; */
		
/* 	} */


input:read-only {
  background-color: lightgray;
}
</style>


<body>
<%@ include file="header.file" %>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<!-- *loading畫面很久* -->
<!-- 	wpf loader Two -->
<!-- 		<div id="wpf-loader-two"> -->
<!-- 			<div class="wpf-loader-two-inner"> -->
<!-- 				<span>Loading</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	/ wpf loader Two -->
	
	<section>
	<!-- / catg header banner section -->


	<!-- Cart view section -->
	<section id="aa-myaccount">
		<div class="container">
			<div class="row" id="row1">
				<div class="col-md-12" id="col-md-12">
					<div class="aa-myaccount-area" id="aa-myaccount-area">
						<div class="row" id="row2">
<!-- 							<div class="col-md-6" id="col-md-6"> -->
								<div class="aa-myaccount-login" id="aa-myaccount-login">
									<h4>修改發文</h4>
									<form method="post" 
										  action="<%=request.getContextPath()%>/back_end/PostBoard/pb.do" 
										  name="form1" class="aa-login-form">
										
										<label for="">發文編號<span>*</span></label>
										<input type="text" name="postId" value="<%=pbVO.getPostId() %>" readonly="true">
										
										<label for="">會員編號<span>*</span></label>
										<input type="text" name="memberId" value="<%=pbVO.getMemberId() %>" readonly="true"/>
									
										<label for="">修改徵求標題<span>*</span></label> 
										<input type="text" name="postTitle" value="<%=pbVO.getPostTitle() %>" /> 
										
											
										<jsp:useBean id="cateSvc" scope="page" class="com.category.model.ProdCategoryService" />
											<label for="">項目分類<span>*</span></label>
											<div>
												<select size="1" name="categoryId">
													<c:forEach var="prodCategoryVO" items="${cateSvc.allCategory}">
															<option value="${prodCategoryVO.categoryID}" ${(param.cateNo==prodCategoryVO.categoryID)? 'selected':'' } >${prodCategoryVO.categoryName}
													</c:forEach>
												</select>
											</div>
											
										<label for="postCont">修改徵求內容<span>*</span></label>
											<div>
												 <input type="text" name="postCont" value="<%=pbVO.getPostCont() %>"/>
											</div>
										<label for="">上傳圖片</label> <input type="file" name="pic"/>
<!-- 											<label for="">項目分類<span>*</span></label> <input  -->
<!-- 											type="text" placeholder="請選擇分類" name="categoryId"/> -->
<!-- 											<label for="">項目分類<span>*</span></label> <input  -->
<!-- 											type="text" placeholder="請選擇分類" name="categoryId"/> -->

<!-- 										<label for="postTime">留言則數</label><input  -->
<%-- 										name="replyCont" type="text" value="<%=pbVO.getReplyCount() %>"/> --%>

										<label for="postTime">上傳時間</label>
										<input type="text" name="posttime" value="<%=pbVO.getPostTime() %>"/>
											
										
										 <button type="submit" class="aa-browse-btn" name="action" value="update"/>確認修改
									</form>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<!-- / Cart view section -->

</body>
<%@ include file="footer.file" %>
</html>

