<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%
	PostBoardVO pbVO = (PostBoardVO) request.getAttribute("pbVO");
	//System.out.print(pbVO.getCategoryId());
%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JoyLease | I want to play game!</title>

<!-- Font awesome -->
<link
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/font-awesome.css"
	rel="stylesheet">
<!-- Bootstrap -->
<link
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/bootstrap.css"
	rel="stylesheet">
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/jquery.smartmenus.bootstrap.css"
	rel="stylesheet">
<!-- Product view slider -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/jquery.simpleLens.css">
<!-- slick slider -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/nouislider.css">
<!-- Theme color -->
<link id="switcher"
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/theme-color/dark-navy-theme.css"
	rel="stylesheet">
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/sequence-theme.modern-slide-in.css"
	rel="stylesheet" media="all">

<!-- Main style sheet -->
<link
	href="<%=request.getContextPath()%>/front_end/PostBorad/postborad-style/css/style copy.css"
	rel="stylesheet">

<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>


<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<style>
/* 	section #aa-myaccount-area{ */
/* 		background-color: #CCCCFF; */
		
/* 	} */



</style>


<body>


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
	<!-- SCROLL TOP BUTTON -->
	<a class="scrollToTop" href="#"><i class="fa fa-chevron-up"></i></a>
	<!-- END SCROLL TOP BUTTON -->


	<!-- Start header section -->
	<header id="aa-header">
		<!-- start header top  -->
		<div class="aa-header-top">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="aa-header-top-area">
							<!-- start header top left -->
							<div class="aa-header-top-left">
								<p style="font-size: 20px; margin: 0; font-weight: normal;">JoyLease</p>
							</div>
<!-- 這邊要連其他人的網頁 -->
							<div class="aa-header-top-right">
								<ul class="aa-head-top-nav-right">
									<li><a href="account copy.html">會員帳戶</a></li>
									<li class="hidden-xs"><a href="account copy.html">我要出租</a></li>
									<li class="hidden-xs"><a href="cart copy.html">購物車</a></li>
									<li><a href="" data-toggle="modal"
										data-target="#login-modal">會員登入</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- / header top  -->

<!-- 這邊要連其他人的網頁  -->
		<!-- start header bottom  -->
		<div class="aa-header-bottom">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="aa-header-bottom-area">
							<!-- logo  -->
							<div class="aa-logo">
								<!-- Text based logo -->
								<a href="index copy.html"> <img
									src="<%=request.getContextPath()%>\front_end\product\img\logo_org_noframe_191561.png"
									alt="">
								</a>
							</div>
							<!-- / logo  -->

							<!-- cart box -->
							<div class="aa-cartbox">
								<a class="aa-cart-link" href="#"> <span
									class="fa fa-shopping-basket"></span> <span
									class="aa-cart-title">我的購物車</span> <span class="aa-cart-notify">2</span>
								</a>
								<div class="aa-cartbox-summary">
									<ul>
										<li><a class="aa-cartbox-img" href="#"><img
												src="img/woman-small-2.jpg" alt="img"></a>
											<div class="aa-cartbox-info">
												<h4>
													<a href="#">SwitchOLED</a>
												</h4>
												<p>1 x $250</p>
											</div> <a class="aa-remove-product" href="#"><span
												class="fa fa-times"></span></a></li>
										<li><a class="aa-cartbox-img" href="#"><img
												src="img/woman-small-1.jpg" alt="img"></a>
											<div class="aa-cartbox-info">
												<h4>
													<a href="#">健身環大冒險</a>
												</h4>
												<p>1 x $250</p>
											</div> <a class="aa-remove-product" href="#"><span
												class="fa fa-times"></span></a></li>
										<li><span class="aa-cartbox-total-title">總計 </span> <span
											class="aa-cartbox-total-price"> $500 </span></li>
									</ul>
									<a class="aa-cartbox-checkout aa-primary-btn"
										href="checkout copy.html">購物車結帳</a>
								</div>
							</div>
							<!-- / cart box -->
							<!-- search box -->
							<div class="aa-search-box">
								<form action="no">
									<input type="text" name="" id="" placeholder="健身環大冒險">
									<button type="submit">
										<span class="fa fa-search"></span>
									</button>
								</form>
							</div>
							<!-- / search box -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- / header bottom  -->
	</header>
	<!-- / header section -->

<!-- 這邊要連分類頁面 -->
	<!-- menu -->
	<section id="menu">
		<div class="container">
			<div class="menu-area">
				<!-- Navbar -->
				<div class="navbar navbar-default" role="navigation">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target=".navbar-collapse">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
					</div>
					<div class="navbar-collapse collapse">
						<!-- Left nav -->
						<ul class="nav navbar-nav ">
							<li><a href="#">全部分類 <span class="caret"></span></a>
								<ul class="dropdown-menu">
									<li><a href="#">Nintendo</a></li>
									<li><a href="#">PlayStation</a></li>
									<li><a href="#">XBOX</a></li>
									<li><a href="#">其他遊戲主機</a></li>
									<li><a href="#">電腦遊戲</a></li>
									<li><a href="#">桌遊</a></li>
									<li><a href="#">拼圖</a></li>
									<li><a href="#">其他</a></li>
								</ul></li>
							<li><a href="#">使用教學</a></li>
							<li><a href="#">Q&A</a></li>
						</ul>
<!-- 						</li> -->
<!-- 						</ul> -->
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
	</section>
	<!-- / menu -->


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
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back_end/Postboard/pb.do" name="form1" class="aa-login-form">
										<label for="">會員編號<span>*</span></label><input 
										type="TEXT" name="memberId" value="<%=pbVO.getMemberId() %>"/>
									
										<label for="">請輸入徵求標題<span>*</span></label> <input 
										type="TEXT" name="postTitle" size="45" value="<%=pbVO.getPostTitle() %>" /> 
											
											<label for="">項目分類<span>*</span></label><input 
											type="TEXT" name="categoryId" value="<%=pbVO.getCategoryId() %>" />
											
											<label for="postCont">請輸入徵求內容<span>*</span></label>
											<div>
												 <input type="TEXT" name="postCont" value="<%=pbVO.getPostCont() %>"/>
											</div>
										<label for="">上傳圖片</label> <input type="file" name="pic"/>
<!-- 											<label for="">項目分類<span>*</span></label> <input  -->
<!-- 											type="text" placeholder="請選擇分類" name="categoryId"/> -->
<!-- 											<label for="">項目分類<span>*</span></label> <input  -->
<!-- 											type="text" placeholder="請選擇分類" name="categoryId"/> -->

											<label for="postTime">上傳時間</label><input 
											name="posttime" id="date" type="text" value="<%=pbVO.getPostTime() %>"/>
											
										
										 <button type="submit" class="aa-browse-btn" name="action" value="getOne_For_Update"/>確認修改
<!-- 										<label class="rememberme" for="rememberme"><input -->
<!-- 											type="checkbox" id="rememberme"> 記住我的帳號 </label> -->
<!-- 										<p class="aa-lost-password"></p> -->


									</FORM>
								</div>

<!-- 							</div> -->
<!-- 							<div class="col-md-6"> -->
<!-- 								<div class="aa-myaccount-register"> -->
<!-- 									<h4>會員註冊</h4> -->
<!-- 									<form action="" class="aa-login-form"> -->
<!-- 										<label for="">請輸入Email<span>*</span></label> <input -->
<!-- 											type="text" placeholder="請輸入Email"> <label for="">請輸入密碼<span>*</span></label> -->
<!-- 										<input type="password" placeholder="請輸入密碼"> -->
<!-- 										<button type="submit" class="aa-browse-btn">會員註冊</button> -->
<!-- 									</form> -->
<!-- 								</div> -->
<!-- 							</div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<!-- / Cart view section -->
	
	



	<!-- footer -->
	<footer id="aa-footer">
		<!-- footer bottom -->
		<div class="aa-footer-top">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="aa-footer-top-area">
							<div class="row">
								<div class="col-md-3 col-sm-6">
									<div class="aa-footer-widget">
										<h3>全部分類</h3>
										<ul class="aa-footer-nav">
											<li><a href="#">Nintendo</a></li>
											<li><a href="#">PlayStation</a></li>
											<li><a href="#">XBOX</a></li>
											<li><a href="#">其他遊戲主機</a></li>
											<li><a href="#">電腦遊戲</a></li>
											<li><a href="#">桌遊</a></li>
											<li><a href="#">拼圖</a></li>
											<li><a href="#">其他</a></li>
										</ul>
									</div>
								</div>
								<div class="col-md-3 col-sm-6">
									<div class="aa-footer-widget">
										<div class="aa-footer-widget">
											<h3>關於我們</h3>
											<ul class="aa-footer-nav">
												<li><a href="#">網站理念</a></li>
												<li><a href="#">團隊介紹</a></li>

											</ul>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-6">
									<div class="aa-footer-widget">
										<div class="aa-footer-widget">
											<h3>使用須知</h3>
											<ul class="aa-footer-nav">
												<li><a href="#">服務條款</a></li>
											</ul>
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-6">
									<div class="aa-footer-widget">
										<div class="aa-footer-widget">
											<h3>聯絡我們</h3>
											<address>
												<p>104台北市中山區南京東路三段219號5樓</p>
												<p>
													<span class="fa fa-phone"></span>02-2712-0589
												</p>
												<p>
													<span class="fa fa-envelope"></span>JoyLease@gmail.com
												</p>
											</address>
											<div class="aa-footer-social">
												<a href="#"><span class="fa fa-facebook"></span></a> <a
													href="#"><span class="fa fa-twitter"></span></a> <a
													href="#"><span class="fa fa-google-plus"></span></a> <a
													href="#"><span class="fa fa-youtube"></span></a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- footer-bottom -->
		<div class="aa-footer-bottom">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="aa-footer-bottom-area">
							<!-- <p>Designed by <a href="http://www.markups.io/">MarkUps.io</a></p> -->
							<div class="aa-footer-payment">
								<span class="fa fa-cc-mastercard"></span> <span
									class="fa fa-cc-visa"></span> <span class="fa fa-paypal"></span>
								<span class="fa fa-cc-discover"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- / footer -->

	<!-- Login Modal -->
	<div class="modal fade" id="login-modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4>登入/註冊</h4>
					<form class="aa-login-form" action="">
						<label for="">請輸入Email<span>*</span></label> <input type="text"
							placeholder="Username or email"> <label for="">密碼<span>*</span></label>
						<input type="password" placeholder="Password">
						<button class="aa-browse-btn" type="submit">登入</button>
						<label for="rememberme" class="rememberme"><input
							type="checkbox" id="rememberme"> 記住我的帳號 </label>
						<p class="aa-lost-password">
							<a href="#">忘記密碼？</a>
						</p>
						<div class="aa-register-now">
							還不是JoyLease的會員嗎？<a href="account copy.html">馬上註冊！</a>
						</div>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!-- jQuery library -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.js"></script>
	<!-- SmartMenus jQuery plugin -->
	<script type="text/javascript" src="js/jquery.smartmenus.js"></script>
	<!-- SmartMenus jQuery Bootstrap Addon -->
	<script type="text/javascript" src="js/jquery.smartmenus.bootstrap.js"></script>
	<!-- To Slider JS -->
	<script src="js/sequence.js"></script>
	<script src="js/sequence-theme.modern-slide-in.js"></script>
	<!-- Product view slider -->
	<script type="text/javascript" src="js/jquery.simpleGallery.js"></script>
	<script type="text/javascript" src="js/jquery.simpleLens.js"></script>
	<!-- slick slider -->
	<script type="text/javascript" src="js/slick.js"></script>
	<!-- Price picker slider -->
	<script type="text/javascript" src="js/nouislider.js"></script>
	<!-- Custom js -->
	<script src="js/custom.js"></script>

</body>
</html>

