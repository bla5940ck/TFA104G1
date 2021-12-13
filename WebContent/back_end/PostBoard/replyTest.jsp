<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.pbreply.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%
	pbReplyVO pbrVo = (pbReplyVO) request.getAttribute("pbrVO");

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<body>
		<form  class="aa-login-form" method="post" name="form1"
			   action="<%=request.getContextPath()%>/pbReplyServlet" >
<!-- 		<div>									    -->
<!-- 		<label for="">留言編號<span>*</span></label> -->
<!-- 		<input type="Text" name="replyId" value=""/> -->
<!-- 		</div> -->
		
		<div>									   
		<label for="">文章編號<span>*</span></label>
		<input type="Text" name="postId" value=""/>
		</div>	
		
		<div>							
		<label for="">會員編號<span>*</span></label> 
		<input type="Text" name="memberId" value=""/>
		</div>
			
		<div>							
		<label for="">請輸入留言<span>*</span></label> 
		<input type="Text" name="replyCont" value=""/>
		</div>
		
		<div>									
		<label for="replyTime">上傳時間</label>
		<input name="replyTime" id="date" type="text"></input>
		</div>									
										
		<button type="submit" class="aa-browse-btn" name="action" value="insert"/>送出新增</button>

		</form>



</body>
</html>