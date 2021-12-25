<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  lang="zh-Hant-tw">
<head>
<meta charset="UTF-8">
<title>承租登入</title>
<!--  
<link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.0.0-alpha1/css/bootstrap.min.css" rel="stylesheet">
    -->
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.0.0-alpha1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdn.staticfile.org/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    <!-- <link rel="stylesheet" href="css/style.css"> -->
    <style type="text/css">
      #login{
        margin: 10%;
      }
    </style>


</head>
<body bgcolor='white'>
<div class="modal-content">                      
        <div class="modal-body">
<div id="login"  class="aa-myaccount-login">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                  <h3>Member Login</h3>
                  <form id="loginForm" METHOD="post" action="<%=request.getContextPath()%>/member/LoginServlet" class="aa-login-form">
                    <label for="">帳號 : <span>*</span></label>
                    <input id="username" type="text" name="loginId" value="" placeholder="請輸入帳號">
                    <label for="">密碼 : <span>*</span></label>
                    <input id="password" type="password" name="password" value=""  placeholder="請輸入密碼">
                    <input type=submit id="login"  value=" Login" class="aa-browse-btn"onclick="myLogin()">
                   	<input type="hidden" name="action"	value="LeaseLogin">
                   <label class="rememberme" for="remember"><input type="checkbox" id="remember"> Remember Me </label>
                    <div class="attxt"><a href="<%=request.getContextPath()%>/front_end/member/MemRegister.jsp"style="color:#191561;">Register !</a></div>
					<div class="pdtxt"><a href="<%=request.getContextPath()%>/front_end/member/LoginForgetPW.jsp"style="color:#191561;">Forget Password ?</a></div>
                  </form>
                </div>
        
          
        </div>                        
      </div>
 
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
  
//  alert("登入成功！！");
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