<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%
	PostBoardVO pbVO = (PostBoardVO)request.getAttribute("pbVO");
	
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
<%@ include file="header.file" %>
<%-- ���~��C --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">�Эץ��H�U���~:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>

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
								
									<h4>�x�D�o��</h4>
										<form  class="aa-login-form" method="post" name="form1"
											   action="<%=request.getContextPath()%>/back_end/PostBoard/pb.do" enctype="multipart/form-data">
											   
											<label for="">�|���s��<span>*</span></label>
											<input type="Text" name="memberId" value=""/>
									
											<label for="">�п�J�x�D���D<span>*</span></label> 
											<input type="Text" name="postTitle" value=""/>
											
											
											<jsp:useBean id="cateSvc" scope="page" class="com.category.model.ProdCategoryService" />
											<label for="">���ؤ���<span>*</span></label>
											<div>
												<select size="1" name="categoryId">
													<c:forEach var="prodCategoryVO" items="${cateSvc.allCategory}">
															<option value="${prodCategoryVO.categoryID}" ${(param.cateNo==prodCategoryVO.categoryID)? 'selected':'' } >${prodCategoryVO.categoryName}
													</c:forEach>
												</select>
											<div>
											<label for="postCont">�п�J�x�D���e<span>*</span></label>
												 <input type="text" placeholder="�п�J���e" 
												 		name="postCont" value=""/>
											</div>

											
											<label for="">�W�ǹϤ�</label> 
												<input type="file" name="pic" value="insert"/>
												

											<label for="postTime">�W�Ǯɶ�</label>
											<input name="posttime" id="date" type="text"></input>
											
										
										 	<button type="submit" class="aa-browse-btn" name="action" value="insert"/>�e�X�s�W</button>
<!-- 										<label class="rememberme" for="rememberme"><input -->
<!-- 											type="checkbox" id="rememberme"> �O��ڪ��b�� </label> -->
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
<%@ include file="footer.file" %>
</body>
</html>

