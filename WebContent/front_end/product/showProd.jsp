<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="com.product.model.*"%>

<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<style>
div.simpleLens-thumbnails-container img {
	object-fit: contain;
	width: 45px;
	height: 55px;
}

img.simpleLens-big-image {
	object-fit: contain;
	width: 350px;
	height: 300px;
}
</style>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JoyLease | Product_view</title>
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
    <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>


<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<%-- <script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script> --%>
</head>
<body>
 <% Integer picAmount = (Integer)request.getAttribute("picAmount");   
  Integer prodID = (Integer)request.getAttribute("prodID");
 ProdVO product = (ProdVO)request.getAttribute("product");
	System.out.println("id" + prodID); 
	System.out.println("picAmount: " + picAmount); 
	System.out.println("product" + product); 
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
								<a
									href="<%=request.getContextPath()%>/front_end/product/productPage.jsp">

									<img
									src="<%=request.getContextPath()%>\front_end\product\img\logo_org_noframe_191561.png"
									alt=""> <!-- <p>JoyLease</p> --> <!-- <span class="fa fa-shopping-cart"></span> -->

								</a>
								<!-- img based logo -->
								<!-- <a href="index.html"><img src="img/logo.jpg" alt="logo img"></a> -->
							</div>
							<!-- / logo  -->
							<%@ include file="/includeFolder/cartInclude.file"%>

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
        <h2>SwitchOLED</h2>
        <ol class="breadcrumb">
          <li><a href="index copy.html">Home</a></li>         
          <li><a href="#">Product</a></li>
          <li class="active">T-shirt</li>
        </ol>
      </div>
     </div>
   </div>
  </section> -->
	<!-- / catg header banner section -->

	<!-- product category -->
	<section id="aa-product-details">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="aa-product-details-area">
						<div class="aa-product-details-content">
							<div class="row">







								<!-- Modal view slider -->

								<div class="col-md-5 col-sm-5 col-xs-12">
									<div class="aa-product-view-slider">
										<div id="demo-1" class="simpleLens-gallery-container">
											<div class="simpleLens-container">

												<!--                       大圖 -->
												<div class="simpleLens-big-image-container">
													<a
														data-lens-image="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=1"
														class="simpleLens-lens-image"><img
														src="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=1"
														class="simpleLens-big-image"></a>
												</div>
											</div>

<!-- 												圖片部分!!!! -->

											<div class="simpleLens-thumbnails-container">
										<c:forEach var="i" begin="1" end="${picAmount}" varStatus="loop">
													
												<a
													data-big-image="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=<c:out value="${i}"/>"
													data-lens-image="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=<c:out value="${i}"/>"
													class="simpleLens-thumbnail-wrapper" href="#"> <img
													src="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=<c:out value="${i}"/>"
													data-lens-image="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=<c:out value="${i}"/>">
												</a>
											</c:forEach>
								

											</div>
										</div>
									</div>
								</div>




								<!-- Modal view content -->
								<div class="col-md-7 col-sm-7 col-xs-12">
									<div class="aa-product-view-content">
										<h3>${product.prodName}</h3>
										<div class="aa-price-block">
											租金: <span class="aa-product-view-price">$${product.prodRent}</span><br><br>
											商品損壞賠償金: <span class="aa-product-avilability">$${product.prodPrice}</span><br>
										</div><br>
									
										備註: <span>${empty product.comt ? '' : product.comt}</span><br>
										

										</form>
										<p class="aa-prod-category">
											<%--                         分類: <a href="#"><%=product.getCategoryID() %></a> --%>
										</p>
									</div>
									<div class="aa-prod-view-bottom">
										<a  id ="shelf_btn" class="aa-add-to-cart-btn" style="color:red; background-color:yellow;"
											href="">上架商品</a>
											
										<a  class="aa-add-to-cart-btn" href="<%=request.getContextPath()%>/prod/ProdServlet?prodID=<%=product.getProdID() %>&cate=<%=product.getCategoryID()%>&action=modify" style="color:yellow; background-color:red;">修改商品</a>
									</div>
									<br>

								</div>
							</div>
						</div>
						<div class="aa-product-details-bottom">
							<ul class="nav nav-tabs" id="myTab2">
								<li><a href="#description" data-toggle="tab">商品內容</a></li>
							
							</ul>

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="description">

				<form id ="shelf_form" action="<%=request.getContextPath()%>/prod/ProdServlet" method="post" enctype="multipart/form-data">
					<input type ="hidden" name = "product_name" value=<%=product.getProdName()%>>
					<input type ="hidden" name = "product_rent" value=<%=product.getProdRent()%>>
					<input type ="hidden" name = "product_price" value=<%=product.getProdPrice()%>>
					<input type ="hidden" name = "product_cot" value=<%=product.getProdCot()%>>
					<input type ="hidden" name = "comt" value=<%=product.getComt()%>>
					<input type ="hidden" name ="prodID" value =<%=product.getProdID()%>>
					<input type ="hidden"  name ="status" value="shelf">
					<input type="hidden" name="action" value="update">
					<input type ="hidden" name = "categorySelect" value=<%=product.getCategoryID()%>>
					
				</form>
				
<%-- 				<form id ="update_form" action="<%=request.getContextPath()%>/front_end/product.uploadProd.jsp"> --%>
<%-- 					<input type ="hidden" name = "product_name" value=<%=product.getProdName()%>> --%>
<%-- 					<input type ="hidden" name = "product_rent" value=<%=product.getProdRent()%>> --%>
<%-- 					<input type ="hidden" name = "product_price" value=<%=product.getProdPrice()%>> --%>
<%-- 					<input type ="hidden" name = "product_cot" value=<%=product.getProdCot()%>> --%>
<%-- 					<input type ="hidden" name = "comt" value=<%=product.getComt()%>> --%>
<%-- 					<input type ="hidden" name ="prodID" value =<%=product.getProdID()%>> --%>
					
<!-- <!-- 					<input type ="hidden"  name ="status" value="shelf"> --> -->
<!-- <!-- 					<input type="hidden" name="action" value="update"> --> -->
<%-- 					<input type ="hidden" name = "categorySelect" value=<%=product.getCategoryID()%>> --%>
					
<!-- 				</form> -->



									<%
										char c[] = product.getProdCot().toCharArray();
										for (int i = 0; i < c.length; i++) {
											if (i % 59 == 0) {
												out.print("<p>");
											}
									%>
									<%=c[i]%>

									<%
										if (i % 60 == 0 && i != 0) {
												out.print("</p>");
											}
										}
									%>






							<!-- quick view modal -->
							<div class="modal fade" id="quick-view-modal" tabindex="-1"
								role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-body">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<div class="row">
												<!-- Modal view slider -->
												<div class="col-md-6 col-sm-6 col-xs-12">
													<div class="aa-product-view-slider">
														<div class="simpleLens-gallery-container" id="demo-1">
															<div class="simpleLens-container">
																<div class="simpleLens-big-image-container">
																	<a class="simpleLens-lens-image"
																		data-lens-image="img/view-slider/large/polo-shirt-1.png">
																		<img src="img/view-slider/medium/polo-shirt-1.png"
																		class="simpleLens-big-image">
																	</a>
																</div>
															</div>
															<div class="simpleLens-thumbnails-container">
																<a href="#" class="simpleLens-thumbnail-wrapper"
																	data-lens-image="img/view-slider/large/polo-shirt-1.png"
																	data-big-image="img/view-slider/medium/polo-shirt-1.png">
																	<img src="img/view-slider/thumbnail/polo-shirt-1.png">
																</a> <a href="#" class="simpleLens-thumbnail-wrapper"
																	data-lens-image="img/view-slider/large/polo-shirt-3.png"
																	data-big-image="img/view-slider/medium/polo-shirt-3.png">
																	<img src="img/view-slider/thumbnail/polo-shirt-3.png">
																</a> <a href="#" class="simpleLens-thumbnail-wrapper"
																	data-lens-image="img/view-slider/large/polo-shirt-4.png"
																	data-big-image="img/view-slider/medium/polo-shirt-4.png">
																	<img src="img/view-slider/thumbnail/polo-shirt-4.png">
																</a>
															</div>
														</div>
													</div>
												</div>
												<!-- Modal view content -->
												<div class="col-md-6 col-sm-6 col-xs-12">
													<div class="aa-product-view-content">
														<h3>SwitchOLED</h3>
														<div class="aa-price-block">
															<span class="aa-product-view-price">$34.99</span>
															<p class="aa-product-avilability">
																庫存狀態: <span>有現貨</span>
															</p>
														</div>
														<p>
															最新OLED新機 紅藍色主機款<br> Switch熱門遊戲任選一款<br>
															送任天堂原廠飲料提袋+耀西捲線器<br> 推薦(可選配)瑪利歐派對超級巨星 寶可夢鑽石珍珠<br>
														</p>
														<h4>數量</h4>
														<!-- <div class="aa-prod-view-size">
                              <a href="#">S</a>
                              <a href="#">M</a>
                              <a href="#">L</a>
                              <a href="#">XL</a>
                            </div> -->
														<div class="aa-prod-quantity">
															<form action="">
																<select name="" id="">
																	<option value="0" selected="1">1</option>
																	<option value="1">2</option>
																	<option value="2">3</option>
																	<option value="3">4</option>
																	<option value="4">5</option>
																	<option value="5">6</option>
																</select>
															</form>
															<p class="aa-prod-category">
																分類:<a href="#">Nintendo</a>
															</p>
														</div>
														<div class="aa-prod-view-bottom">
															<a href="#" class="e"><span
																class="fa fa-shopping-cart"></span>加入購物車</a> <a href="#"
																class="aa-add-to-cart-btn">點我看商品</a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
							<!-- / quick view modal -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- / product category -->


	<!-- Subscribe section -->
	<!-- <section id="aa-subscribe">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-subscribe-area">
            <h3>Subscribe our newsletter </h3>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ex, velit!</p>
            <form action="" class="aa-subscribe-form">
              <input type="email" name="" id="" placeholder="Enter your Email">
              <input type="submit" value="Subscribe">
            </form>
          </div>
        </div>
      </div>
    </div>
  </section> -->
	<!-- / Subscribe section -->

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

	<!-- jQuery library -->
	<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
	<!-- Include all compiled plugins (below), or include individual files as needed -->
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
	
		$("#shelf_btn").click(function(){
			 
			console.log("123");
			
			$("#shelf_form").submit();
			return false;
		});
	
	</script>
	

	

	



	



</body>
</html>