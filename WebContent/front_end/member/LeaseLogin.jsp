<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  lang="zh-Hant-tw">
<head>
<meta charset="UTF-8">
<title>承租登入</title>
</head>
<body bgcolor='white'>
<div class="modal-content">                      
        <div class="modal-body">
<div class="aa-myaccount-login">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                  <h3>Member Login</h3>
                  <form METHOD="post" action="<%=request.getContextPath()%>/member/LoginServlet" class="aa-login-form">
                    <label for="">帳號 : <span>*</span></label>
                    <input type="text" name="loginId" value="" placeholder="請輸入帳號">
                    <label for="">密碼 : <span>*</span></label>
                    <input type="password" name="password" value=""  placeholder="請輸入密碼">
                    <input type=submit  value=" Login" class="aa-browse-btn">
                   	<input type="hidden" name="action"	value="LeaseLogin">
 <!--                     <label class="rememberme" for="rememberme"><input type="checkbox" id="rememberme"> Remember Me </label>-->
                    <div class="attxt"><a href="<%=request.getContextPath()%>/front_end/member/MemRegister.jsp"style="color:#191561;">Register !</a></div>
					<div class="pdtxt"><a href="<%=request.getContextPath()%>/front_end/member/ForgetPW.jsp"style="color:#191561;">Forget Password ?</a></div>
                  </form>
                </div>
        
          
        </div>                        
      </div>
 
</body>
</html>