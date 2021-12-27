<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
		
<!DOCTYPE html>
<html lang="en">
  <head>
   <style>
       .aa-product-img img {
  object-fit: contain;
  width: 250px;
  height: 300px;
}</style> 
  <body> 
   <%
   
   response.setHeader("Cache-Control","no-store"); 
   response.setHeader("Pragma","no-cache");        
   response.setDateHeader ("Expires", 0);
   

   
   %>
 <%@ include file="/includeFolder/header.file"%>
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
                  
                  
                  
                  
                  <select name="prodSelect" class="aa-select" value="">
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
                    <input type="hidden" name = "cateNo" value="<c:out value="${cateNo}"/>">
					
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
              <jsp:useBean id="prodSvc1" scope="page" class="com.product.model.ProdService" />
              <div class="aa-product-catg-head-right">
              
                現在分類:<label style="color: orange; font-size:20px;">${empty categoryName ? '所有分類' : categoryName}</label>
                <a id="grid-catg" href="#"><span class="fa fa-th"></span></a>
                <a id="list-catg" href="#"><span class="fa fa-list"></span></a>
              </div>
            </div>
            <div class="aa-product-catg-body">
<!--             如果搜尋陣列長度為0代表 搜尋不到物品 印出查無-->
            <c:if test= "${fn:length(listSearch)==0 and listSearch!=null}">
                	<label style="color:blue; font-size:20px;">"${searchCot}" </label><label style=" font-size:20px;">查無結果</label>
                	</c:if>
            <c:if test= "${fn:length(listSearch)>0 and listSearch!=null}">
                	<label style=" font-size:20px;">目前搜尋:</label><label style="color:blue	; font-size:20px;">"${searchCot}"  </label>
                	</c:if>
                	
                	
                   <c:if test= "${flag=='no'}">
                	<label style="color:#FF359A; font-size:20px;">"${prodLabel}" </label><label style=" font-size:20px;">查無結果</label>
                	</c:if>
            <c:if test= "${flag=='yes'}">
            		<label style=" font-size:20px;">目前標籤:</label>
                	<label style="color:	#FF359A	; font-size:20px;">"${prodLabel}"  </label>
                	
                	</c:if>
                	
                	
                	
              <ul class="aa-product-catg">
                <!-- start single product item -->
               
<!--                 /遞增排列 -->
                <c:if test="${'asc'==flag}">
                			
                	<c:forEach var="prodEL" items="${listSearch==null ?prodList : listSearch}">
<!--                 		假如狀態為1代表上架 如果沒有選擇類別 則按照原來執行 如果有 按照類別執行 -->
					    <c:if test="${prodEL.prodStatus==1 and (empty cateNo ? true :  cateNo==prodEL.categoryID)}">
					   
					    <li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?prodID=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?prodID=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#">${prodEL.prodName}</a></h4>
                      <span class="aa-product-price">$${prodEL.prodRent}</span><br>
                       上架時間:&nbsp
                       <span class="aa-product-date" style="color:green"><fmt:formatDate value="${prodEL.shelfDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                  
                <c:forEach var="prodCount" items="${prodSvc1.countGroupbyProdID }" varStatus="loop2">
                  	
  					 <c:if test="${loop2.index==0 and prodCount.key==prodEL.prodID}">
                           <span style="background-color:yellow;box-shadow:0px 0px 15px red;color:red"class="aa-badge aa-sale" href="#">天下第一租</span>
                           </c:if>
                           <c:if test="${loop2.index==1 and prodCount.key==prodEL.prodID}">
                         <span style="background-color:	#00AEAE; box-shadow:0px 0px 15px yellow;color:white" class="aa-badge aa-sale" href="#">天下第二租</span>
                           </c:if>
                           <c:if test="${loop2.index==2 and prodCount.key==prodEL.prodID}">
                         <span	style="background-color:#F75000; box-shadow:0px 0px 15px yellow; color:white"  class="aa-badge aa-sale" href="#">天下第三租</span>
                           </c:if>
                	</c:forEach>
                </li>	
					 </c:if>	
			</c:forEach>
                 </c:if>	
                 
                 
<!--                  	/遞減排列 -->
                 	<c:if test="${'desc'==flag}">
                	<c:forEach var="prodEL" items="${listSearch==null ?prodList : listSearch}">
        
					    <c:if test="${prodEL.prodStatus==1 and (empty cateNo ? true :  cateNo==prodEL.categoryID)}">
					    <li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?prodID=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?prodID=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#">${prodEL.prodName}</a></h4>
                      <span class="aa-product-price">$${prodEL.prodRent}</span><br>
                       上架時間:&nbsp
                       <span class="aa-product-date" style="color:green"><fmt:formatDate value="${prodEL.shelfDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                <c:forEach var="prodCount" items="${prodSvc1.countGroupbyProdID }" varStatus="loop2">
                  	
  					 <c:if test="${loop2.index==0 and prodCount.key==prodEL.prodID}">
                           <span style="background-color:yellow;box-shadow:0px 0px 15px red;color:red"class="aa-badge aa-sale" href="#">天下第一租</span>
                           </c:if>
                           <c:if test="${loop2.index==1 and prodCount.key==prodEL.prodID}">
                         <span style="background-color:	#00AEAE; box-shadow:0px 0px 15px yellow;color:white" class="aa-badge aa-sale" href="#">天下第二租</span>
                           </c:if>
                           <c:if test="${loop2.index==2 and prodCount.key==prodEL.prodID}">
                         <span	style="background-color:#F75000; box-shadow:0px 0px 15px yellow; color:white"  class="aa-badge aa-sale" href="#">天下第三租</span>
                           </c:if>
                	</c:forEach>
                </li>	
					 </c:if>	
			</c:forEach>
                 </c:if>
                 
                 
                 
                 
                 
<!--                  //標籤排列 -->

<c:if test="${matchProdList!=null}">

                	<c:forEach var="prodEL" items="${matchProdList==null ?prodList : matchProdList}">
        
					    <c:if test="${prodEL.prodStatus==1 and (empty cateNo ? true :  cateNo==prodEL.categoryID)}">
					    <li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?prodID=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?prodID=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#">${prodEL.prodName}</a></h4>
                      <span class="aa-product-price">$${prodEL.prodRent}</span><br>
                        上架時間:&nbsp
                       <span class="aa-product-date" style="color:green"><fmt:formatDate value="${prodEL.shelfDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                     <c:forEach var="prodCount" items="${prodSvc1.countGroupbyProdID }" varStatus="loop2">
                  	
  					 <c:if test="${loop2.index==0 and prodCount.key==prodEL.prodID}">
                           <span style="background-color:yellow;box-shadow:0px 0px 15px red;color:red"class="aa-badge aa-sale" href="#">天下第一租</span>
                           </c:if>
                           <c:if test="${loop2.index==1 and prodCount.key==prodEL.prodID}">
                         <span style="background-color:	#00AEAE; box-shadow:0px 0px 15px yellow;color:white" class="aa-badge aa-sale" href="#">天下第二租</span>
                           </c:if>
                           <c:if test="${loop2.index==2 and prodCount.key==prodEL.prodID}">
                         <span	style="background-color:#F75000; box-shadow:0px 0px 15px yellow; color:white"  class="aa-badge aa-sale" href="#">天下第三租</span>
                           </c:if>
                	</c:forEach>
                </li>	
					 </c:if>	
			</c:forEach>
                 </c:if>

                 
                 
                 
                 
                 	
<c:if test="${matchProdList==null}">           	
<!--                  上架時間排列(新至舊) -->
	<c:if test="${empty flag or flag=='time'}">
	
                	
                	<c:forEach var="prodEL" items="${listSearch==null ? prodSvc1.allByTimeDesc : listSearch}" varStatus="loop">
                	<c:if test="${prodEL.prodStatus==1 and (empty cateNo ? true :  cateNo==prodEL.categoryID)}">
                	<c:if test="${loop.index <12 and (empty param.page or param.page==1)}">
                	<li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?prodID=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#">${prodEL.prodName}</a></h4>
                      <span class="aa-product-price">$${prodEL.prodRent}</span><br>
                       上架時間:&nbsp
                       <span class="aa-product-date" style="color:green"><fmt:formatDate value="${prodEL.shelfDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                  <c:if test="${loop.index <=5}">
                    <span  class="aa-badge aa-sale" href="#">新上架</span>
                  </c:if>
          <c:forEach var="prodCount" items="${prodSvc1.countGroupbyProdID }" varStatus="loop2">
                  
  					 <c:if test="${loop2.index==0 and prodCount.key==prodEL.prodID}">
                           <span style="background-color:yellow;box-shadow:0px 0px 15px red;color:red"class="aa-badge aa-sale" href="#">天下第一租</span>
                           </c:if>
                           <c:if test="${loop2.index==1 and prodCount.key==prodEL.prodID}">
                         <span style="background-color:	#00AEAE; box-shadow:0px 0px 15px yellow;color:white" class="aa-badge aa-sale" href="#">天下第二租</span>
                           </c:if>
                           <c:if test="${loop2.index==2 and prodCount.key==prodEL.prodID}">
                         <span	style="background-color:#F75000; box-shadow:0px 0px 15px yellow; color:white"  class="aa-badge aa-sale" href="#">天下第三租</span>
                           </c:if>
                	</c:forEach>
                              
                    
                    
                    
                </li>
  			</c:if>
  				<c:if test="${loop.index >=12 and loop.index<24 and param.page==2}">
  			<li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?prodID=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#">${prodEL.prodName}</a></h4>
                      <span class="aa-product-price">$${prodEL.prodRent}</span><br>
                     上架時間:&nbsp
                       <span class="aa-product-date" style="color:green"><fmt:formatDate value="${prodEL.shelfDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                 <c:forEach var="prodCount" items="${prodSvc1.countGroupbyProdID }" varStatus="loop2">
                  	
  					 <c:if test="${loop2.index==0 and prodCount.key==prodEL.prodID}">
                           <span style="background-color:yellow;box-shadow:0px 0px 15px red;color:red"class="aa-badge aa-sale" href="#">天下第一租</span>
                           </c:if>
                           <c:if test="${loop2.index==1 and prodCount.key==prodEL.prodID}">
                         <span style="background-color:	#00AEAE; box-shadow:0px 0px 15px yellow;color:white" class="aa-badge aa-sale" href="#">天下第二租</span>
                           </c:if>
                           <c:if test="${loop2.index==2 and prodCount.key==prodEL.prodID}">
                         <span	style="background-color:#F75000; box-shadow:0px 0px 15px yellow; color:white"  class="aa-badge aa-sale" href="#">天下第三租</span>
                           </c:if>
                	</c:forEach>
                    
                    
                </li>
  			
  			</c:if>
  			
  			
  			<c:if test="${loop.index >=24 and loop.index<=36 and param.page==3}">
  			<li>
                  <figure>
                    <a class="aa-product-img" href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}">
                    <img src="<%=path%>/prod/ProdServlet?prodID=${prodEL.prodID}&no=1&action=detail"></a>
                    <a class="aa-add-card-btn"href="<%=path%>/front_end/product/prodDetail.jsp?cookie=y&prodID=${prodEL.prodID}"><span class="fa fa-shopping-cart"></span>看商品細圖</a>
                    <figcaption>
                      <h4 class="aa-product-title"><a href="#">${prodEL.prodName}</a></h4>
                      <br><span class="aa-product-price">$${prodEL.prodRent}</span><br>
                        上架時間:&nbsp
                       <span class="aa-product-date" style="color:green"><fmt:formatDate value="${prodEL.shelfDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </figcaption>
                  </figure>                         
                  <div class="aa-product-hvr-content">
                    <a href="#" data-toggle="tooltip" data-placement="top" title="Add to Wishlist"><span class="fa fa-heart-o"></span></a>
                  </div>
                
                     <c:forEach var="prodCount" items="${prodSvc1.countGroupbyProdID }" varStatus="loop2">
                  
  					 <c:if test="${loop2.index==0 and prodCount.key==prodEL.prodID}">
                           <span style="background-color:yellow;box-shadow:0px 0px 15px red;color:red"class="aa-badge aa-sale" href="#">天下第一租</span>
                           </c:if>
                           <c:if test="${loop2.index==1 and prodCount.key==prodEL.prodID}">
                         <span style="background-color:	#00AEAE; box-shadow:0px 0px 15px yellow;color:white" class="aa-badge aa-sale" href="#">天下第二租</span>
                           </c:if>
                           <c:if test="${loop2.index==2 and prodCount.key==prodEL.prodID}">
                         <span	style="background-color:#F75000;box-shadow:0px 0px 15px yellow; color:white"  class="aa-badge aa-sale" href="#">天下第三租</span>
                           </c:if>
                	</c:forEach>
                    
                </li>
  			
  			</c:if>
  			
  			
  			
  			
  			
  			
  			
  			
  			
                	</c:if>
		</c:forEach>
	
		</c:if>
        </c:if>
                 
                    
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
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&prodSelect=<c:out value="${prodSelect}"/>">所有商品</a></li>
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=1&prodSelect=<c:out value="${prodSelect}"/>">Nintendo</a></li>
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=2&prodSelect=<c:out value="${prodSelect}"/>">PlayStation</a></li>
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=3&prodSelect=<c:out value="${prodSelect}"/>">XBOX</a></li>
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=4&prodSelect=<c:out value="${prodSelect}"/>">其他遊戲主機</a></li>                                                
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=5&prodSelect=<c:out value="${prodSelect}"/>">電腦遊戲</a></li>
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=6&prodSelect=<c:out value="${prodSelect}"/>">桌遊</a></li>
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=7&prodSelect=<c:out value="${prodSelect}"/>">拼圖</a></li>
                <li><a href="/TFA104G1/prod/ProdServlet?action=select&cateNo=8&prodSelect=<c:out value="${prodSelect}"/>">其他</a></li>
              </ul>
            </div>
            <!-- single sidebar -->
            <div class="aa-sidebar-widget">
              <h3>關鍵字標籤</h3>
              <div class="tag-cloud">
             
              </div>
           
           
            <div class="">
              <h3>地圖搜尋商品</h3>
                         <a href="/TFA104G1/front_end/letswrite-google-map-api-5-master/mapProdSearch.jsp"><img style="width:60px" src="https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/google-maps-%E5%A4%96%E9%80%81-%E6%96%B0%E5%8A%9F%E8%83%BD-1586248853.jpg?crop=0.488xw:0.974xh;0.259xw,0&resize=640:*"></a>
   
              </div>
           
           
            
            <div class="aa-sidebar-widget">
              <h3>最近瀏覽</h3>
              <div class="aa-recently-views">
                <ul>
                
                <c:if test="${not empty listCookie}">
                <c:forEach var="prodCookie" items="${listCookie}">
                
                  <li>
                    <a href="<%=path%>/front_end/product/prodDetail.jsp?prodID=${prodCookie.prodID}" class="aa-cartbox-img"><img alt="img" src="<%=path%>/prod/ProdServlet?action=detail&prodID=${prodCookie.prodID}&no=1"></a>
                    
                    <div class="aa-cartbox-info">
                      <p>${prodCookie.prodName}</p>
                      
                      <p>$${prodCookie.prodRent}</p>
                    </div>                    
                  </li>
              
                   </c:forEach>   
                   </c:if>                           
                </ul>
              </div>                            
            </div>
            <!-- single sidebar -->
     
          </aside>
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

$("select.aa-select").change(function(){
	$("form.aa-sort-form").submit();
}) ; 

//動態隨機加入標籤
$.ajax({
	type:"post",
	contentType:"application/x-www-form-urlencoded;charset=utf-8",
	url:"/TFA104G1/prod/LabelServlet?action=showLabel",
	dataType:"json",
	cache:false,
	success:function(data){
		console.log(data.all_label.length);
		for(var i =0;i<data.all_label.length&&i<=8;i++){
			$('div.tag-cloud').append("<a href='<%=path%>/prod/LabelServlet?action=labelClick&labelName=" + data.all_label[i] + "'>" +data.all_label[i] + "</a>")
		}
// 		$('div.tag-cloud').append()
		
	},
	error:function(){
		console.log("失敗");
	}
});



</script>
  </body>
</html>