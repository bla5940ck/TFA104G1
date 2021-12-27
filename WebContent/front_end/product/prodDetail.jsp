<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="com.product.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
 
<style>
span.msgIcon {
    padding-left: 80px;
}
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


a.aa-product-img > img{
	object-fit: contain;
	width: 250px;
	height: 300px;
}
 input[type="submit"]{padding:5px 15px; background:red; border:0 none;
cursor:pointer;
-webkit-border-radius: 5px;
border-radius: 5px; 
color:white;
}

 input[type="button"]{padding:5px 15px; background:#ccc; border:0 none;
cursor:pointer;
-webkit-border-radius: 5px;
border-radius: 5px; 
}


input[type="text"]{padding:5px 15px;
border-style:solid;
border-collapse:collapse;
-webkit-border-radius: 5px;
border-radius: 5px; 
}
 
</style>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JoyLease | Product_detail</title>
<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css"
	rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.3/jquery-ui.min.js"></script>
<!-- Font awesome -->
<link href="css/font-awesome.css" rel="stylesheet">
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link href="css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
<!-- Product view slider -->
<link rel="stylesheet" type="text/css" href="css/jquery.simpleLens.css">
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css" href="css/nouislider.css">
<!-- Theme color -->
<link id="switcher" href="css/theme-color/dark-navy-theme.css"
	rel="stylesheet">
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link href="css/sequence-theme.modern-slide-in.css" rel="stylesheet"
	media="all">

<!-- Main style sheet -->
<link href="css/style copy.css" rel="stylesheet">

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

<%-- <script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script> --%>
</head>
<body>
<%	ProdService prodSvc = new ProdService();
ProdVO product = null;
BookingVO bk = new BookingVO();
Integer prodID = null;

 if (request.getParameter("prodID") != null) {
	prodID = Integer.parseInt(request.getParameter("prodID"));
	product = prodSvc.findProductByPK(prodID);
	pageContext.setAttribute("product", product);
}
else if (request.getAttribute("bk") != null) {
	bk = (BookingVO) request.getAttribute("bk");
	prodID = bk.getProdID();
	product = prodSvc.findProductByPK(prodID);
	pageContext.setAttribute("product", product);
}

BookingService bkDao = new BookingService();

int picAmount = 0;
//動態算出 資料庫圖片個數
if (product != null) {
	if (product.getPic1() != null)
		picAmount++;
	if (product.getPic2() != null)
		picAmount++;
	if (product.getPic3() != null)
		picAmount++;
}
List<BookingVO> list = null;
if (product != null) {
	list = bkDao.findDateByProdID(product.getProdID());
}

request.setAttribute("product", product);





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

						
							<!-- </div> -->
							<!-- / header top left -->
							<div class="aa-header-top-right">
                <ul class="nav navbar-nav ">
                  <li><a href="#">會員中心<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li><a href="<%=request.getContextPath()%>/front_end/product/leaseProdPage.jsp">出租專區</a></li>
                      <li><a href="#">承租專區</a></li>
                    </ul>
                  </li>
									<li class="hidden-xs"><a href="<%=request.getContextPath()%>/front_end/product/uploadProd.jsp">我要出租</a></li>
									<li class="hidden-xs"><a href="<%=request.getContextPath()%>/front_end/product/cart.jsp">購物車</a></li>
									<!-- <li class="hidden-xs"><a href="checkout.html">Checkout</a></li> -->
									<c:choose>
                  	<c:when test="${id == null}">
                     	<li><a href="<%=request.getContextPath()%>/front_end/member/LeaseLogin.jsp" data-toggle="modal" data-target="#login-modal">會員登入</a></li>
                 	</c:when>
                 	<c:otherwise>
                  		<li><a href="<%=request.getContextPath()%>/LogoutServlet" data-toggle="modal">會員登出</a></li>				
					</c:otherwise>                 
                  </c:choose>    
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
                 <form action="<%=path %>/prod/ProdServlet" method="post">
                <input type="text" name="searchCot" id="" placeholder="健身環大冒險">
                  <input type="hidden" name="action" value="search">
                  <button type="submit"><span class="fa fa-search"></span></button>
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
									 <li><a href="/TFA104G1/prod/ProdServlet?action=select&prodSelect=<c:out value="${prodSelect}"/>">所有商品</a></li>
                  <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=1&prodSelect=<c:out value="${prodSelect}"/>">Nintendo</a></li>
                  <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=2&prodSelect=<c:out value="${prodSelect}"/>">PlayStation</a></li>
                  <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=3&prodSelect=<c:out value="${prodSelect}"/>">XBOX</a></li>
                  <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=4&prodSelect=<c:out value="${prodSelect}"/>">其他遊戲主機</a></li>                                                
                  <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=5&prodSelect=<c:out value="${prodSelect}"/>">電腦遊戲</a></li>
                  <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=6&prodSelect=<c:out value="${prodSelect}"/>">桌遊</a></li>
                  <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=7&prodSelect=<c:out value="${prodSelect}"/>">拼圖</a></li>
                  <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=8&prodSelect=<c:out value="${prodSelect}"/>">其他</a></li>
							
									
								</ul></li>
							 <li><a href="<%=request.getContextPath()%>/front_end/others/Manual.jsp">使用教學</a>
              </li>
              <li><a href="<%=request.getContextPath()%>/front_end/others/Qa.jsp">Q&A</a>
              </li>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
	</section>
	

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



											<div class="simpleLens-thumbnails-container">
												<%
													for (int i = 1; i <= picAmount; i++) {
												%>

												<a
													data-big-image="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=<%=i%>"
													data-lens-image="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=<%=i%>"
													class="simpleLens-thumbnail-wrapper" href="#"> <img
													src="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=<%=i%>"
													data-lens-image="<%=path%>/prod/ProdServlet?action=detail&prodID=<%=prodID%>&no=<%=i%>">
												</a>

												<%
													}
												%>

											</div>
										</div>
									</div>
									&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									上架時間: <span class="aa-product-date" style="color:green"><fmt:formatDate value="<%=product.getShelfDate() %>" pattern="yyyy-MM-dd HH:mm"/></span>
									
								</div>


                                         <% 
											String comt = (product.getComt() == null) ? "" : product.getComt();
											
                                        List<String> labelList = jedis.lrange("prod"+product.getProdID(), 0, jedis.llen("prod"+product.getProdID()));
                                     	pageContext.setAttribute("labelList", labelList);
                          
										
										%>









								<!-- Modal view content -->
								
								<div class="col-md-7 col-sm-7 col-xs-12">
									<div class="aa-product-view-content">
										<h3 style="color:green;font-weight:bold;"><%=product.getProdName() %></h3>
										<div class="aa-price-block">
										<ul>
											 <li>   <span style="font-size:20px" class="aa-product-view-price">租金: $<%=product.getProdRent()%></span></li>
											<li>   <span style="font-size:20px"  class="aa-product-avilability">商品損壞賠償金: $<%=product.getProdPrice()%></span></li>
											<li><span style="font-size:20px" class="aa-product-avilability">會員編號:  <%=product.getMemberID()%></span></li>

										<li> <span style="font-size:20px">備註: <%=comt%></span></li>
										<td class="start" style="font-size:20px">
										<c:choose>
										<c:when test="${product.memberID!=id}">
										<li><span style="font-size:20px;">預計租借日期: <input id="startDate" type="text"  style="width:150px"></span></li>
										 <span style="font-size:20px">預計歸還日期: <input id="endDate" type="text"  style="width:150px"></span></li>
										</td><br><br>
															<td> <li style="font-size:20px">金額試算:<label id="subtotal" style="color: red"></label>元<input
											type="button" value="試算" id="subtotal_btn"></li>

										</td>
										</c:when>
										<c:otherwise>
										<li> <img style="width:500px" src="/TFA104G1/includeFolder/img/pp.png"></li>
										</c:otherwise>
										</c:choose>
					
										</br>
										標籤:&nbsp<li class="label">
											
											<c:forEach var="label" items="${labelList}" varStatus="loop">
													<c:if test="${loop.index!=0 and loop.index % 5 ==0}">
													<br>
													</c:if>
													<a href="<%=path%>/prod/LabelServlet?action=labelClick&prodID=<%=product.getProdID()%>&labelName=${label}&labelNo=${loop.index}"><span style="font-size:14px;color:#A6A600">#${label}</span></a>&nbsp
											</c:forEach>
										</li>
										
										</ul>
										
											</div>
										</form>
										<p class="aa-prod-category">
										</p>
									</div>
									<c:choose>
										<c:when test="${product.memberID!=id}">
									<div class="aa-prod-view-bottom">
										<a class="aa-add-to-cart-btn"
											href="javascript:selflog_show(<%=product.getProdID()%>)">加入購物車</a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="aa-add-to-cart-btn" href="javascript:checkout_show(<%=product.getProdID()%>)">直接結帳</a>
									</div>
									<br>
									<div>
										<input class="report-btn" type="submit" value="檢舉商品">
										<span  class="msgIcon">
										<a  href="/TFA104G1/front_end/Chatroom/Chatroom.jsp?prodID=<%=product.getProdID()%>"><img style="width:40px" src="https://img.88icon.com/download/jpg/20200725/5757bdfd6b6b7e17cddfdd11f547f2a7_512_512.jpg!88bg"></i></a>
										</span>
									</div>
									</c:when>
										</c:choose>	
								</div>
							</div>
						</div>
						<div class="aa-product-details-bottom">
							<ul class="nav nav-tabs" id="myTab2">
								<li><a href="#description" data-toggle="tab">商品內容</a></li>
								<li><a href="#review" data-toggle="tab">評價</a></li>
							</ul>

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="description">
			




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







								</div>
								<div class="tab-pane fade " id="review">
									<div class="aa-product-review-area">
										<h4>2 則評價</h4>
										<ul class="aa-review-nav">
											<li>
												<div class="media">
													<div class="media-left">
														<a href="#"> <img class="media-object"
															src="img/testimonial-img-3.jpg" alt="girl image">
														</a>
													</div>
													<div class="media-body">
														<h4 class="media-heading">
															<strong>Marla Jobs</strong> - <span>March 26, 2016</span>
														</h4>
														<div class="aa-product-rating">
															<span class="fa fa-star"></span> <span class="fa fa-star"></span>
															<span class="fa fa-star"></span> <span class="fa fa-star"></span>
															<span class="fa fa-star-o"></span>
														</div>
														<p>Lorem ipsum dolor sit amet, consectetur adipisicing
															elit.</p>
													</div>
												</div>
											</li>
											<li>
												<div class="media">
													<div class="media-left">
														<a href="#"> <img class="media-object"
															src="img/testimonial-img-3.jpg" alt="girl image">
														</a>
													</div>
													<div class="media-body">
														<h4 class="media-heading">
															<strong>Marla Jobs</strong> - <span>March 26, 2016</span>
														</h4>
														<div class="aa-product-rating">
															<span class="fa fa-star"></span> <span class="fa fa-star"></span>
															<span class="fa fa-star"></span> <span class="fa fa-star"></span>
															<span class="fa fa-star-o"></span>
														</div>
														<p>Lorem ipsum dolor sit amet, consectetur adipisicing
															elit.</p>
													</div>
												</div>
											</li>
										</ul>
										<h4>新增評價</h4>
										<div class="aa-your-rating">
											<p>評價星等</p>
											<a href="#"><span class="fa fa-star-o"></span></a> <a
												href="#"><span class="fa fa-star-o"></span></a> <a href="#"><span
												class="fa fa-star-o"></span></a> <a href="#"><span
												class="fa fa-star-o"></span></a> <a href="#"><span
												class="fa fa-star-o"></span></a>
										</div>
										<!-- review form -->
										<form action="" class="aa-review-form">
											<div class="form-group">
												<label for="message">你的評價</label>
												<textarea class="form-control" rows="3" id="message"></textarea>
											</div>
											

											<button type="submit"
												class="btn btn-default aa-review-submit">送出</button>
										</form>
									</div>
								</div>
							</div>
						</div>
						<!-- Related product -->
						<div class="aa-product-related-item">
							<h3>相關瀏覽</h3>
							<ul class="aa-product-catg aa-related-item-slider">
								<!-- start single product item -->
								
								<jsp:useBean id="prodSvc1" scope="page" class="com.product.model.ProdService" />
								<c:forEach var="prodEL" items="${prodSvc1.all}">
								<c:if test="${prodEL.categoryID==product.categoryID and prodEL.prodStatus==1 and prodEL.prodID!=product.prodID}">
								<li>
									<figure>
										<a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?prodID=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?prodID=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
										<figcaption>
											<span class="aa-product-nmae">${prodEL.prodName}</span><br>
											<span class="aa-product-price">$${prodEL.prodRent}</span>
								
										</figcaption>
									</figure>
									<div class="aa-product-hvr-content">
										<a href="#" data-toggle="tooltip" data-placement="top"
											title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
								</li>
							</c:if>
							</c:forEach>

							</ul>









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
	<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.js"></script>
	<!-- SmartMenus jQuery plugin -->
	<script type="text/javascript" src="js/jquery.smartmenus.js"></script>
	<!-- SmartMenus jQuery Bootstrap Addon -->
	<script type="text/javascript" src="js/jquery.smartmenus.bootstrap.js"></script>
	<!-- To Slider JS -->
	<script src="js/sequence.js"></script>
	<!--   <script src="js/sequence-theme.modern-slide-in.js"></script>   -->
	<!-- Product view slider -->
	<script type="text/javascript" src="js/jquery.simpleGallery.js"></script>
	<script type="text/javascript" src="js/jquery.simpleLens.js"></script>
	<!-- slick slider -->
	<script type="text/javascript" src="js/slick.js"></script>
	<!-- Price picker slider -->
	<script type="text/javascript" src="js/nouislider.js"></script>
	<!-- Custom js -->
	<script src="js/custom.js"></script>
	<!--   自己寫的 -->
	<script type="text/javascript" src="js/time.js"></script>

	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>	
	<script src="sweetalert2.min.js"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<script src="sweetalert2.all.min.js"></script>

	<script>
	/////直接結帳//////////
	function checkout_show(id){
		if($("#startDate").val()==""||$("#endDate").val()==""){
			
			alert("日期錯誤");
			return false;
		}else{
			let sDate=  $("#startDate").val();
			let eDate =	$("#endDate").val();
			
			location.href="<%=request.getContextPath()%>/cart/CartServlet?action=directCheckout&prodID="+ id +"&sDate=" +sDate+"&eDate=" + eDate ;
		}
		
	
		
		
	}
	
	
	
	
	
	

/// //加入購物車///////
function selflog_show(id){ 
	  	
		var myStartDate = new Date(startDate);
		var myEndDate = new Date(endDate);
		var date_dif = (myEndDate - myStartDate) / 86400000;
	  console.log(date_dif);
	 
	  
	 $.ajax({
	    	url:"<%=path%>/cart/CartServlet",
	    	cache : false,
	    	type: "POST",
	    	async: false,
	    	data: {
	    		action: "cart",
	    		prodID: id,
	    		startDate:$("#startDate").val(),
	    		endDate :$("#endDate").val(),
	    		rent :<%=product.getProdRent()%>,
	    		tatolPrice: (date_dif+1) * <%=product.getProdRent()%>,
	    		prodName:"<%=product.getProdName()%>",
	    		leaseID:"<%=product.getMemberID()%>",
	    		index:count
	    	},
	    	error : function(request) {
				alert("時間輸入錯誤");
			},
	    	success: function(data){
	    		
	    			console.log(data);
	    			if(data ==404){
	    				alert("日期輸入錯誤");
	    			}
	    			else if (data.length == 0 || data == null) {
						alert("請登入會員");
					} else if (data == count) {
						Swal.fire({
							  title: '此商品已存在你購物車',
							  showClass: {
							    popup: 'animate__animated animate__fadeInDown'
							  },
							  hideClass: {
							    popup: 'animate__animated animate__fadeOutUp'
							  }
							})
					} else {
						//加入購物車 數量+1
					 $("div.aa-cartbox-summary").load("<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=<%=product.getProdID()%>" + " div.aa-cartbox-summary");
					 
					 
// 						location.reload();
						$("span.aa-cart-notify").text(
								parseInt($("span.aa-cart-notify").text()) + 1);
								
						
							
						Swal.fire({
 							 position: 'center',
  							 icon: 'success',
 							 title: '加入購物車',
 							 showConfirmButton:false,
									timer : 1000
								})
							}

						},
					});
		};

		var disableddates = new Array();
	<%for (int i = 0; i < list.size(); i++) {
				long k = (list.get(i).getEstEnd().getTime() - list.get(i).getEstStart().getTime()) / 86400000;

				for (long j = 0; j <= k ; j++) {
					//儲存所有的區間日期
					long d = list.get(i).getEstStart().getTime() + 86400000 * (j);
					%>
		disableddates.push(
	<%=d%>
		);
	<%}
			}%>
		for (var i = 0; i < disableddates.length; i++) {

			disableddates[i] = formatDate(new Date(disableddates[i]));
		}

		$("#subtotal_btn").click(function() {

			var myStartDate = new Date(startDate);
			var myEndDate = new Date(endDate);
			var date_dif = (myEndDate - myStartDate) / 86400000;
			var rent =
	<%=product.getProdRent()%>
		$("#subtotal").html((date_dif + 1) * rent);
		});
		
		
		
		
		$("input.report-btn").click(function(){
			location.href="<%=path%>/front_end/memberservice/problemTypeReport.jsp?prodID=<%=product.getProdID()%>";
		});
		
		
		
		
		$.ajax({
			type:"post",
			contentType:"application/x-www-form-urlencoded;charset=utf-8",
			url:"/TFA104G1/prod/LabelServlet?action=showLabel",
			dataType:"json",
			cache:false,
			success:function(data){
// 				console.log(data);
				for(var i =0;i<7;i++){
					$('label.searchLabel').append("#"+ "<a href='<%=path%>/prod/LabelServlet?action=labelClick&labelName=" + data.all_label[i] + "'>" +data.all_label[i] + "</a>&nbsp&nbsp")
				}
//		 		$('div.tag-cloud').append()
				
			},
			error:function(){
				console.log("失敗");
			}
		});
		
		
		
		//最近瀏覽
		$.ajax({
			type:"post",
			dataType:"json",
			url:"/TFA104G1/prod/LabelServlet",
			data:{
				action:"cookieID",
				cookie :"y",
				prodID :<%=product.getProdID()%>
			},
			success:function(data){
// 				console.log(data);
				
			}
		});
		
		
		
		
		
		
		
		
		
	
	</script>



	


</body>
</html>