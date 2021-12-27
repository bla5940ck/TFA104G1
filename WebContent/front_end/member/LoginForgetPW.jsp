<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login & ForgetPW</title>
<!--  
<link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.0.0-alpha1/css/bootstrap.min.css" rel="stylesheet">
   -->
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.0.0-alpha1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdn.staticfile.org/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
</head>
<body>
<%@ include file="/includeFolder/header.file" %>

 <!-- Cart view section -->
 <section id="aa-myaccount">
   <div class="container">
     <div class="row">
       <div class="col-md-12">
        <div class="aa-myaccount-area">         
            <div class="row">
              <div class="col-md-6">
                <div class="aa-myaccount-login">
                <h4>會員登入</h4>
                 <form  id="loginForm"  METHOD="post" action="<%=request.getContextPath()%>/member/LoginServlet" class="aa-login-form">
                  <label for="">帳號 : <span>*</span></label>
                    <input id="username" type="text" name="loginId" value="" placeholder="請輸入帳號">
                    <label for="">密碼 : <span>*</span></label>
                    <input  id="password"  type="password" name="password" value=""  placeholder="請輸入密碼">
                    <input type=submit  id="login" value=" 登入" class="aa-browse-btn"onclick="myLogin()">
                   	<input type="hidden" name="action"	value="LeaseLogin">
 					<label class="rememberme" for="remember">
 					<input type="checkbox" id="remember"> 記住我</label>
                    <div class="attxt"><a href="<%=request.getContextPath()%>/front_end/member/MemRegister.jsp"style="color:#191561;">立刻註冊 !</a></div>
				<%--	<div class="pdtxt"><a href="<%=request.getContextPath()%>/front_end/member/LoginForgetPW.jsp"style="color:#191561;">忘記密碼 ?</a></div>  --%>
                  </form>
                </div>
              </div>
              <div class="col-md-6">
                <div class="aa-myaccount-register">                 
                 <h4>忘記密碼 ?</h4>
                 <p class="mb-4">請在以下輸入您的 Email Address
                                             我們會向您發送一個新密碼！</p>
                                      
                 <form METHOD="post" action="<%=request.getContextPath()%>/member/MemberForgotPwServlet" class="user">
                    <label for="">Email Address<span>*</span></label>
                    <input type="email" name="email" value="" class="form-control form-control-user"
                                                id="exampleInputEmail" aria-describedby="emailHelp"
                                                placeholder="請輸入註冊時 Email Address">
                    <br>
                    <input type="submit" class="aa-browse-btn"
                                                id="exampleInputEmail"  value="送出" 
                                                placeholder="Enter Email Address...">
                   								<input type="hidden" name="action"	value="forgetPW">
                  </form>
                </div>
              </div>
            </div>          
         </div>
       </div>
     </div>
   </div>
 </section>
 <!-- / Cart view section -->


<%@ include file="/includeFolder/footer2.file" %>
</body>
<script type="text/javascript">
//檢查cookie
$(document).ready(function(){
  console.log("ok");
  console.log($.cookie("username"));
   if ($.cookie("username") != null) {
     console.log("ok");
     //往input#username填入存到cookie中username的值
     $("#username").val($.cookie("username"));
     //往input#password填入存到cookie中username的值
     $("#password").val($.cookie("password"));
     //讓“記住我”的checkbox維持選中的狀態
     $('input:checkbox').attr("checked", true);
   }
});

function myLogin(){
  username = $('#username').val(); //用户名
  password = $('#password').val(); //密碼
  
 // alert("登入成功！！");
  //在返回登入成功的後
  
  remember = $('#remember').is(':checked') ? 1 : 0;
  //如果““記住我”的checkbox選中，保存帳號密碼”
  if (remember == 1) {
    $.cookie("username", username, {
      expires: 7
    });
    $.cookie("password", password, {
      expires: 7
    });
    console.log($.cookie("username"));
    //如果“記住我”的checkbox沒選中，移除之前保存的訊息。”
  } else {
    $.removeCookie('username');
    $.removeCookie('password');
  }
}
</script>
</html>