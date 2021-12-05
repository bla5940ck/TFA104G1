<%@page import="redis.clients.jedis.Jedis"%>
<%@page import="redis.clients.jedis.JedisPool"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.product.model.*"%>
<%@page import="com.product.jedis.JedisPoolUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <style>
  a.cart-img > img{
	object-fit: contain;
	width: 185px;
	height: 140px;
}
 </style>
<head>

    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>JoyLease | Cart</title>
    
   	<%@ include file="/includeFolder/header.file"%>
   

  



<%
;
// List<Integer> leaseList = new ArrayList();
Set<Integer> leaseSet  =new HashSet();
List<CartVO> checkoutList = new ArrayList();
CartVO checkoutCart = new CartVO();

for(String cartStr :cart){
	
	leaseSet.add(gson.fromJson(cartStr, CartVO.class).getLeaseID());
}

pageContext.setAttribute("leaseSet", leaseSet);
int total=0;
int index=0;
int checkbox=0;
CartVO cartVO1=null;

%>



 <!-- Cart view section -->
 	<c:if test="${not empty errorMsgs}">
 
<font style="color:red"> </font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red; font-size:30px;">${message}!!!</li>
		</c:forEach>
	</ul> 
</c:if>
 <section id="cart-view">
   <div class="container">
     <div class="row">
       <div class="col-md-12">
         <div class="cart-view-area">
           <div class="cart-view-table">
             <form id ="cart-form" action="<%=path %>/prod/ProdServlet?action=checkout" method = "post">
             
             
     	
<!--      		不重複的會員(出租) 找有多少商品 -->
             
              <%for(Integer leaseID :leaseSet){
            	  //會員總數量
            	  index++ ; 
              %>
              <div id="lease-div">
           	<label class="cart-lable" style="color:Navy; font-size:30px; border-color:blue; border-style:dotted;">賣場編號: shop1000<%=leaseID%> </label>
           
               <div class="table-responsive">
                  <table class="table">
                  
                    <thead>
                    
                      <tr>
                        <th>選取商品</th> 
                        <th>商品圖片</th>
                        <th>商品名稱</th>
                        <th>租金</th>
                        <th>預計租借日</th>
                        <th>預計歸還日</th>
                        <th>總計</th>
                         <th>刪除商品</th>
                      </tr>
                    </thead>
                    <tbody>
 
                  
                    <% 
                    int leaseProd=0;
                    for(String item : cart) {
                    	
                    	cartVO1 = gson.fromJson(item, CartVO.class);
                    	request.setAttribute("cartVO1",cartVO1);
                    	if(cartVO1.getLeaseID()==leaseID ){
                    		
                    		//出租者商品數量
                    		leaseProd++;
                    		//商品總數量
                    		checkbox++;
                    	
                    		
                    	%>
                    	
                    	
                      <tr>
                      	<input  type="hidden" value="<%=cartVO1.getProdID()%>">
                      	<input  type="hidden" value="<%=cartVO1.getTotalPrice()%>">
<%--                       	<c:if test="${cartVO1.prodID == param.prodID}"> --%>
<%--                       	<td><input class="cart-checkbox" checked="checked" name="cartCheckbox" type="checkbox" value="<%=cartVO1.getProdID()%>" style= "width:25px;height:25px;"></td> --%>
<%--                         </c:if> --%>
<%--                         <c:if test="${cartVO1.prodID != param.prodID}"> --%>
                        <td><input class="cart-checkbox" name="cartCheckbox" type="checkbox" value="<%=cartVO1.getProdID()%>" style= "width:25px;height:25px;"></td>
<%--                         </c:if> --%>
                        <td><a class="cart-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=<%=cartVO1.getProdID()%>"><img src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=<%=cartVO1.getProdID()%>" alt="img"></a></td>
                        <td><a class="aa-cart-title" href="#"><%=cartVO1.getProdName() %></a></td>
                        <td><%=cartVO1.getRent() %></td>
                        <td><%=cartVO1.getEstStart()%></td>
                         <td><%=cartVO1.getEstEnd()%></td>
                        <td><%=cartVO1.getTotalPrice()%></td>
                       	
                        <td><a class="remove" ><fa class="fa fa-close"></fa></a></td>
                      	
                      </tr>
                     
                         <%
						
			
                    } }
                         
                         %>
                 
                  
                      <tr>
                    	<input class = "leaseProd" type = "hidden" value="<%=leaseProd %>">
                    	
                      </tr>
                         &nbsp;&nbsp;&nbsp;&nbsp;共 <label id="prodCount_label" style="color:green;"><%=leaseProd %></label> 件商品
                      </tbody>
                  </table>
                </div>
                </div>
            <%} %>   
                
                    <td colspan="6" class="aa-cart-view-bottom">
                          <input class="aa-cart-view-btn" type="button" value="更新購物車">
                        </td>
                
                
                
                
                
                
                
                
                
             </form>
             <!-- Cart Total view -->
             <div class="cart-view-total">
               <h4>購物車結帳金額</h4>
               <table class="aa-totals-table">
                 <tbody>
                   <tr>
                     <th>已選擇的商品</th>
                     <td id="prod-select"></td>
                   </tr>
                   <tr>
                     <th>小計</th>
                     <td id="td-total"></td>
                     </tr>
                   
                 </tbody>
               </table>
               <c:if test="${not empty cartVO1}">
               <a href="#" class="aa-cart-view-btn" >購物車結帳</a>
            	</c:if>
             </div>
           </div>
         </div>
       </div>
     </div>
   </div>
 </section>


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
  <script src="<%=request.getContextPath()%>/front_end/product/js/bootstrap.js"></script>  
  <!-- SmartMenus jQuery plugin -->
  <script type="text/javascript" src="<%=request.getContextPath()%>/front_end/product/js/jquery.smartmenus.js"></script>
  <!-- SmartMenus jQuery Bootstrap Addon -->
  <script type="text/javascript" src="<%=request.getContextPath()%>/front_end/product/js/jquery.smartmenus.bootstrap.js"></script>  
  <!-- To Slider JS -->
  <script src="<%=request.getContextPath()%>/front_end/product/js/sequence.js"></script>
<!--   <script src="js/sequence-theme.modern-slide-in.js"></script>   -->
  <!-- Product view slider -->
  <script type="text/javascript" src="<%=request.getContextPath()%>/front_end/product/js/jquery.simpleGallery.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/front_end/product/js/jquery.simpleLens.js"></script>
  <!-- slick slider -->
  <script type="text/javascript" src="<%=request.getContextPath()%>/front_end/product/js/slick.js"></script>
  <!-- Price picker slider -->
  <script type="text/javascript" src="<%=request.getContextPath()%>/front_end/product/js/nouislider.js"></script>
  <!-- Custom js -->
  <script src="<%=request.getContextPath()%>/front_end/product/js/custom.js"></script> 


<script>


//刪除購物車

$("a.remove").click(function(){
    
	  let r = confirm("確認移除？");
  
  let that = this;
 
  let prodid = $(that).closest("tr").find("input").eq(0).val();
  
	  if (r){
		 
  		
	    $.ajax({
	      url: "<%=request.getContextPath()%>/prod/ProdServlet",           // 資料請求的網址
	      type: "POST",                
	      data: {
	    	  prodID: prodid,
	    	  action: "delete",
	    	  index :<%=checkbox%>
	      },                  // 傳送資料到指定的 url
	      beforeSend: function(){       // 在 request 發送之前執行
	      }  
	    	  ,success: function(data){ 
	    		  $("table.aa-totals-table").load(
location.href + " table.aa-totals-table");
	    	//小購物車顯示數量-1	 
	    $("span.aa-cart-notify").text($("span.aa-cart-notify").text()-1);
	  
	    var leaseProd = $(that).closest('tbody').find('tr:last').find('input').val();
	   leaseProd = $(that).closest('tbody').find('tr:last').find('input').val(leaseProd-1);
	   console.log($(that).closest('tbody').find('tr:last').find('input').val());
	   $("div.aa-cartbox-summary").load(location.href + " div.aa-cartbox-summary");
	   
	   //大購物車 數量-1
	  $(that).closest("div.table-responsive").find('label').eq(0).text($(that).closest("div.table-responsive").find('label').eq(0).text()-1);
	    //假如出租者在購物車商品刪到剩下0個 那麼整個欄位包含賣家資訊也要刪除
	   if($(that).closest('tbody').find('tr:last').find('input').val()==0){
	    	console.log("此出租者全部沒商品");
	    	$(that).closest("#lease-div").animate({
	    	          "opacity": 0
	    	        }, 1000, "swing", function(){
	    	        	$(this).remove(); 
	    	        	
	    	        });
	    	
	    	
	    }else{
	    	
	    	console.log("執行2")
	    	   $(that).closest("tr").animate({
	    	          "opacity": 0
	    	        }, 1000, "swing", function(){
	    	        	$(this).remove();

	    	        });
	    	
	    }
	    
// 	    console.log($(that).closest("#lease-div"));
//       	console.log($(that).closest('div').find('input').eq(0).val())
        	
//         	<input class = "leaseProd
	    
	 
       
      }

    });
    }

  });
  
  
  //選單計算

var total =0;
var prodSelect=0;







$("input.cart-checkbox").click(function(){
    var isChecked = $(this).is(":checked");
    console.log( $(this));
    //被選到的計算總金額
    if($(this).is(":checked")){
    	
    	$("#prod-select").text(++prodSelect);
   let prodID = $(this).closest("tr").find("input").eq(0);
  total +=  parseInt($(this).closest("tr").find("input").eq(1).val());
    	$("#td-total").text(total);
    }else{
    	//沒被選到的扣掉金額
    	total -=  parseInt($(this).closest("tr").find("input").eq(1).val());
    	$("#td-total").text(total);
    	$("#prod-select").text(--prodSelect);

    }
  
  });
  
  
  
  

  
  $("a.aa-cart-view-btn").click(function(){
	 
	  $("#cart-form").submit();
  });
  
  
//   $("input.cart-checkbox")
  
  $("input.aa-cart-view-btn").click(function(){
	  history.go(0);
  });
  
  
window.onload = function () {
	
	

}
	

  </script> 
 
  </body>
 
</html>