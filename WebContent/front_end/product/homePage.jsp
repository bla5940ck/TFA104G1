<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<style>
      .aa-product-img img {
  object-fit: contain;
  width: 250px;
  height: 300px;
}


</style>
 	 <%@ include file="/includeFolder/header.file"%>
 

  <!-- / menu -->
  <!-- Start slider -->
  <section id="aa-slider">
    <div class="aa-slider-area">
      <div id="sequence" class="seq">
        <div class="seq-screen">
          <ul class="seq-canvas">
            <!-- single slide item -->
            <li>
              <div class="seq-model">
                <img data-seq src="img\test.jpg" alt="first" />
              </div>
              <div class="seq-title">
               <!-- <span data-seq></span>                 -->
                <!-- <h2 data-seq>Switch</h2>                 -->
                <!-- <p data-seq>Switch出租中</p> -->
                <!-- <a data-seq href="#" class="aa-shop-now-btn aa-secondary-btn">SHOP NOW</a> -->
              </div>
            </li>
            <!-- single slide item -->
            <li>
              <div class="seq-model">
                <img data-seq src="img\fifa1.jfif" alt="Wristwatch slide img" />
              </div>
              <div class="seq-title">
                <!-- <span data-seq>Save Up to 40% Off</span>                
                <h2 data-seq>XBOX</h2>                
                <p data-seq>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minus, illum.</p>
                <a data-seq href="#" class="aa-shop-now-btn aa-secondary-btn">SHOP NOW</a> -->
              </div>
            </li>
            <!-- single slide item -->
            <li>
              <div class="seq-model">
                <img data-seq src="img\marvel1.jfif" alt="Women Jeans slide img" />
              </div>
              <div class="seq-title">
                <!-- <span data-seq>Save Up to 75% Off</span>                
                <h2 data-seq>PS4</h2>                
                <p data-seq>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minus, illum.</p>
                <a data-seq href="#" class="aa-shop-now-btn aa-secondary-btn">SHOP NOW</a> -->
              </div>
            </li>
            <!-- single slide item -->           
            <li>
              <div class="seq-model">
                <img data-seq src="img\xbox1.jpg" alt="Shoes slide img" />
              </div>
              <div class="seq-title">
            
              </div>
            </li>
            <!-- single slide item -->  
             <li>
              <div class="seq-model">
                <img data-seq src="img\spiderman1.png" alt="Male Female slide img" />
              </div>
              <div class="seq-title">
               
              </div>
            </li>                   
          </ul>
        </div>
        <!-- slider navigation btn -->
        <fieldset class="seq-nav" aria-controls="sequence" aria-label="Slider buttons">
          <a type="button" class="seq-prev" aria-label="Previous"><span class="fa fa-angle-left"></span></a>
          <a type="button" class="seq-next" aria-label="Next"><span class="fa fa-angle-right"></span></a>
        </fieldset>
      </div>
    </div>
  </section>
  <!-- / slider -->
  <!-- Start Promo section -->
  <section id="aa-promo">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-promo-area">
            <div class="row">
              <!-- promo left -->
              <div class="col-md-5 no-padding">                
                <div class="aa-promo-left">
                  <div class="aa-promo-banner">                    
                    <img src="img\pokemon.jpg" alt="img">                    
                    <div class="aa-prom-content">
                      <!-- <span>75% Off</span> -->
                      <!-- <h4><a href="#">For Women</a></h4>                       -->
                    </div>
                  </div>
                </div>
              </div>
              <!-- promo right -->
              <div class="col-md-7 no-padding">
                <div class="aa-promo-right">
                  <div class="aa-single-promo-right">
                    <div class="aa-promo-banner">                      
                      <img src="img\switch_Aragaki Yui.jpg" alt="img">                      
                      <div class="aa-prom-content">
                        <!-- <span>Exclusive Item</span>
                        <h4><a href="#">For Men</a></h4>                         -->
                      </div>
                    </div>
                  </div>
                  <div class="aa-single-promo-right">
                    <div class="aa-promo-banner">                      
                      <img src="img\goldhorse.jpg" alt="img">                      
                      <div class="aa-prom-content">
                        <!-- <span>Sale Off</span>
                        <h4><a href="#">On Shoes</a></h4>                         -->
                      </div>
                    </div>
                  </div>
                  <div class="aa-single-promo-right">
                    <div class="aa-promo-banner">                      
                      <img src="img\watch-dogs1.jfif" alt="img">                      
                      <div class="aa-prom-content">
                        <!-- <span>New Arrivals</span>
                        <h4><a href="#">For Kids</a></h4>                         -->
                      </div>
                    </div>
                  </div>
                  <div class="aa-single-promo-right">
                    <div class="aa-promo-banner">                      
                      <img src="img\switcholed.jpg" alt="img">                      
                      <div class="aa-prom-content">
                        <!-- <span>25% Off</span>
                        <h4><a href="#">For Bags</a></h4>                         -->
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
  </section>
  <!-- / Promo section -->
  <!-- Products section -->
  <center><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front_end/getCoupon/getcoupon.do" style="margin-bottom: 0px;">
			     <input type="image" src="<%=request.getContextPath()%>/includeFolder/img/coupon_2.jpg">
			     <input type="hidden" name="amount"  value="0">
			     <input type="hidden" name="action"	value="getAmount"></FORM></center>
  <section id="aa-product">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="row">
            <div class="aa-product-area">
              <div class="aa-product-inner">
                <!-- start prduct navigation -->
                 <ul class="nav nav-tabs aa-products-tab">
                    <li class="active"><a href="#men" data-toggle="tab">熱門排行</a></li>
                    <!-- <li><a href="#women" data-toggle="tab">Women</a></li>
                    <li><a href="#sports" data-toggle="tab">Sports</a></li>
                    <li><a href="#electronics" data-toggle="tab">Electronics</a></li> -->
                  </ul>
                  <!-- Tab panes -->
                  <div class="tab-content">
                    <!-- Start men product category -->
                    <div class="tab-pane fade in active" id="men">
                      <ul class="aa-product-catg">
                        <!-- start single product item -->
                        
                        <!-- start single product item -->
                        <jsp:useBean id="prodSvc1" scope="page" class="com.product.model.ProdService" />
                     
                        <c:forEach var = "prod" items="${prodSvc1.countGroupbyProdID}" varStatus="loop">
                      	<c:forEach var="prodVO" items="${prodSvc1.all }">
                        <c:if test="${loop.index<8 && prodVO.prodID==prod.key && prodVO.prodStatus==1}">
                        <li>
                          <figure>
                            <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodVO.prodID}">
                            <img src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=${prodVO.prodID}" alt="polo shirt img"></a>
                            <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodVO.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                             <figcaption>
                              <h4 class="aa-product-title"><a >${prodVO.prodName}</a></h4>
                              <span class="aa-product-price">$${prodVO.prodRent }</span><br>
                                已租次數:<span style="color:blue" class="aa-product-price">${prod.value}</span>
                            </figcaption>
                          </figure>                         
                          <div class="aa-product-hvr-content">
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                          </div>
                          <!-- product badge -->
                          <c:if test="${loop.index==0}">
                           <span style="background-color:yellow;border-radius:35%;box-shadow:0px 0px 15px red;color:red"class="aa-badge aa-sale" href="#">天下第一租</span>
                           </c:if>
                           <c:if test="${loop.index==1}">
                         <span style="background-color:	#00AEAE;border-radius:35%; box-shadow:0px 0px 15px yellow;color:white" class="aa-badge aa-sale" href="#">天下第二租</span>
                           </c:if>
                           <c:if test="${loop.index==2}">
                         <span	style="background-color:#F75000;border-radius:35%; box-shadow:0px 0px 15px yellow; color:white"  class="aa-badge aa-sale" href="#">天下第三租</span>
                           </c:if>
                              <c:if test="${loop.index>=3}">
                           <span style="background-color:blue;"class="aa-badge aa-sale" href="#">很搶手</span>
                           </c:if>
                           
                        </li>
                        </c:if>
                        </c:forEach>
                        </c:forEach>
                     
                      </ul>
                      <a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/product/productPage.jsp">點我看更多 <span class="fa fa-long-arrow-right"></span></a>
                    </div>
                    <!-- / men product category -->
                    <!-- start women product category -->
                 
                    <!-- / women product category -->
                    <!-- start sports product category -->
                    <div class="tab-pane fade" id="sports">
                  
                     
                    <!-- / sports product category -->
                    <!-- start electronic product category -->
                    <div class="tab-pane fade" id="electronics">
                       <ul class="aa-product-catg">
             
                    
                        <!-- start single product item -->
                        <li>
                          <figure>
                            <a class="aa-product-img" href="#"><img src="img/electronics/electronic-8.png" alt="polo shirt img"></a>
                            <a class="aa-add-card-btn"href="#"><span class="fa fa-shopping-cart"></span>加入購物車</a>
                            <figcaption>
                              <h4 class="aa-product-title"><a href="#">刺客教條：維京紀元</a></h4>
                              <span class="aa-product-price">$45.50</span>
                            </figcaption>
                          </figure>                          
                          <div class="aa-product-hvr-content">
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Compare"><span class="fa fa-exchange"></span></a>
                            <a href="#" data-toggle2="tooltip" data-placement="top" title="Quick View" data-toggle="modal" data-target="#quick-view-modal"><span class="fa fa-search"></span></a>
                          </div>
                          <!-- product badge -->
                           <span class="aa-badge aa-sold-out" href="#">超熱門</span>
                        </li>                        
                      </ul>
                      <a class="aa-browse-btn" href="#">點我看更多 <span class="fa fa-long-arrow-right"></span></a>
                    </div>
                    <!-- / electronic product category -->
                  </div>
                  <!-- quick view modal -->                  
                  <div class="modal fade" id="quick-view-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                      <div class="modal-content">                      
                        <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                          <div class="row">
                            <!-- Modal view slider -->
                            <div class="col-md-6 col-sm-6 col-xs-12">                              
                              <div class="aa-product-view-slider">                                
                                <div class="simpleLens-gallery-container" id="demo-1">
                                  <div class="simpleLens-container">
                                      <div class="simpleLens-big-image-container">
                                          <a class="simpleLens-lens-image" data-lens-image="img/view-slider/large/polo-shirt-1.png">
                                              <img src="img\switcholed.jpg" class="simpleLens-big-image">
                                          </a>
                                      </div>
                                  </div>
                                  <div class="simpleLens-thumbnails-container">
                                      <a href="#" class="simpleLens-thumbnail-wrapper"
                                         data-lens-image="img\switcholed.jpg"
                                         data-big-image="img\switcholed.jpg">
                                          <!-- <img src="img\switcholed.jpg"> -->
                                      </a>                                    
                                      <a href="#" class="simpleLens-thumbnail-wrapper"
                                         data-lens-image="img/view-slider/large/polo-shirt-3.png"
                                         data-big-image="img/view-slider/medium/polo-shirt-3.png">
                                          <img src="img/view-slider/thumbnail/polo-shirt-3.png">
                                      </a>

                                      <a href="#" class="simpleLens-thumbnail-wrapper"
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
                                  <p class="aa-product-avilability">庫存狀態: <span>有現貨</span></p>
                                </div>
                                <p>最新OLED新機 紅藍色主機款<br>
                                  Switch熱門遊戲任選一款<br>
                                  送任天堂原廠飲料提袋+耀西捲線器<br>
                                  推薦(可選配)瑪利歐派對超級巨星 寶可夢鑽石珍珠<br>
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
                                  <a href="#" class="aa-add-to-cart-btn"><span class="fa fa-shopping-cart"></span>加入購物車</a>
                                  <a href="#" class="aa-add-to-cart-btn">點我看商品</a>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>                        
                      </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                  </div><!-- / quick view modal -->              
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- / Products section -->
  <!-- banner section -->
  <!-- <section id="aa-banner">
    <div class="container">
      <div class="row">
        <div class="col-md-12">        
          <div class="row">
            <div class="aa-banner-area">
            <a href="#"><img src="img/fashion-banner.jpg" alt="fashion banner img"></a>
          </div>
          </div>
        </div>
      </div>
    </div>
  </section> -->
  <!-- popular section -->
  <section id="aa-popular-category">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="row">
            <div class="aa-popular-category-area">
              <!-- start prduct navigation -->
             <ul class="nav nav-tabs aa-products-tab">
                <li class="active"><a href="#popular" data-toggle="tab">最新上架</a></li>
                <!-- <li><a href="#featured" data-toggle="tab">Featured</a></li>
                <li><a href="#latest" data-toggle="tab">Latest</a></li>                     -->
              </ul>
              <!-- Tab panes -->
              <div class="tab-content">
                <!-- Start men popular category -->
                <div class="tab-pane fade in active" id="popular">
                  <ul class="aa-product-catg aa-popular-slider">
                    <!-- start single product item -->
                        <c:forEach var = "prodVO" items="${prodSvc1.allByTimeDesc}" varStatus="loop">
                       
                        <c:if test="${loop.index<8 &&prodVO.prodStatus==1}">
                    <li>
                      <figure>
                         <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodVO.prodID}">
                            <img src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=${prodVO.prodID}" alt="polo shirt img"></a>
                            <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodVO.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                             <figcaption>
                              <h4 class="aa-product-title"><a >${prodVO.prodName}</a></h4>
                              <span class="aa-product-price">$${prodVO.prodRent }</span>
                        </figcaption>
                      </figure>                     
                      <div class="aa-product-hvr-content">
                        <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                        <a href="#" data-toggle="tooltip" data-placement="top" title="Compare"><span class="fa fa-exchange"></span></a>
                        <a href="#" data-toggle2="tooltip" data-placement="top" title="Quick View" data-toggle="modal" data-target="#quick-view-modal"><span class="fa fa-search"></span></a>                            
                      </div>
                      <!-- product badge -->
                      <span class="aa-badge aa-sale" href="#">新上架</span>
                    </li>
                     </c:if>
                     </c:forEach>                                                                     
                  </ul>
                      <a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/product/productPage.jsp">點我看更多 <span class="fa fa-long-arrow-right"></span></a>
                </div>
                <!-- / popular product category -->
                
                <!-- start featured product category -->
                <div class="tab-pane fade" id="featured">
                
                   <a class="aa-browse-btn" href="#">點我看更多 <span class="fa fa-long-arrow-right"></span></a>
                </div>
                <!-- / latest product category -->              
              </div>
            </div>
          </div> 
        </div>
      </div>
    </div>
  </section>
  <!-- / popular section -->
  <!-- Support section -->
  <section id="aa-support">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-support-area">
            <!-- single support -->
            <div class="col-md-4 col-sm-4 col-xs-12">
              <div class="aa-support-single">
                <span class="fa fa-gamepad"></span>
                <h4>想玩就租</h4>
                <P>還在想一套遊戲好貴買不下手嗎？</P>
              </div>
            </div>
            <!-- single support -->
            <div class="col-md-4 col-sm-4 col-xs-12">
              <div class="aa-support-single">
                <span class="fa fa-calendar-check-o"></span>
                <h4>想租多久就多久</h4>
                <P>自訂租借天數，愛玩幾天就玩幾天</P>
              </div>
            </div>
            <!-- single support -->
            <div class="col-md-4 col-sm-4 col-xs-12">
              <div class="aa-support-single">
                <span class="fa fa-puzzle-piece"></span>
                <h4>不想玩電玩？</h4>
                <P>不只Switch，JoyLease上百種商品任你租借，任你玩！</P>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>


  <!-- Latest Blog -->
  <section id="aa-latest-blog">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-latest-blog-area">
            <h2>我要徵求</h2>
            <div class="row">
              <!-- single latest blog -->
              <jsp:useBean id="pbSvc" scope="page" class="com.postboard.model.PostBoardService" />
	             <c:forEach var="pbVO" items="${pbSvc.all}" begin="0" end="2" varStatus="status">
                	<div class="col-md-4 col-sm-4">
		               <article class="aa-latest-blog-single">
		                  <figure class="aa-blog-img">                    
		                    <a href=""><img alt="" 
		                       src="<%=request.getContextPath()%>/back_end/PostBoard/pb.do?postId=${pbVO.postId}&action=writePic"></a>  
		                         <figcaption class="aa-blog-img-caption">
		                            <a href="#"><i class="fa fa-comment-o"></i>${pbVO.replyCount}</a>
		                            	<span href="#"><i class="fa fa-clock-o"></i>${pbVO.postTime}</span>
		                         </figcaption>                          
		                  </figure>
		
		                        	<div class="aa-blog-info">
		                          	<h3 class="aa-blog-title"><a href="#">${pbVO.postTitle}</a></h3>
		                          	<p>${pbVO.postCont}</p> 
		                          	<a class="aa-read-mor-btn" 
		                          	   href="<%=request.getContextPath()%>/back_end/PostBoard/postSingle.jsp?postId=${pbVO.postId}">
		                          	       全文閱讀 <span class="fa fa-long-arrow-right"></span></a>
	                        		</div>
	                           </article>
	                          </div>
	                           
	            </c:forEach>               
              </div>
	        </div>

  </section>
 

  <!-- footer -->  
 <%@ include file="/includeFolder/footer2.file"%>








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