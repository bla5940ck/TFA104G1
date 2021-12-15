<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.postboard.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<style>	
	
</style>


<body>
<%@ include file="header.file" %>

<%
	PostBoardVO pbVO = (PostBoardVO) request.getAttribute("pbVO");
%>
<body>

<!-- Blog Archive -->
  <section id="aa-blog-archive">
    <div class="container">
      <div class="row" >
        <div class="col-md-12" >
          <div class="aa-blog-archive-area aa-blog-archive-2" >
            <div class="row">
              <div class="col-md-9">
                <div class="aa-blog-content">
                  <div class="row">
	                    <jsp:useBean id="pbSvc" scope="page" class="com.postboard.model.PostBoardService" />
	                    	<c:forEach var="pbVO" items="${pbSvc.all}" varStatus="status">
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
                
                <!-- Blog Pagination -->
                <div class="aa-blog-archive-pagination">
                  <nav>
                    <ul class="pagination">
                      <li>
                        <a aria-label="Previous" href="#">
                          <span aria-hidden="true">«</span>
                        </a>
                      </li>
                      <li class="active"><a href="#">1</a></li>
                      <li><a href="#">2</a></li>
                      <li><a href="#">3</a></li>
                      <li><a href="#">4</a></li>
                      <li><a href="#">5</a></li>
                      <li>
                        <a aria-label="Next" href="#">
                          <span aria-hidden="true">»</span>
                        </a>
                      </li>
                    </ul>
                  </nav>
                </div>
              </div>
              <div class="col-md-3">
                <aside class="aa-blog-sidebar">
                  <div class="aa-sidebar-widget">
                    <h3>全部分類</h3>
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
                  <div class="aa-sidebar-widget">
                  	<div class="aa-search-box">
                		<form action="">
                  			<input type="text" name="" 
                  				   action="<%=request.getContextPath()%>/back_end/PostBoard/postAll.jsp" 
                  				   size="25" placeholder="健身環大冒險" style= color= >
                  				<button type="submit"><span class="fa fa-search"></span></button>
                		</form>
              	  </div>
                  
                  
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
                  </div>
                  <div class="aa-sidebar-widget">
                    <h3>最新文章</h3>
                    <div class="aa-recently-views">
                      <ul>
                        <li>
                          <a class="aa-cartbox-img" href="#"><img src="img/woman-small-2.jpg" alt="img"></a>
                          <div class="aa-cartbox-info">
                            <h4><a href="#">徵求PS5一台</a></h4>
                            <p>March 26th 2016</p>
                          </div>                    
                        </li>
                        <li>
                          <a class="aa-cartbox-img" href="#"><img src="img/woman-small-1.jpg" alt="img"></a>
                          <div class="aa-cartbox-info">
                            <h4><a href="#">動物森友會</a></h4>
                            <p>March 26th 2016</p>
                          </div>                    
                        </li>
                         <li>
                          <a class="aa-cartbox-img" href="#"><img src="img/woman-small-2.jpg" alt="img"></a>
                          <div class="aa-cartbox-info">
                            <h4><a href="#">健身環大冒險</a></h4>
                            <p>March 26th 2016</p>
                          </div>                    
                        </li>                                      
                      </ul>
                    </div>                            
                  </div>
                </aside>
              </div>
            </div>
           
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- / Blog Archive -->

</body>
<%@ include file="footer.file" %>
</html>