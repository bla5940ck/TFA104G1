<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%
	PostBoardVO pbVO = (PostBoardVO)request.getAttribute("pbVO");
	Integer memberId = (Integer) session.getAttribute("id");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<style>

	input.memberId {
  			background-color: lightgray;
	}
	
</style>


<body>
<%@ include file="/includeFolder/header.file" %>
<!-- 錯誤表列 -->


<!-- / catg header banner section -->

<!-- Cart view section -->
	<section id="aa-myaccount">
		<div class="container">
			<div class="row" id="row1">
				<div class="col-md-12" id="col-md-12">
					<div class="aa-myaccount-area" id="aa-myaccount-area">
						<div class="row" id="row2">
							<!--<div class="col-md-6" id="col-md-6"> -->
								<div class="aa-myaccount-login" id="aa-myaccount-login">
								
									<h4>徵求發文</h4>
										<form  class="aa-login-form" method="post" name="form1"
											   action="<%=request.getContextPath()%>/back_end/PostBoard/pb.do" enctype="multipart/form-data">
											   
											   <c:if test="${not empty errorMsgs}">
													<font style="color:red">請修正以下錯誤:</font>
													<ul>
													<c:forEach var="message" items="${errorMsgs}">
													<li style="color:red">${message}</li>
													</c:forEach>
													</ul>
												</c:if>
											   
											   
<!-- 											<label for="">會員編號<span>*</span></label> -->
											<input type="hidden" name="memberId" value="<%=memberId%>"/>
									
											<label for="">請輸入徵求標題<span>*</span></label> 
											<input type="Text" name="postTitle" value=""/>
												
											
											
											<jsp:useBean id="cateSvc" scope="page" class="com.category.model.ProdCategoryService" />
											<label for="">項目分類<span>*</span></label>
											<div>
												<select size="1" name="categoryId">
													<c:forEach var="prodCategoryVO" items="${cateSvc.allCategory}">
															<option value="${prodCategoryVO.categoryID}" ${(param.cateNo==prodCategoryVO.categoryID)? 'selected':'' } >${prodCategoryVO.categoryName}
													</c:forEach>
												</select>
											<div>
											<label for="postCont">請輸入徵求內容<span>*</span></label>
												 <input type="text" placeholder="請輸入內容" 
												 		name="postCont" value=""/>
											</div>

											
											<div><label for="">上傳圖片<span>*</span></label></div>
											<image id="upload" width="200" height="100" />
											<div><input type="file" name="pic" value="insert"
												   onchange="document.getElementById('upload').src = window.URL.createObjectURL(this.files[0])"/></div>

<!-- 											<label for="postTime">上傳時間:</label> -->
<%--  											<p><fmt:formatDate name="posttime" value="${pbVO.postTime}" pattern="yyyy-MM-dd-hh-mm-ss" /></p> --%>
<!-- 											<input name="posttime" id="date" type="text"></input> -->
											
										
										 	<button type="submit" class="aa-browse-btn" name="action" value="insert"/>送出新增</button>
<!-- 										<label class="rememberme" for="rememberme"><input -->
<!-- 											type="checkbox" id="rememberme"> 記住我的帳號 </label> -->
<!-- 										<p class="aa-lost-password"></p> -->
										</form>
										
								</div>
<!-- 						</div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@ include file="/includeFolder/footer2.file" %>
</body>
</html>

