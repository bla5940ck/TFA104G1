<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title> Forgot Password</title>
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"
    type="text/javascript"></script>

</head>

<body class="bg-gradient-primary">
<%@ include file="/includeFolder/header.file"%>
<section id="aa-myaccount">
		<div class="container">
			<div class="row" id="row1">
				<div class="col-md-12" id="col-md-12">
					<div class="aa-myaccount-area" id="aa-myaccount-area"> 
						<div class="row" id="row2">
							<!--<div class="col-md-6" id="col-md-6"> -->
								<div class="aa-myaccount-login" id="aa-myaccount-login">
								<h1>忘記密碼</h1>
                                        <p class="mb-4">We get it, stuff happens. Just enter your email address below
                                            and we'll send you a new password!</p>
                                    </div>
                                   <form METHOD="post" action="<%=request.getContextPath()%>/member/MemberForgotPwServlet" class="user">
                                        <div class="form-group">
                                        	 <input type="email" name="email" value="" class="form-control form-control-user"
                                                id="exampleInputEmail" aria-describedby="emailHelp"
                                                placeholder="Enter Email Address...">
                                        </div>
                                        	<input type="submit" class="form-control form-control-user"
                                                id="exampleInputEmail"  value="送出" 
                                                placeholder="Enter Email Address...">
                   								<input type="hidden" name="action"	value="forgetPW">
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="<%=request.getContextPath()%>/front_end/member/MemRegister.jsp">Create an Account!</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="<%=request.getContextPath()%>/front_end/member/LeaseLogin.jsp">Already have an account? Login!</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
</section>
     

<%@ include file="/includeFolder/footer2.file"%>
</body>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</html>