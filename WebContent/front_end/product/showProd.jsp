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

<title>JoyLease | Product_view</title>
<%@ include file="/includeFolder/header.file"%>
   

 <% Integer picAmount = (Integer)request.getAttribute("picAmount");   
  Integer prodID = (Integer)request.getAttribute("prodID");
 ProdVO product = (ProdVO)request.getAttribute("product");
	System.out.println("id" + prodID); 
	System.out.println("picAmount: " + picAmount); 
	System.out.println("product" + product); 
 %> 




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

							        <% 
											String comt = (product.getComt() == null) ? "" : product.getComt();
											
                                        List<String> labelList = jedis.lrange("prod"+product.getProdID(), 0, jedis.llen("prod"+product.getProdID()));
                                     	pageContext.setAttribute("labelList", labelList);
                                     	System.out.print("數量  "+  labelList.size());
                          
										
										%>
	

								<!-- Modal view content -->
								<div class="col-md-7 col-sm-7 col-xs-12">
									<div class="aa-product-view-content">
					
									
										<h3>${product.prodName}</h3>
										<div class="aa-price-block">
										<ul>
											租金:<li><span class="aa-product-view-price">$${product.prodRent}</span></li><br>
											商品損壞賠償金: <li><span class="aa-product-avilability">$${product.prodPrice}</span></li><br>
										
									
										備註: <li><span>${empty product.comt ? '' : product.comt}</span></li><br>
										
											<li>
											標籤:&nbsp
											<c:forEach var="label" items="${labelList}" varStatus="loop">
													<c:if test="${loop.index!=0 and loop.index % 5 ==0}">
													<br>
													</c:if>
													<a href="<%=path%>/prod/ProdServlet?action=labelClick&prodID=<%=product.getProdID()%>&labelNo=${loop.index}"><span style="color:#A6A600">#${label}</span></a>&nbsp
											</c:forEach>
										</li>
										
										
										
										</div>
										
										
										
											</ul>
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
					<input type ="hidden" name ="prodStatus" value="<%=product.getProdStatus()%>">
					<input type ="hidden"  name ="status" value="shelf">
					<input type="hidden" name="action" value="update">
					<input type ="hidden" name = "categorySelect" value=<%=product.getCategoryID()%>>
					
				</form>
				




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


	<script>
	
		$("#shelf_btn").click(function(){
			 
			console.log("123");
			
			$("#shelf_form").submit();
			return false;
		});
	
	</script>
	

</body>
</html>