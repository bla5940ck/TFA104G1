<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!doctype html public "-//w3c//dtd html 4.01//en" "http://www.w3.org/tr/html4/strict.dtd">
<html dir="ltr" lang="zh-Hant-TW">
<style>
div.overlay{
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  background-color: hsla(0, 0%, 0%, .5);
  
  display: none;
}

/* 元素 article 置中及基本樣式 */
div.overlay > article{
  background-color: white;
  width: 90%;
  max-width: 800px;
  border-radius: 10px;
  box-shadow: 0 0 10px #ddd;
  padding: 10px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  height: 200px;
  overflow: scroll;
}

</style>
<head>
<title>出租者頁面</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="zh-TW">
<meta name="robots" content="noindex">
 <link href="<%=request.getContextPath()%>/front_end/product/css/style2.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="https://s.yimg.com/qs/mall/yps/common/yps.20170504.2017-0504-153103.css" />

<script src="http://www.dukelearntoprogram.com/course1/common/js/image/SimpleImage.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	var $li = $('.pure-menu-list subnav-list ul li').click(function() {
		$li.removeClass('selected');
		$(this).addClass('selected');
	});
</script>

</head>



<body class="ps_my_followup_store">



	<%
// 		session.setAttribute("id", 1);
// 		String memberID = (String)session.getAttribute("id");
	%>



	<%@ include file="/includeFolder/header.file"%>

	<div class="main_content">
		
	<%@ include file="/includeFolder/leaseMemberAside.file"%>

		<main class="main">

		


			<!--(begin)inc/ps_watch_list_content.html-->
			<div id="ypswlicon" class="ypsmodule">
				<div class="hd"></div>
				<div class="bd">
					<div class="backpanegray">
						<div class="bpg-wraper1">
							<div class="bpg-wraper2">
								<div class="bpgbd clearfix">
									<div class="nav">
										<!--(begin)inc/ps_watch_list_tagroll.html-->
										<div id="ypswltag" class="ypsmodule ypspane-g">
											<div class="hd">
												<h4>
													<span>自訂分類</span>
												</h4>
											</div>
											<br> <br>

											<ul>
												<!-- 											////////全部li////// -->
												<li class="pure-menu-item subnav-item">
													<div class="item-conatiner">
														<a
															href="<%=request.getContextPath()%>/front_end/product/leaseProdPage.jsp"
															class="pure-menu-link subnav-item-link icon-nav-my-store ">
															<svg class="nav-icon nav-icon-favorite" width="25"
																height="22" viewBox="0 0 24 24" data-icon="ec-favorite">
															</svg> <lable style="font-size:20px">全部商品</lable>
														</a>
													</div>
												</li>


												<!-- 											///////上架中li//////// -->
												<li class="pure-menu-item subnav-item">
													<div class="item-conatiner">
														<a
															href="<%=request.getContextPath()%>/front_end/product/leaseProdPage.jsp?status=1"
															class="pure-menu-link subnav-item-link icon-nav-my-store ">
															<svg class="nav-icon nav-icon-favorite" width="25"
																height="22" viewBox="0 0 24 24" data-icon="ec-favorite">
															</svg> <lable style="font-size:20px">上架中</lable>
														</a>
													</div>
												</li>
												<!-- 									//////待上架li///////// -->
												<li class="pure-menu-item subnav-item">
													<div class="item-conatiner">
														<a
															href="<%=request.getContextPath()%>/front_end/product/leaseProdPage.jsp?status=0"
															class="pure-menu-link subnav-item-link icon-nav-my-store ">
															<svg class="nav-icon nav-icon-favorite" width="25"
																height="22" viewBox="0 0 24 24" data-icon="ec-favorite">
															</svg> <lable style="font-size:20px">待上架</lable>
														</a>
													</div>
												</li>

												<li class="pure-menu-item subnav-item">
													<div class="item-conatiner">
														<a
															href="<%=request.getContextPath()%>/front_end/product/leaseProdPage.jsp?status=9"
															class="pure-menu-link subnav-item-link icon-nav-my-store ">
															<svg class="nav-icon nav-icon-favorite" width="25"
																height="22" viewBox="0 0 24 24" data-icon="ec-favorite">
															</svg> <lable style="font-size:20px">停用中</lable>
														</a>
													</div>
												</li>

											</ul>
											<div class="bd clearfix"></div>

											<div class="ft">
												<div></div>
											</div>
											<!-- (begin) cms module -->

										</div>
									</div>
									<div class="list">


										<div class="boldhead">
											<div class="wraper"
												style="background-color: black; padding: 15px">
												<input type="hidden" name="_watchCrumb" value="rt275baEhH5" />
											</div>
										</div>






										<table class="watchlist">
											<colgroup>
												<col width="5%" />
												<col width="21%" />
												<col width="30%" />
												<col width="18%" />
												<col width="13%" />
												<col width="13%" />
											</colgroup>
											<thead>
												<tr>
													<th></th>
													<td class="title" colspan="2">商品名稱</td>
													<td>租金</td>
													<td>商品損壞賠償金</td>
													<td>上架/下架</td>
												</tr>
											</thead>
											<jsp:useBean id="prodSvc1" scope="page"
												class="com.product.model.ProdService" />
											<!-- 		//////全部商品///////// -->

											<c:forEach var="prodVO" items="${prodSvc1.all}">
												<c:if test="${prodVO.memberID == id}">
													<c:if test="${empty param.status}">
														<tbody>

															<tr>
																<th rowspan="3"><input type="checkbox"
																	class="prod-check" name="productid"
																	value="${prodVO.prodID}" /></th>
																<td colspan="5" class="title"><a
																	style="font-size: 15px;"
																	href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">
																		${prodVO.prodName}</a> <a href="" target="_blank"> <img
																		src="https://s.yimg.com/f/i/tw/mall/yps/ico_caption.gif" />
																</a></td>
															</tr>
															<tr>
																<td rowspan="2" class="thumb">
																	<div class="pre">
																		<table>
																			<tr>
																				<td><a
																					href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">
																						<img
																						src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=${prodVO.prodID}">
																				</a> <!-- <span class="nopic">無商品圖</span>  --></td>
																			</tr>
																		</table>
																	</div>
																</td>
																<td class="info">
																	<ul>
																		<li>商品編號 <a
																			href="http://tw.mall.yahoo.com/store/watsons"
																			target="_blank">${prodVO.prodID }</a>


																		</li>
																		<li>查看預約狀況： <a class="score" href="#">點擊</a>
																		</li>
																		<li><img alt='超商取貨'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_superbus.png'
																			title='超商取貨' /><img alt='可刷卡'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_canbrush.png'
																			title='可刷卡' /><img alt='零利率'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_0rate.png'
																			title='零利率' />

																	</ul>
																</td>
																<td>
																	<div class="price-sec">
																		<span class="price">租金：<span class="web-price">${prodVO.prodRent }元</span></span>
																	</div>
																</td>
																<td><span class=""> ${prodVO.prodPrice}元 </span></td>
																<c:if test="${prodVO.prodStatus==0}">
																	<td><label style="color: orange; font-size: 20px;">待上架</label>
																		<div style="color: green">
																			<input type="radio" class="redioStatus"
																				name="redioStatus" value="1"> <label
																				for="huey">上架</label>
																		</div>

																		<div style="color: #6C3365">
																			<input type="radio" class="redioStatus"
																				name="redioStatus" value="0"> <label>下架</label>
																		</div> 變更狀態: <a class="a-mod2" href="" />變更</a>
																		<form
																			action="<%=request.getContextPath()%>/prod/ProdServlet"
																			class="form2">
																			<input type="hidden" name="action"
																				value="changeStaus"> <input type="hidden"
																				class="hiddenID" name="prodID"
																				value="${prodVO.prodID}"> <input
																				type="hidden" class="prodStatus" name="prodStatus">
																		</form></td>
																</c:if>
																<c:if test="${prodVO.prodStatus==1}">
																	<td><label style="color: blue; font-size: 20px;">上架中</label>
																		<div style="color: green">
																			<input type="radio" class="redioStatus"
																				name="redioStatus" value="1"> <label>上架</label>
																		</div>

																		<div style="color: #6C3365">
																			<input type="radio" class="redioStatus"
																				name="redioStatus" value="0"> <label>下架</label>
																		</div> 變更狀態: <a class="a-mod2" href="" />變更</a>
																		<form
																			action="<%=request.getContextPath()%>/prod/ProdServlet"
																			class="form2">
																			<input type="hidden" name="action"
																				value="changeStaus"> <input type="hidden"
																				class="hiddenID" name="prodID"
																				value="${prodVO.prodID}"> <input
																				type="hidden" class="prodStatus" name="prodStatus">
																		</form></td>
																</c:if>
																<c:if test="${prodVO.prodStatus==9}">
																	<td><label style="color: red; font-size: 20px;">停用中</label></td>
																</c:if>


																<td>
															</tr>
															<tr>
																<td colspan="3" class="tags">修改商品：<a class="a-mod"
																	href="<%=request.getContextPath()%>/prod/ProdServlet?action=modify&prodID=${prodVO.prodID}" />修改商品</a></td>
																<td class="tags conn"></td>
															</tr>
														</tbody>
													</c:if>
												</c:if>
											</c:forEach>










											<!-- 										//////////上架中//////////// -->

											<c:forEach var="prodVO" items="${prodSvc1.all}">
												<c:if test="${prodVO.memberID == id}">
													<c:if test="${param.status==1 and prodVO.prodStatus==1}">
														<tbody>

															<tr>
																<th rowspan="3"><input type="checkbox"
																	class="prod-check" name="productid"
																	value="${prodVO.prodID}" /></th>
																<td colspan="5" class="title"><a
																	style="font-size: 15px;"
																	href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">
																		${prodVO.prodName}</a> <a href="" target="_blank"> <img
																		src="https://s.yimg.com/f/i/tw/mall/yps/ico_caption.gif" />
																</a></td>
															</tr>
															<tr>
																<td rowspan="2" class="thumb">
																	<div class="pre">
																		<table>
																			<tr>
																				<td><a
																					href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">
																						<img
																						src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=${prodVO.prodID}">
																				</a> <!-- <span class="nopic">無商品圖</span>  --></td>
																			</tr>
																		</table>
																	</div>
																</td>
																<td class="info">
																	<ul>
																		<li>商品編號 <a
																			href="http://tw.mall.yahoo.com/store/watsons"
																			target="_blank">${prodVO.prodID }</a>


																		</li>
																		<li>評價： <a class="score" href="">9.6</a>
																		</li>
																		<li><img alt='超商取貨'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_superbus.png'
																			title='超商取貨' /><img alt='可刷卡'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_canbrush.png'
																			title='可刷卡' /><img alt='零利率'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_0rate.png'
																			title='零利率' /></li>

																	</ul>
																</td>
																<td>
																	<div class="price-sec">
																		<span class="price">租金：<span class="web-price">${prodVO.prodRent }元</span></span>
																	</div>
																</td>
																<td><span class=""> ${prodVO.prodPrice}元 </span></td>
																<td><label style="color: blue; font-size: 20px;">上架中</label>
																	<div style="color: green">
																		<input type="radio" class="redioStatus"
																			name="redioStatus" value="1"> <label
																			for="huey">上架</label>
																	</div>

																	<div style="color: #6C3365">
																		<input type="radio" class="redioStatus"
																			name="redioStatus" value="0"> <label
																			for="dewey">下架</label>
																	</div> 變更狀態: <a class="a-mod2" href="" />變更</a>
																	<form
																		action="<%=request.getContextPath()%>/prod/ProdServlet"
																		class="form2">
																		<input type="hidden" name="action" value="changeStaus">
																		<input type="hidden" class="hiddenID" name="prodID"
																			value="${prodVO.prodID}"> <input
																			type="hidden" class="prodStatus" name="prodStatus">
																	</form></td>

															</tr>
															<tr>
																<td colspan="3" class="tags">修改商品：<a class="a-mod"
																	href="<%=request.getContextPath()%>/prod/ProdServlet?action=modify&prodID=${prodVO.prodID}" />修改商品</a></td>
																<td class="tags conn"></td>
															</tr>
														</tbody>
													</c:if>
												</c:if>
											</c:forEach>


											<!-- 										/////////待上架商品////////////////// -->
											<c:forEach var="prodVO" items="${prodSvc1.all}">
												<c:if test="${prodVO.memberID == id}">
													<c:if test="${param.status==0 and prodVO.prodStatus==0}">
														<tbody>

															<tr>
																<th rowspan="3"><input type="checkbox"
																	class="prod-check" name="productid"
																	value="${prodVO.prodID}" /></th>
																<td colspan="5" class="title"><a
																	style="font-size: 15px;"
																	href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">
																		${prodVO.prodName}</a><a href="" target="_blank"> <img
																		src="https://s.yimg.com/f/i/tw/mall/yps/ico_caption.gif" />
																</a></td>
															</tr>
															<tr>
																<td rowspan="2" class="thumb">
																	<div class="pre">
																		<table>
																			<tr>
																				<td><a
																					href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">
																						<img
																						src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=${prodVO.prodID}">
																				</a> <!-- <span class="nopic">無商品圖</span>  --></td>
																			</tr>
																		</table>
																	</div>
																</td>
																<td class="info">
																	<ul>
																		<li>商品編號 <a
																			href="http://tw.mall.yahoo.com/store/watsons"
																			target="_blank">${prodVO.prodID }</a>


																		</li>
																		<li>評價： <a class="score" href="">9.6</a>
																		</li>
																		<li><img alt='超商取貨'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_superbus.png'
																			title='超商取貨' /><img alt='可刷卡'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_canbrush.png'
																			title='可刷卡' /><img alt='零利率'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_0rate.png'
																			title='零利率' /></li>

																	</ul>
																</td>
																<td>
																	<div class="price-sec">
																		<span class="price">租金：<span class="web-price">${prodVO.prodRent }元</span></span>
																	</div>
																</td>
																<td><span class=""> ${prodVO.prodPrice}元 </span></td>
																<td><label style="color: orange; font-size: 20px;">待上架</label>
																	<div style="color: green">
																		<input type="radio" class="redioStatus"
																			name="redioStatus" value="1"> <label
																			for="huey">上架</label>
																	</div>

																	<div style="color: #6C3365">
																		<input type="radio" class="redioStatus"
																			name="redioStatus" value="0"> <label
																			for="dewey">下架</label>
																	</div> 變更狀態: <a class="a-mod2" href="" />變更</a>


																	<form
																		action="<%=request.getContextPath()%>/prod/ProdServlet"
																		class="form2">
																		<input type="hidden" name="action" value="changeStaus">
																		<input type="hidden" class="hiddenID" name="prodID"
																			value="${prodVO.prodID}"> <input
																			type="hidden" class="prodStatus" name="prodStatus">
																	</form></td>

															</tr>
															<tr>
																<td colspan="3" class="tags">修改商品：<a class="a-mod"
																	href="<%=request.getContextPath()%>/prod/ProdServlet?action=modify&prodID=${prodVO.prodID}" />修改商品</a></td>
																<td class="tags conn"></td>
															</tr>
														</tbody>
													</c:if>
												</c:if>
											</c:forEach>




											<!-- 											/////////違規商品////////// -->
											<c:forEach var="prodVO" items="${prodSvc1.all}">
												<c:if test="${prodVO.memberID == id}">
													<c:if test="${param.status==9 and prodVO.prodStatus==9}">
														<tbody>

															<tr>
																<th rowspan="3"><input type="checkbox"
																	class="prod-check" name="productid"
																	value="${prodVO.prodID}" /></th>
																<td colspan="5" class="title"><a
																	style="font-size: 15px;"
																	href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">
																		${prodVO.prodName}</a><a href="" target="_blank"> <img
																		src="https://s.yimg.com/f/i/tw/mall/yps/ico_caption.gif" />
																</a></td>
															</tr>
															<tr>
																<td rowspan="2" class="thumb">
																	<div class="pre">
																		<table>
																			<tr>
																				<td><a
																					href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">
																						<img
																						src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=${prodVO.prodID}">
																				</a> <!-- <span class="nopic">無商品圖</span>  --></td>
																			</tr>
																		</table>
																	</div>
																</td>
																<td class="info">
																	<ul>
																		<li>商品編號 <a
																			href="http://tw.mall.yahoo.com/store/watsons"
																			target="_blank">${prodVO.prodID }</a>


																		</li>
																		<li>評價： <a class="score" href="">9.6</a>
																		</li>
																		<li><img alt='超商取貨'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_superbus.png'
																			title='超商取貨' /><img alt='可刷卡'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_canbrush.png'
																			title='可刷卡' /><img alt='零利率'
																			src='https://s.yimg.com/f/i/tw/mall/yps/ico_0rate.png'
																			title='零利率' /></li>

																	</ul>
																</td>
																<td>
																	<div class="price-sec">
																		<span class="price">租金：<span class="web-price">${prodVO.prodRent }元</span></span>
																	</div>
																</td>
																<td><span class=""> ${prodVO.prodPrice}元 </span></td>
																<td style="color: red">停用中</td>

															</tr>

														</tbody>
													</c:if>
												</c:if>
											</c:forEach>



										</table>
										<br>
		</main>
	</div>



<div class="overlay" style="border: 1px solid red;">
  <article  style=" height:400px">
    <h1>商品預約查看</h1>
    <table class="bk_table">
     <tr style="height:30px;background-color:#00E3E3">
            <td>預約編號</td>
            <td>預約起日</td>
            <td>預約迄日</td>
        </tr>
    
    
    </table>
	
    <button type="button" class="btn_modal_close">關閉</button>
  </article>
</div>
		
		
		
	<script>
		$("a.a-mod2").click(
				function() {
					let prodstatus = 0;
					let prodID = $(this).closest('td').find('input.hiddenID')
							.val();
					let offStatus = $(this).closest('td').find(
							'input.redioStatus').eq(1).val();
					let shelfStatus = $(this).closest('td').find(
							'input.redioStatus').eq(0).val();

					if ($(this).closest('td').find('input.redioStatus').is(
							":checked") == false) {

						alert("請點選上下架");
						return false;

					} else {

						if ($(this).closest('td').find('input.redioStatus').eq(
								0).is(":checked") == true) {
							prodstatus = 1;
						} else {
							prodstatus = 0;
						}

						$(this).closest('td').find('form').find(
								'input.prodStatus').val(prodstatus);

						// 		console.log($(this).closest('td').find('form').find('input.prodStatus').val())
						$(this).closest('td').find('form.form2').submit();

						return false;

					}

				});
		
		
			$(window).on('load',function(){
				$("span.subnav-item-count").text(<%=index1%>)
				 
			});

			
			
			$(function(){
				  
				  
				  $("a.score").on("click", function(){
					  console.log($(this).closest('ul').find('a').eq(0).text());
					  let prodID = $(this).closest('ul').find('a').eq(0).text();
					  
					  $.ajax({
						 type:"post",
						 dataType:"json",
						 url:"/TFA104G1/bk/BkServlet",
						 data:{
							action:"searchBk",
							prodID:prodID
						 },
						 success:function(data){
							 let bkList = data.bkList;
							 $('div.overlay h1').text("商品編號" +prodID +" 預約查看");
							 for(var i=0;i<bkList.length;i++){
								  $('table.bk_table').append("<tr class='add1' style='height:30px;background-color:#ADFEDC'><td>"+ bkList[i].bkID +"</td><td>"+ bkList[i].estStart +"</td><td>"+ bkList[i].estEnd +"</td></tr>");

							 }
							 
						 },error:function(x){
							 console.log("失敗");
						 }
					  });
					  

		  
					// 開啟 Modal 彈跳視窗
				    $("div.overlay").fadeIn();
				    return false;
				  });
				  
				  // 關閉 Modal
				  $("button.btn_modal_close").on("click", function(){
				    $("div.overlay").fadeOut();
				    $('tr.add1').remove();
				  });
				  
				});
		
	</script>



</body>

</html>

