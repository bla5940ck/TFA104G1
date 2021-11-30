<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JoyLease | modify</title>
<%session.setAttribute("id",1); 


%>
 <!-- Font awesome --> 
    <link href="<%=request.getContextPath()%>/front_end/product/css/font-awesome.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="<%=request.getContextPath()%>/front_end/product/css/bootstrap.css" rel="stylesheet">   
    <!-- SmartMenus jQuery Bootstrap Addon CSS -->
    <link href="<%=request.getContextPath()%>/front_end/product/css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
    <!-- Product view slider -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/product/css/jquery.simpleLens.css">    
    <!-- slick slider -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/product/css/slick.css">
    <!-- price picker slider -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/product/css/nouislider.css">
    <!-- Theme color -->
    <link id="switcher" href="<%=request.getContextPath()%>/front_end/product/css/theme-color/dark-navy-theme.css" rel="stylesheet">
    <!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
    <!-- Top Slider CSS -->
    <link href="<%=request.getContextPath()%>/front_end/product/css/sequence-theme.modern-slide-in.css" rel="stylesheet" media="all">

    <!-- Main style sheet -->
    <link href="<%=request.getContextPath()%>/front_end/product/css/style copy.css" rel="stylesheet">    


<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
#preview1 {
	border: 1px solid lightgray;
	display: inline-block;
	width: 350px;
	min-height: 257px;
	position: relative;
}

#preview1 span.text {
	position: absolute;
	display: inlinse-block;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	z-index: -1;
	color: lightgray;
}

#preview1 img.preview_img {
	width: 100%;
}



#preview2 {
	border: 1px solid lightgray;
	display: inline-block;
	width: 350px;
	min-height: 257px;
	position: relative;
}

#preview2 span.text {
	position: absolute;
	display: inlinse-block;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	z-index: -1;
	color: lightgray;
}

#preview2 img.preview_img {
	width: 100%;
}



#preview3 {
	border: 1px solid lightgray;
	display: inline-block;
	width: 350px;
	min-height: 257px;
	position: relative;
}

#preview3 span.text {
	position: absolute;
	display: inlinse-block;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	z-index: -1;
	color: lightgray;
}

#preview3 img.preview_img {
	width: 100%;
}


</style>

</head>
<body>
<%

Integer picAmount = (Integer)request.getAttribute("picAmount");   
Integer prodID = (Integer)request.getAttribute("prodID");
ProdVO product = (ProdVO)request.getAttribute("product");
// 	System.out.println("id" + prodID); 
// 	System.out.println("picAmount: " + picAmount); 
// 	System.out.println("product" + product); 
// ProdService prodSvc = new ProdService();
// ProdVO product = null;
// BookingVO bk = new BookingVO();
// Integer prodID = null;

//  if (request.getParameter("prodID") != null) {
// 	prodID = Integer.parseInt(request.getParameter("prodID"));
// 	product = prodSvc.findProductByPK(prodID);
// }
// else if (request.getAttribute("bk") != null) {
// 	bk = (BookingVO) request.getAttribute("bk");
// 	prodID = bk.getProdID();
// 	product = prodSvc.findProductByPK(prodID);
// }

// BookingService bkDao = new BookingService();

// int picAmount = 0;
// //動態算出 資料庫圖片個數
// if (product != null) {
// 	if (product.getPic1() != null)
// 		picAmount++;
// 	if (product.getPic2() != null)
// 		picAmount++;
// 	if (product.getPic3() != null)
// 		picAmount++;
// }

  %>
	<!-- wpf loader Two -->
	<div id="wpf-loader-two">
		<div class="wpf-loader-two-inner">
			<span>Loading</span>
		</div>
	</div>
	<!-- / wpf loader Two -->
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

							<!-- start language -->
							<!-- <div class="aa-language">
                  <div class="dropdown">
                    <a class="btn dropdown-toggle" href="#" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                      <img src="img/flag/english.jpg" alt="english flag">ENGLISH
                      <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                      <li><a href="#"><img src="img/flag/french.jpg" alt="">FRENCH</a></li>
                      <li><a href="#"><img src="img/flag/english.jpg" alt="">ENGLISH</a></li>
                    </ul>
                  </div>
                </div> -->
							<!-- / language -->

							<!-- start currency -->
							<!-- <div class="aa-currency">
                  <div class="dropdown">
                    <a class="btn dropdown-toggle" href="#" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                      <i class="fa fa-usd"></i>USD
                      <span class="caret"></span>
                    </a> -->
							<!-- <ul class="dropdown-menu" aria-labelledby="dropdownMenu1"> -->
							<!-- <li><a href="#"><i class="fa fa-euro"></i>EURO</a></li>
                      <li><a href="#"><i class="fa fa-jpy"></i>YEN</a></li> -->
							<!-- </ul>
                  </div>
                </div> 
                < / currency -->
							<!-- start cellphone -->
							<!-- <div class="cellphone hidden-xs">
                  <p><span class="fa fa-phone"></span>00-62-658-658</p>
                </div> -->
							<!-- / cellphone -->
							<!-- </div> -->
							<!-- / header top left -->
							<div class="aa-header-top-right">
								<ul class="aa-head-top-nav-right">
									<li><a href="account copy.html">會員帳戶</a></li>
									<li class="hidden-xs"><a href="account copy.html">我要出租</a></li>
									<li class="hidden-xs"><a href="cart copy.html">購物車</a></li>
									<!-- <li class="hidden-xs"><a href="checkout.html">Checkout</a></li> -->
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
									src="<%=request.getContextPath()%>\front_end\product\img\logo_org_noframe_191561.png" alt=""> <!-- <p>JoyLease</p> -->
									<!-- <span class="fa fa-shopping-cart"></span> -->

								</a>
								<!-- img based logo -->
								<!-- <a href="index.html"><img src="img/logo.jpg" alt="logo img"></a> -->
							</div>
							<!-- / logo  -->
							<!-- cart box -->
							<%@ include file="/includeFolder/cartInclude.file" %>
							<!-- / cart box -->
							<!-- search box -->
							<div class="aa-search-box">
								<form action="">
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
							<!-- <li><a href="index.html">Home</a></li> -->
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
									<!-- <li><a href="#">And more.. <span class="caret"></span></a> -->
									<!-- <ul class="dropdown-menu">
                      <li><a href="#">Sleep Wear</a></li>
                      <li><a href="#">Sandals</a></li>
                      <li><a href="#">Loafers</a></li>                                      
                    </ul> -->
									<!-- </li> -->
								</ul></li>
							<li><a href="#">使用教學</a> <!-- <ul class="dropdown-menu">  
                  <li><a href="#">Kurta & Kurti</a></li>                                                                
                  <li><a href="#">Trousers</a></li>              
                  <li><a href="#">Casual</a></li>
                  <li><a href="#">Sports</a></li>
                  <li><a href="#">Formal</a></li>                
                  <li><a href="#">Sarees</a></li>
                  <li><a href="#">Shoes</a></li>
                  <li><a href="#">And more.. <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li><a href="#">Sleep Wear</a></li>
                      <li><a href="#">Sandals</a></li>
                      <li><a href="#">Loafers</a></li>
                      <li><a href="#">And more.. <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                          <li><a href="#">Rings</a></li>
                          <li><a href="#">Earrings</a></li>
                          <li><a href="#">Jewellery Sets</a></li>
                          <li><a href="#">Lockets</a></li>
                          <li class="disabled"><a class="disabled" href="#">Disabled item</a></li>                       
                          <li><a href="#">Jeans</a></li>
                          <li><a href="#">Polo T-Shirts</a></li>
                          <li><a href="#">SKirts</a></li>
                          <li><a href="#">Jackets</a></li>
                          <li><a href="#">Tops</a></li>
                          <li><a href="#">Make Up</a></li>
                          <li><a href="#">Hair Care</a></li>
                          <li><a href="#">Perfumes</a></li>
                          <li><a href="#">Skin Care</a></li>
                          <li><a href="#">Hand Bags</a></li>
                          <li><a href="#">Single Bags</a></li>
                          <li><a href="#">Travel Bags</a></li>
                          <li><a href="#">Wallets & Belts</a></li>                        
                          <li><a href="#">Sunglases</a></li>
                          <li><a href="#">Nail</a></li>                       
                        </ul>
                      </li>                   
                    </ul>
                  </li>
                </ul> --></li>
							<li><a href="#">Q&A</a> <!-- <ul class="dropdown-menu">                
                  <li><a href="#">Casual</a></li>
                  <li><a href="#">Sports</a></li>
                  <li><a href="#">Formal</a></li>
                  <li><a href="#">Standard</a></li>                                                
                  <li><a href="#">T-Shirts</a></li>
                  <li><a href="#">Shirts</a></li>
                  <li><a href="#">Jeans</a></li>
                  <li><a href="#">Trousers</a></li>
                  <li><a href="#">And more.. <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li><a href="#">Sleep Wear</a></li>
                      <li><a href="#">Sandals</a></li>
                      <li><a href="#">Loafers</a></li>                                      
                    </ul>
                  </li>
                </ul> --></li>
							<!-- <li><a href="#">Sports</a></li>
             <li><a href="#">Digital <span class="caret"></span></a>
                <ul class="dropdown-menu">                
                  <li><a href="#">Camera</a></li>
                  <li><a href="#">Mobile</a></li>
                  <li><a href="#">Tablet</a></li>
                  <li><a href="#">Laptop</a></li>                                                
                  <li><a href="#">Accesories</a></li>                
                </ul>
              </li>
              <li><a href="#">Furniture</a></li>            
              <li><a href="blog-archive.html">Blog <span class="caret"></span></a>
                <ul class="dropdown-menu">                
                  <li><a href="blog-archive.html">Blog Style 1</a></li>
                  <li><a href="blog-archive-2.html">Blog Style 2</a></li>
                  <li><a href="blog-single.html">Blog Single</a></li>                
                </ul>
              </li>
              <li><a href="contact.html">Contact</a></li>
              <li><a href="#">Pages <span class="caret"></span></a>
                <ul class="dropdown-menu">                
                  <li><a href="product.html">Shop Page</a></li>
                  <li><a href="product-detail.html">Shop Single</a></li>                
                  <li><a href="404.html">404 Page</a></li>                 -->
						</ul>
						</li>
						</ul>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
	</section>
	<!-- / menu -->

	<!-- catg header banner section -->
	<!-- <section id="aa-catg-head-banner">
    <img src="img/fashion/fashion-header-bg-8.jpg" alt="fashion img">
    <div class="aa-catg-head-banner-area">
     <div class="container">
      <div class="aa-catg-head-banner-content">
        <h2>Account Page</h2>
        <ol class="breadcrumb">
          <li><a href="index.html">Home</a></li>                   
          <li class="active">Account</li>
        </ol>
      </div>
     </div>
   </div>
  </section> -->
	<!-- / catg header banner section -->

	<!-- Cart view section -->
	<section id="aa-myaccount">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="aa-myaccount-area">
						<div class="row">
							<div class="col-md-6">
								<div class="aa-myaccount-login">
									<h4>商品修改</h4>
									<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul> 
</c:if>
					
									<form action="<%=request.getContextPath()%>/prod/ProdServlet"
										method="post" enctype="multipart/form-data"
										class="aa-login-form">
										<label for="">圖片一<span>*</span></label> <input type="file"
											id='file_id1' name='file_name1' 
											accept="image/gif, image/jpeg, image/png"><br> <label
											for="">圖片二<span></span></label>
											 <input type="file" 
											id='file_id2' name='file_name2'
											accept="image/gif, image/jpeg, image/png"><br> <label
											for="">圖片三<span></span></label>
											 <input type="file"
											id='file_id3' name='file_name3'
											accept="image/gif, image/jpeg, image/png"><br> <label
											for="">商品名稱<span>*</span></label>
											 <input type="text" name="product_name"	id="product_name"
											placeholder="請商品名稱" value ="<%=product.getProdName()%>"> <label for="">商品類別<span>*</span></label>
										<jsp:useBean id="cateSvc" scope="page"
											class="com.category.model.ProdCategoryService" />
										<select id="cate_select" name="categorySelect"
											style="display: inline; float: left; width: 100%; height: 30px;">
											<option value="">請選擇商品類別</option>
											<c:forEach varStatus="status" var="cateVO"
												items="${cateSvc.allCategory}">
													
												<option value="${cateVO.categoryID}" ${(cateVO.categoryID==param.cate)?'selected':''}>${cateVO.categoryName}
											</c:forEach>
										</select> <br>
										<br>
										<br> 
									
										
<%-- 										<jsp:useBean id="prodSvc" scope="page" class="com.product.model.ProdService" /> --%>
										<label for="">商品租金<span>*</span></label> <input
											type="text" placeholder="請輸入商品租金" name="product_rent" id="product_rent" value="<%=product.getProdRent() %>"> <label for="">商品損壞賠償金<span>*</span></label>
										<input type="text" placeholder="請輸入商品損壞賠償金" name="product_price" id="product_price" value="<%=product.getProdPrice()%>"> <label
											for="">備註<span></span></label>
											 <input type="text" placeholder="請輸入備註" name="comt" id="comt" value="<%=product.getComt()%>"> <label for="">商品內容<span>*</span></label>
										<input type="text" style="height: 150px;" name="product_cot" value="<%=product.getProdCot()%>">
										<input
			type=hidden id="fileCount" name="fileCount"><br> <input
			type="hidden" name="action" value="update">
			<input type="hidden" name="prodID" value="<%=product.getProdID()%>">
			<input type="hidden" id ="picNo1" name="picNo1">
			<input type="hidden" id ="picNo2" name="picNo2">
			<input type="hidden" id ="picNo3" name="picNo3">
			
										<button type="submit" class="aa-browse-btn" id="submit1" >修改完成</button>
<!-- 										<button type="submit" class="aa-browse-btn" -->
<!-- 											style="background-color: lightblue; color: #000;">上架商品</button> -->


									</form>
								</div>
							</div>
							<div class="col-md-6">
								<div class="aa-myaccount-register">
									<h4>圖片預覽</h4>
									<form action="" class="aa-login-form">
										<label for="">圖片一<span>*</span></label><br>

										<div id="preview1">
											<span class="text">商品圖</span>
										</div>
										<br> <label for="">圖片二<span></span></label><br>

										<div id="preview2">
											<span class="text">商品圖</span>
										</div>
										<br> <label for="">圖片三<span></span></label><br>
										<div id="preview3">
											<span class="text">商品圖</span>
										</div>
										<br>
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
												<!-- <li><a href="#">Services</a></li>
                      <li><a href="#">Discount</a></li>
                      <li><a href="#">Special Offer</a></li> -->
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
												<!-- <li><a href="#">Search</a></li>
                      <li><a href="#">Advanced Search</a></li>
                      <li><a href="#">Suppliers</a></li>
                      <li><a href="#">FAQ</a></li> -->
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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="<%=path%>/front_end/product/js/bootstrap.js"></script>  
  <!-- SmartMenus jQuery plugin -->
  <script type="text/javascript" src="<%=path%>/front_end/product/js/jquery.smartmenus.js"></script>
  <!-- SmartMenus jQuery Bootstrap Addon -->
  <script type="text/javascript" src="<%=path%>/front_end/product/js/jquery.smartmenus.bootstrap.js"></script>  
  <!-- To Slider JS -->
  <script src="<%=path%>/front_end/product/js/sequence.js"></script>
<!--   <script src="js/sequence-theme.modern-slide-in.js"></script>   -->
  <!-- Product view slider -->
  <script type="text/javascript" src="<%=path%>/front_end/product/js/jquery.simpleGallery.js"></script>
  <script type="text/javascript" src="<%=path%>/front_end/product/js/jquery.simpleLens.js"></script>
  <!-- slick slider -->
  <script type="text/javascript" src="<%=path%>/front_end/product/js/slick.js"></script>
  <!-- Price picker slider -->
  <script type="text/javascript" src="<%=path%>/front_end/product/js/nouislider.js"></script>
  <!-- Custom js -->
  <script src="<%=path%>/front_end/product/js/custom.js"></script> 

	<script>
		$("#file_id1").change(
				function() {
					$("#preview1").html(""); // 清除預覽
					var fileCount = this.files.length;
					$("#fileCount").val(fileCount);
					if (this.files.length > 3) {
						alert("最多只能選三張圖片喔");
						$("#file_id1").val("");
						$("#preview1").html("<span class='text'>預覽圖</span>");
					} else {

						if (this.files && this.files.length >= 0) {
							for (var i = 0; i < this.files.length; i++) {
								var reader = new FileReader();
								reader.onload = function(e) {
									var img = $("<img class = 'preview_img'>")
											.attr('src', e.target.result);
									$("#preview1").append(img);
									$("#picNo1").val(1);
								}
								reader.readAsDataURL(this.files[i]);
							}
						}
					}

				});

		$("#file_id2").change(
				function() {
					$("#preview2").html(""); // 清除預覽
					var fileCount = this.files.length;
					$("#fileCount").val(fileCount);
					if (this.files.length > 3) {
						alert("最多只能選三張圖片喔");
						$("#file_id2").val("");
						$("#preview2").html("<span class='text'>預覽圖</span>");
					} else {

						if (this.files && this.files.length >= 0) {
							for (var i = 0; i < this.files.length; i++) {
								var reader = new FileReader();
								reader.onload = function(e) {
									var img = $("<img class = 'preview_img'>")
											.attr('src', e.target.result);
									$("#preview2").append(img);
									$("#picNo2").val(2);
								}
								reader.readAsDataURL(this.files[i]);
							}
						}
					}

				});

		$("#file_id3").change(
				function() {
					$("#preview3").html(""); // 清除預覽
					var fileCount = this.files.length;
					$("#fileCount").val(fileCount);
					if (this.files.length > 3) {
						alert("最多只能選三張圖片喔");
						$("#file_id3").val("");
						$("#preview3").html("<span class='text'>預覽圖</span>");
					} else {

						if (this.files && this.files.length >= 0) {
							for (var i = 0; i < this.files.length; i++) {
								var reader = new FileReader();
								reader.onload = function(e) {
									var img = $("<img class = 'preview_img'>")
											.attr('src', e.target.result);
									$("#preview3").append(img);
									$("#picNo3").val(3);
								}
								reader.readAsDataURL(this.files[i]);
							}
						}
					}

				});
		
		$(window).load(function(){
		for(var i =1 ; i<=<%=picAmount%>;i++){
			console.log("11111");
			console.log(<%=prodID%>)
			var img1 = "<img class = 'preview_img' src='<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no="+ i +"'>"
			$("#preview"+i).append(img1);
	
			}
		});
	</script>
</body>
</html>