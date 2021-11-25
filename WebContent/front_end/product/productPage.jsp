<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
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
    <title>JoyLease |Product</title>
    
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
    <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
    

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  
	<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script>
  </head>
                 <style>
       .aa-product-img img {
  object-fit: contain;
  width: 250px;
  height: 300px;
}</style> 
  <body> 
   <%session.setAttribute("id", 1); %>
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
                <p style="font-size: 20px; margin:0;font-weight:normal;">JoyLease</p>
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
                  <li><a href="" data-toggle="modal" data-target="#login-modal">會員登入</a></li>
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
                <a href="index copy.html">
                  
                  <img src="img\logo_org_noframe_191561.png" alt="">
                  <!-- <p>JoyLease</p> -->
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
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
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
                </ul>
              </li>
              <li><a href="#">使用教學</a>
                <!-- <ul class="dropdown-menu">  
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
                </ul> -->
              </li>
              <li><a href="#">Q&A</a>
                <!-- <ul class="dropdown-menu">                
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
                </ul> -->
              </li>
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
          </div><!--/.nav-collapse -->
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
        <h2>Fashion</h2>
        <ol class="breadcrumb">
          <li><a href="index.html">Home</a></li>         
          <li class="active">Women</li>
        </ol>
      </div>
     </div>
   </div>
  </section> -->
  <!-- / catg header banner section -->

  <!-- product category -->
  <section id="aa-product-category">
    <div class="container">
      <div class="row">
        <div class="col-lg-9 col-md-9 col-sm-8 col-md-push-3">
          <div class="aa-product-catg-content">
            <div class="aa-product-catg-head">
              <div class="aa-product-catg-head-left">
                <form action="<%=path%>/prod/ProdServlet" class="aa-sort-form">
                  <label for="">篩選</label>
                  
                  
                  
                  
                  <select name="prodSelect" class="aa-select">
                       <c:if test="${'asc'==flag}">             
                    <option value="1"  >上架時間</option>
                    <option value="2" selected="Default">價格-低到高</option>
                    <option value="3">價格-高到低</option>
                    <!-- <option value="4"></option> -->
                   </c:if>
                  
                   <c:if test="${'desc'==flag}">             
                    <option value="1"  >上架時間</option>
                    <option value="2" >價格-低到高</option>
                    <option value="3" selected="Default">價格-高到低</option>
                    <!-- <option value="4"></option> -->
                  
                   </c:if >
                    <c:if test="${empty flag or 'time'==flag}">
                    <option value="1" selected="Default" >上架時間</option>
                    <option value="2" >價格-低到高</option>
                    <option value="3" >價格-高到低</option>
                     </c:if>
                    <input type="hidden" name = "action" value="select">
<!--                     <input type="submit"> -->

                  </select>
<!--                 </form> -->
<!--                 <form action="" class="aa-show-form"> -->
<!--                   <label for="">顯示筆數</label> -->
<!--                   <select name=""> -->
                   
<!--                     <option value="1" selected="12">12</option> -->
<!--                     <option value="2">24</option> -->
<!--                     <option value="3">36</option> -->
                
<!--                   </select> -->
<!--                 </form> -->
              </div>
              <div class="aa-product-catg-head-right">
                <a id="grid-catg" href="#"><span class="fa fa-th"></span></a>
                <a id="list-catg" href="#"><span class="fa fa-list"></span></a>
              </div>
            </div>
            <div class="aa-product-catg-body">
              <ul class="aa-product-catg">
                <!-- start single product item -->
               
<!--                 /遞減排列 -->
                <c:if test="${'asc'==flag}">
                	<c:forEach var="prodEL" items="${prodList}">
					    <c:if test="${prodEL.prodStatus==1}">
					    <li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?picNo=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?picNo=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?picNo=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#">${prodEL.prodName}</a></h4>
                      <span class="aa-product-price">$${prodEL.prodRent}</span>
                       <p class="aa-product-descrip">${prodEL.prodCot}</p>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                    <span class="aa-badge aa-hot" href="#">很搶手</span>
                </li>	
					 </c:if>	
			</c:forEach>
                 </c:if>	
                 
                 
<!--                  	/遞增排列 -->
                 	<c:if test="${'desc'==flag}">
                	<c:forEach var="prodEL" items="${prodList}">
					    <c:if test="${prodEL.prodStatus==1}">
					    <li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?picNo=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?picNo=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?picNo=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#">${prodEL.prodName}</a></h4>
                      <span class="aa-product-price">$${prodEL.prodRent}</span>
                       <p class="aa-product-descrip">${prodEL.prodCot}</p>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                    <span class="aa-badge aa-hot" href="#">很搶手</span>
                </li>	
					 </c:if>	
			</c:forEach>
                 </c:if>
                 
                 	
                 	
<!--                  一般排列 -->
                 <% if(request.getAttribute("flag")==null ||request.getAttribute("flag")=="time"){
               ProdService prodDao = new ProdService(); 
               List<ProdVO> list1 = new ArrayList<ProdVO>();
      		    list1 = prodDao.getAll();

               if(list1!=null&&list1.size()>0){
              for(int i=0;i<list1.size();i++){
                 ProdVO product1 = list1.get(i);
                 
                
                 //狀態 為1時才可以顯示在上架頁面
                 if(product1.getProdStatus()==1){
        
           %>   
                <li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?picNo=<%=product1.getProdID()%>">
                    <img src="<%=request.getContextPath()%>/prod/ProdServlet?picNo=<%=product1.getProdID()%>&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?picNo=<%=product1.getProdID()%>"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#"><%=product1.getProdName() %></a></h4>
                      <span class="aa-product-price">$<%=product1.getProdRent() %></span>
                       <p class="aa-product-descrip"><%=product1.getProdCot() %></p>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                    <span class="aa-badge aa-hot" href="#">很搶手</span>
                </li>
                
                <%}
                   }
              } 
               }
          %>
                 
                    
              </ul>
              <!-- quick view modal -->                  
              <div class="modal fade" id="quick-view-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">                      
                    <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <div class="row">
                       
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <div class="aa-product-view-content">
  
                            <div class="aa-prod-view-bottom">
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>                        
                  </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
              </div>
              <!-- / quick view modal -->   
            </div>
            <div class="aa-product-catg-pagination">
              <nav>
                <ul class="pagination">
                  <li>
                    <a href="#" aria-label="Previous">
                      <span aria-hidden="true">&laquo;</span>
                    </a>
                  </li>
                  <li><a href="#">1</a></li>
                  <li><a href="#">2</a></li>
                  <li><a href="#">3</a></li>
                  <li><a href="#">4</a></li>
                  <li><a href="#">5</a></li>
                  <li>
                    <a href="#" aria-label="Next">
                      <span aria-hidden="true">&raquo;</span>
                    </a>
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-4 col-md-pull-9">
          <aside class="aa-sidebar">
            <!-- single sidebar -->
            <div class="aa-sidebar-widget">
              <h3>分類</h3>
              <ul class="aa-catg-nav">
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
            <!-- single sidebar -->
            <div class="aa-sidebar-widget">
              <h3>關鍵字</h3>
              <div class="tag-cloud">
                <a href="#">PS5</a>
                <a href="#">動物森友會</a>
                <a href="#">健身環</a>
                <a href="#">瑪莉歐</a>
                <a href="#">寶可夢</a>
                <a href="#">SwitchOLED</a>
                <a href="#">金馬58麻將組</a>
              </div>
            <!-- single sidebar -->
            <!-- <div class="aa-sidebar-widget">
              <h3>Shop By Price</h3>               -->
              <!-- price range -->
              <!-- <div class="aa-sidebar-price-range">
               <form action="">
                  <div id="skipstep" class="noUi-target noUi-ltr noUi-horizontal noUi-background">
                  </div>
                  <span id="skip-value-lower" class="example-val">30.00</span>
                 <span id="skip-value-upper" class="example-val">100.00</span>
                 <button class="aa-filter-btn" type="submit">Filter</button>
               </form>
              </div>              

            </div> -->
            <!-- single sidebar -->
            <!-- <div class="aa-sidebar-widget">
              <h3>Shop By Color</h3>
              <div class="aa-color-tag">
                <a class="aa-color-green" href="#"></a>
                <a class="aa-color-yellow" href="#"></a>
                <a class="aa-color-pink" href="#"></a>
                <a class="aa-color-purple" href="#"></a>
                <a class="aa-color-blue" href="#"></a>
                <a class="aa-color-orange" href="#"></a>
                <a class="aa-color-gray" href="#"></a>
                <a class="aa-color-black" href="#"></a>
                <a class="aa-color-white" href="#"></a>
                <a class="aa-color-cyan" href="#"></a>
                <a class="aa-color-olive" href="#"></a>
                <a class="aa-color-orchid" href="#"></a>
              </div>                            
            </div> -->
            <!-- single sidebar -->
            <div class="aa-sidebar-widget">
              <h3>最近瀏覽</h3>
              <div class="aa-recently-views">
                <ul>
                  <li>
                    <a href="#" class="aa-cartbox-img"><img alt="img" src="<%=path%>/front_end/product/img/woman-small-2.jpg"></a>
                    <div class="aa-cartbox-info">
                      <h4><a href="#">PS5</a></h4>
                      <p>1 x $250</p>
                    </div>                    
                  </li>
                  <li>
                    <a href="#" class="aa-cartbox-img"><img alt="img" src="<%=path%>/front_end/product/img/woman-small-1.jpg"></a>
                    <div class="aa-cartbox-info">
                      <h4><a href="#">動物森友會</a></h4>
                      <p>1 x $250</p>
                    </div>                    
                  </li>
                   <li>
                    <a href="#" class="aa-cartbox-img"><img alt="img" src="<%=path%>/front_end/product/img/woman-small-2.jpg"></a>
                    <div class="aa-cartbox-info">
                      <h4><a href="#">寶可夢</a></h4>
                      <p>1 x $250</p>
                    </div>                    
                  </li>                                      
                </ul>
              </div>                            
            </div>
            <!-- single sidebar -->
            <div class="aa-sidebar-widget">
              <h3>熱門瀏覽</h3>
              <div class="aa-recently-views">
                <ul>
                  <li>
                    <a href="#" class="aa-cartbox-img"><img alt="img" src="<%=path%>/front_end/product/img/woman-small-2.jpg"></a>
                    <div class="aa-cartbox-info">
                      <h4><a href="#">PS5</a></h4>
                      <p>1 x $250</p>
                    </div>                    
                  </li>
                  <li>
                    <a href="#" class="aa-cartbox-img"><img alt="img" src="<%=path%>/front_end/product/img/woman-small-1.jpg"></a>
                    <div class="aa-cartbox-info">
                      <h4><a href="#">動物森友會</a></h4>
                      <p>1 x $250</p>
                    </div>                    
                  </li>
                   <li>
                    <a href="#" class="aa-cartbox-img"><img alt="img" src="<%=path%>/front_end/product/img/woman-small-2.jpg"></a>
                    <div class="aa-cartbox-info">
                      <h4><a href="#">健身環大冒險</a></h4>
                      <p>1 x $250</p>
                    </div>                    
                  </li>                                      
                </ul>
              </div>                            
            </div>
          </aside>
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
                      <p> 104台北市中山區南京東路三段219號5樓</p>
                      <p><span class="fa fa-phone"></span>02-2712-0589</p>
                      <p><span class="fa fa-envelope"></span>JoyLease@gmail.com</p>
                    </address>
                    <div class="aa-footer-social">
                      <a href="#"><span class="fa fa-facebook"></span></a>
                      <a href="#"><span class="fa fa-twitter"></span></a>
                      <a href="#"><span class="fa fa-google-plus"></span></a>
                      <a href="#"><span class="fa fa-youtube"></span></a>
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
              <span class="fa fa-cc-mastercard"></span>
              <span class="fa fa-cc-visa"></span>
              <span class="fa fa-paypal"></span>
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
  <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">                      
        <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4>登入/註冊</h4>
          <form class="aa-login-form" action="">
            <label for="">請輸入Email<span>*</span></label>
            <input type="text" placeholder="Username or email">
            <label for="">密碼<span>*</span></label>
            <input type="password" placeholder="Password">
            <button class="aa-browse-btn" type="submit">登入</button>
            <label for="rememberme" class="rememberme"><input type="checkbox" id="rememberme"> 記住我的帳號 </label>
            <p class="aa-lost-password"><a href="#">忘記密碼？</a></p>
            <div class="aa-register-now">
              還不是JoyLease的會員嗎？<a href="account copy.html">馬上註冊！</a>
            </div>
          </form>
        </div>                        
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
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
<script> $("select.aa-select").change(function(){
	$("form.aa-sort-form").submit();
}) ;  </script>
  </body>
</html>