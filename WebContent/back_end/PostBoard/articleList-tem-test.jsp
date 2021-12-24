<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.postboard.model.*"%>

<%
	PostBoardService pbSvc = new PostBoardService();
	List<PostBoardVO> list = pbSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>articleList</title>


<style>
	#cart-view .cart-view-area {
	  display: inline;
	  float: left;
	  padding-top: 0px;
	  width: 100%;
}
</style>
</head>

<body bgcolor='white'>
<%@ include file="header.file" %>
	<%-- ���~��C --%>
	
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

<section id="cart-view">
   <div class="container">
     <div class="row">
       <div class="col-md-12">
         <div class="cart-view-area">
           <div class="cart-view-table aa-wishlist-table">
             <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/Postboard/pb.do" name="form1">
               <div class="table-responsive">
                  <table class="table">
                    <thead>
                      <tr>
                      <!-- <th></th>
                        <th></th> -->
                          <th>�峹�Ǹ�</th>
                          <th>���O�s��</th>
                          <th>�o��̽s��</th>
                          <th>�x�D���D</th>
                          <th>�x�D���e</th>
                          <th>����ɶ�</th>
                          <th>�d���H��</th>
                          <th>�Ϥ�</th>
                          <th>�ק�</th>
                          <th>�R��</th>
                        <!-- <th></th> -->
                      </tr>
<%--                       <%@ include file="page1.file"%> --%>
<%-- 					  <c:forEach var="postBoardVO" items="${list}" begin="<%=pageIndex%>" --%>
<%-- 			                     end="<%=pageIndex+rowsPerPage-1%>"></c:forEach> --%>
                    </thead>
                      
            

			 <tbody>
                      <tr>
                        <td>${postBoardVO.postId}</td>
						<td>${postBoardVO.categoryId}</td>
						<td>${postBoardVO.memberId}</td>
						<td>${postBoardVO.postTitle}</td>
						<td>${postBoardVO.postCont}</td>
						<td>${postBoardVO.postTime}</td>
						<td>${postBoardVO.replyCount}</td>
						<td>${postBoardVO.pic}</td>
                        <td>
	                        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/Postboard/pb.do" style="margin-bottom: 0px;">
		                        <input type="submit" class="aa-browse-btn" value="�ק�"/> 
		                        <input type="hidden" class="aa-browse-btn" name="postId" value="${postBoardVO.postId}" > 
								<input type="hidden" class="aa-browse-btn" name="action" value="getOne_For_Update">
							</FORM>
						</td>
                        <td>
                        	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/Postboard/pb.do" style="margin-bottom: 0px;">
								<input type="submit"  class="aa-browse-btn" value="�R��"/> 
								<input type="hidden"  class="aa-browse-btn" name="postId" value="${postBoardVO.postId}" > 
								<input type="hidden"  class="aa-browse-btn" name="action" value="delete" >
							</FORM>
						</td>

                      </tr>                   
                      </tbody>
                  </table>
<%--                   <%@ include file="page2.file"%> --%>
                </div>
             </FORM>             
           </div>
         </div>
       </div>
     </div>
   </div>
 </section>

</body>
<%@ include file="/includeFolder/footer2.file" %>
</html>