<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>出租登入</title>
</head>
<body bgcolor='white'>
<div class="modal-content">                      
        <div class="modal-body">
<div class="aa-myaccount-login">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                  <h4>出租會員Login</h4>
                  <form METHOD="post" action="<%=request.getContextPath()%>/member/LoginServlet"" class="aa-login-form">
                    <label for="">帳號 : <span>*</span></label>
                    <input type="text" name="loginId" value="" placeholder="請輸入帳號">
                    <label for="">密碼 : <span>*</span></label>
                    <input type="password" name="password" value=""  placeholder="請輸入密碼">
                    <input type=submit  value=" Login" class="aa-browse-btn">
                   	<input type="hidden" name="action"	value="RentLogin">
                    <label class="rememberme" for="rememberme"><input type="checkbox" id="rememberme"> 記住我的帳號 </label>
                    <p class="aa-lost-password"><a href="#">忘記密碼？</a></p>
                  </form>
                </div>
                 </div>                        
      </div>
</body>
</html>