<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		
<!DOCTYPE html>
<html lang="en">
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
  <head>  
<title>JoyLease | upload</title>
 <%@ include file="/includeFolder/header.file"%>

<%session.setAttribute("id",1); 


%>
 

	

	<!-- Cart view section -->
	<section id="aa-myaccount">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="aa-myaccount-area">
						<div class="row">
							<div class="col-md-6">
								<div class="aa-myaccount-login">
									<h4>商品上架</h4>
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
											placeholder="請商品名稱" value =""> <label for="">商品類別<span>*</span></label>
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
											type="text" placeholder="請輸入商品租金" name="product_rent" id="product_rent" value="${param.ProdID}"> <label for="">商品損壞賠償金<span>*</span></label>
										<input type="text" placeholder="請輸入商品損壞賠償金" name="product_price" id="product_price" value=""> <label
											for="">備註<span></span></label>
											 <input type="text" placeholder="請輸入備註" name="comt" id="comt" value=""> <label for="">商品內容<span>*</span></label>
										<input type="text" style="height: 150px;" name="product_cot" value="">
										<input
			type=hidden id="fileCount" name="fileCount"><br> <input
			type="hidden" name="action" value="upload">
										<button type="submit" class="aa-browse-btn" id="submit1" >建立商品</button>
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
								}
								reader.readAsDataURL(this.files[i]);
							}
						}
					}

				});
	</script>
</body>
</html>