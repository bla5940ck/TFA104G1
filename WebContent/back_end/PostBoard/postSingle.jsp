<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="com.pbreply.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>

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
	PostBoardService pbSvc = new PostBoardService();
	PostBoardVO  pb = pbSvc.findByPrimaryKey(Integer.valueOf(request.getParameter("postId")));
	pageContext.setAttribute("pb",pb );
	
	pbReplyVO pbrVO = (pbReplyVO) request.getAttribute("pbrVO");
	pbReplyService pbrSvc = new pbReplyService();
	
%>

 <section id="aa-blog-archive">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-blog-archive-area">
            <div class="row">
              <div class="col-md-9">
                <!-- Blog details -->
                <div class="aa-blog-content aa-blog-details">
                  <article class="aa-blog-content-single">                        
                    <h2><a href="#" >${pb.postTitle}</a></h2>
                     <div class="aa-article-bottom">
                      <div class="aa-post-author">Posted By <a href="#">${pb.memberId}</a></div>
                      <div class="aa-post-date">${pb.postTime}</div>
                     </div>
                    <figure class="aa-blog-img">
                      <a href="#"><img 
                      	 src="<%=request.getContextPath()%>/back_end/PostBoard/pb.do?postId=${pbVO.postId}&action=writePic"/></a>
                    </figure>
                    <p>${pb.postCont}</p>
                   
                    <div class="blog-single-bottom">
                      <div class="row">
                        <div class="col-md-8 col-sm-6 col-xs-12">
                          <div class="blog-single-tag">
                            <span></span>
                            <a href="#"></a>
                            <a href="#"></a>
                            <a href="#"></a>
                          </div>
                        </div>
                        <div class="col-md-4 col-sm-6 col-xs-12">
<!--                           <div class="blog-single-social"> -->
<!--                             <a href="#"><i class="fa fa-facebook"></i></a> -->
<!--                             <a href="#"><i class="fa fa-twitter"></i></a> -->
<!--                             <a href="#"><i class="fa fa-linkedin"></i></a> -->
<!--                             <a href="#"><i class="fa fa-google-plus"></i></a> -->
<!--                             <a href="#"><i class="fa fa-pinterest"></i></a> -->
<!--                           </div> -->
                        </div>
                      </div>
                    </div>
                   
                  </article>
                  <!-- blog navigation -->
                  <div class="aa-blog-navigation">
                    <a class="aa-blog-prev" href="#"><span class="fa fa-arrow-left"></span>上一篇</a>
                    <a class="aa-blog-next" href="#">下一篇<span class="fa fa-arrow-right"></span></a>
                  </div>
                  <!-- Blog Comment threats -->
                  <div class="aa-blog-comment-threat">
                    <h3>留言 ( ${pbVo.replyCount} )</h3>
                    <div class="comments">
                      <ul class="commentlist">
                        <li>
                          <div class="media">
                            <div class="media-left">    
                                <img class="media-object news-img" src="img/testimonial-img-3.jpg" alt="img">      
                            </div>
                            <div class="media-body">
                             <h4 class="author-name">${pbrVO.memberId}</h4>
                             <span class="comments-date"></span>
                             <p>${pbrVO.replyCont}</p>
<!--                              <a href="#" class="reply-btn">回覆留言</a> -->
                            </div>
                          </div>
                        </li>
                        
                        
                        <li>
                          <div class="media">
                            <div class="media-left">    
                                <img class="media-object news-img" src="img/testimonial-img-2.jpg" alt="img">      
                            </div>
                            <div class="media-body">
                             <h4 class="author-name">Charlie Balley</h4>
                             <span class="comments-date"> March 26th 2016</span>
                             <p></p>
<!--                              <a href="#" class="reply-btn">回覆留言</a> -->
                            </div>
                          </div>
                        </li>
                        
                        
<!--                         <ul class="children"> -->
<!--                           <li class="author-comments"> -->
<!--                             <div class="media"> -->
<!--                               <div class="media-left">     -->
<!--                                   <img class="media-object news-img" src="img/testimonial-img-3.jpg" alt="img">       -->
<!--                               </div> -->
<!--                               <div class="media-body"> -->
<!--                                <h4 class="author-name">Admin</h4> -->
<!--                                <span class="comments-date"> March 26th 2016</span> -->
<!--                                <span class="author-tag">Author</span> -->
<!--                                <p>Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English</p> -->
<!--                                <a href="#" class="reply-btn">回覆留言</a> -->
<!--                               </div> -->
<!--                             </div> -->
<!--                           </li> -->
                          
                          
<!--                           <ul class="children"> -->
<!--                             <li> -->
<!--                               <div class="media"> -->
<!--                                 <div class="media-left">     -->
<!--                                     <img class="media-object news-img" src="img/testimonial-img-2.jpg" alt="img">       -->
<!--                                 </div> -->
<!--                                 <div class="media-body"> -->
<!--                                  <h4 class="author-name">Charlie Balley</h4> -->
<!--                                  <span class="comments-date"> March 26th 2016</span> -->
<!--                                  <p>Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English</p> -->
<!--                                  <a href="#" class="reply-btn">回覆留言</a> -->
<!--                                 </div> -->
<!--                               </div> -->
<!--                             </li> -->
<!--                           </ul> -->
                        </ul>
                        
                        
                        
<!--                         <li> -->
<!--                           <div class="media"> -->
<!--                             <div class="media-left">     -->
<!--                                 <img class="media-object news-img" src="img/testimonial-img-2.jpg" alt="img">       -->
<!--                             </div> -->
<!--                             <div class="media-body"> -->
<!--                              <h4 class="author-name">Charlie Balley</h4> -->
<!--                              <span class="comments-date"> March 26th 2016</span> -->
<!--                              <p>Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English</p> -->
<!--                              <a href="#" class="reply-btn">回覆留言</a> -->
<!--                             </div> -->
<!--                           </div> -->
<!--                         </li> -->
<!--                       </ul> -->
                      
                    </div>
                    <div class="aa-blog-archive-pagination">
                      <nav>
                        <ul class="pagination">
                          <li>
                            <a href="#" aria-label="Previous">
                              <span aria-hidden="true">«</span>
                            </a>
                          </li>
                          <li><a href="#">1</a></li>
                          <li><a href="#">2</a></li>
                          <li><a href="#">3</a></li>
                          <li><a href="#">4</a></li>
                          <li><a href="#">5</a></li>
                          <li>
                            <a href="#" aria-label="Next">
                              <span aria-hidden="true">»</span>
                            </a>
                          </li>
                        </ul>
                      </nav>
                    </div>
                  </div>
                  <!-- blog comments form -->
                  <div id="respond">
                    <h3 class="reply-title">留言</h3>
                    <form id="commentform" method="post" name="form1" 
                    	  action="<%=request.getContextPath()%>/pbReplyServlet?postId=${pbVO.postId}">
                      
                      <p class="comment-form-author">
<!--                       	<label for="">文章編號<span>*</span></label> -->
<!-- 						<input type="Text" name="postId" value=""/> -->
						
                        <label for="author">會員編號<span class="required">*</span></label>
                        <input type="text" name="memberId" value="" size="30" required="required">
                        
<!--                         <label for="">留言編號<span>*</span></label> -->
<!-- 						<input type="Text" name="replyId" value=""/> -->
						
						<label for="replyTime">上傳時間</label>
						<input name="replyTime" id="date" type="text"></input>
                        
                      </p>
                 
                      <p class="comment-form-comment">
                        <label for="replyCont">留言</label>
                        <textarea name="replyCont" cols="45" rows="8" aria-required="true" required="required"></textarea>
                      </p>
                     
                      <p class="form-submit">
                        <input type="submit" class="aa-browse-btn" value="insert">
                      </p>        
                    </form>
                  </div>
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
                  				   size="25" placeholder="健身環大冒險" >
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