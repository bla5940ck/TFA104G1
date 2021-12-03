<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!doctype html public "-//w3c//dtd html 4.01//en" "http://www.w3.org/tr/html4/strict.dtd">
<html dir="ltr" lang="zh-Hant-TW">
<head>
<title>出租者頁面</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="zh-TW">
<meta name="robots" content="noindex">
<meta name="oath:guce:product-eu" content="false" />
<meta name="oath:guce:consent-host" content="guce.yahoo.com" />
<meta name="oath:guce:locale" content="zh-Hant-TW" />
<meta name="oath:guce:inline-consent" content="true" />

<link rel="stylesheet" type="text/css"
	href="https://s.yimg.com/qs/mall/yps/common/yps.20170504.2017-0504-153103.css" />
<link rel="stylesheet" type="text/css"
	href="https://s.yimg.com/qs/mall/yps/common/newtmpmyhd_191105a.2019-1114-165501.css" />
<link rel="stylesheet" type="text/css"
	href="https://s.yimg.com/qs/mall/yps/common/yps_yellow_120701.css" />
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script>
<style>
body {
	margin: 0;
	padding: 10px;
}

img {
	max-width: 100%;
}

button {
	font-size: 13px;
	outline-width: 100%;
	background-color: white;
}

div.main_content {
	width: 100%;
	margin: 0 auto;
	font-size: 0;
}

/*-------------------aside區域------------------- */
aside.aside {
	width: 200px;
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: white;
	width: calc(100% - 200px - 10px);
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	width: 100%;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid lightgrey;
}

th, td {
	padding: 5px;
	text-align: center;
}
.bck_color{
background-color:red;
color:black;
}

li.selected {
    color: green;
}





</style>
<script type="text/javascript">

var $li = $('.pure-menu-list subnav-list ul li').click(function() {
    $li.removeClass('selected');
    $(this).addClass('selected');
});


	

</script>

</head>



<body class="ps_my_followup_store">



	<%
		session.setAttribute("id", 1);
		// String memberID = (String)session.getAttribute("id");
	%>



	<%@ include file="/includeFolder/header2.file"%>

	<div class="main_content">
		<aside class="aside">
		<div id="mh-navigation" class="mh-nav pure-u">
			<div class="mh-nav-hd">
				<h2 id="mh-profile">
					<i class="mh-avatar-wrap"><img id="mh-avatar"
						src="https://s.yimg.com/ag/images/default_user_profile_pic_192sq.jpg"
						height="56" alt="用戶大頭貼"></i> <span class="nav-item-wrap">
						<span class="nav-title">驊</span> <span class="nav-item"> <svg
								class="nav-icon nav-icon-points" width="18" height="18"
								viewBox="0 0 24 24" data-icon="ec-points"
								style="fill: rgb(255, 140, 0); stroke: rgb(255, 140, 0); stroke-width: 0; vertical-align: bottom;">
							</svg>
					</span>
					</span>
				</h2>
			</div>
			<div class="mh-subnav pure-menu">
				<h3 class="subnav-title">個人相關</h3>
				<ul class="pure-menu-list subnav-list">
					<li class="pure-menu-item subnav-item">
						<div class="item-conatiner">
							<a href=""
								class="pure-menu-link subnav-item-link icon-nav-my-store ">
								<svg class="nav-icon nav-icon-favorite" width="25" height="22"
									viewBox="0 0 24 24" data-icon="ec-favorite"> </svg> <lable
									style="font-size:20px">會員折價卷</lable>
							</a>
						</div>
					</li>
					</br>
					<li class="pure-menu-item subnav-item">
						<div class="item-conatiner">
							<a href="#"
								class="pure-menu-link subnav-item-link icon-nav-order "> <svg
									class="nav-icon nav-icon-order" width="18" height="22"
									viewBox="0 0 24 24" data-icon="ec-order"> </svg> <lable
									style="font-size:20px">訂單查詢</lable>
							</a> <span class="subnav-item-count">0</span>
						</div>
					</li>
					</br>
					<li class="pure-menu-item subnav-item">
						<div class="item-conatiner">
							<a href=""
								class="pure-menu-link subnav-item-link icon-nav-notification ">
								<svg class="nav-icon nav-icon-notification" width="22"
									height="22" viewBox="0 0 24 24" data-icon="ec-notification">
								</svg> <lable style="font-size:20px">商品管理</lable>
							</a>
						</div>
					</li>
					</br>
					<li class="pure-menu-item subnav-item">
						<div class="item-conatiner">
							<a href=""
								class="pure-menu-link subnav-item-link icon-nav-notification ">
								<svg class="nav-icon nav-icon-notification" width="22"
									height="22" viewBox="0 0 24 24" data-icon="ec-notification">
								<path
									d="M21.383 17.817c.262.205.375.36.375.36.15.192.242.433.242.696 0 .622-.505 1.127-1.128 1.127-.03 0-.062-.003-.093-.005H3.22c-.03.002-.06.005-.09.005C2.505 20 2 19.495 2 18.873c0-.263.09-.504.242-.696 0 0 .114-.155.376-.36.075-.06.677-.562 1.163-1.44.095-.172.374-.777.418-.9.12-.332.204-.734.333-1.31.308-1.977.287-4.796.287-4.796l-.002-.19c0-3.45 2.437-6.328 5.685-7.02V2c0-.83.672-1.5 1.5-1.5s1.5.67 1.5 1.5v.16c3.25.69 5.688 3.57 5.688 7.02 0 .064-.002.127-.003.19 0 .002-.022 2.82.284 4.797.128.576.212.98.332 1.31.044.123.323.728.418.9.486.878 1.088 1.38 1.163 1.44zM12 17.995h6.875c-.137-.198-.274-.415-.405-.652-.13-.235-.458-.936-.548-1.184-.15-.415-.244-.834-.362-1.364l-.043-.19-.014-.067-.01-.067c-.328-2.113-.31-4.996-.308-5.117V9.327c.002-.05.003-.097.003-.146 0-2.854-2.326-5.177-5.187-5.18-2.858.003-5.185 2.326-5.185 5.18 0 .046 0 .092.002.138l.023.857-.03.03c-.016 1.058-.08 2.832-.302 4.268l-.01.066-.014.065-.043.19c-.118.53-.21.95-.362 1.365-.09.247-.417.948-.547 1.183-.13.238-.268.455-.405.652H12zM14.5 21c0 1.38-1.12 2.5-2.5 2.5S9.5 22.38 9.5 21h5z"></path>
								</svg> <lable style="font-size:20px">通知</lable>
							</a>
						</div>
					</li>
					<li class="pure-menu-item subnav-item"></br>
						<div class="item-conatiner">
							<a href=""
								class="pure-menu-link subnav-item-link icon-nav-cart "> <svg
									class="nav-icon nav-icon-cart" width="22" height="22"
									viewBox="0 0 24 24" data-icon="ec-cart"> <path
									d="M9.5 10.5H16c.552 0 1 .444 1 1 0 .552-.445 1-1 1H9.5c-.552 0-1-.444-1-1 0-.552.445-1 1-1zM10 21c0-1.105-.895-2-2-2s-2 .895-2 2 .895 2 2 2 2-.895 2-2zm9.5 0c0-1.105-.895-2-2-2s-2 .895-2 2 .895 2 2 2 2-.895 2-2zM4.496 2H4.5c.552.005.998.445 1 .996L7 15h11.5L20 4.996S20.082 4 21 4c.915 0 1 .762 1 1l-1.5 11.004c0 .55-.448.996-1 .996H6c-.552 0-1-.45-1-.996L3.616 4H1.01C.45 4 0 3.556 0 3c0-.552.45-1 1.01-1H4.495zM9.5 5.5H16c.552 0 1 .444 1 1 0 .552-.445 1-1 1H9.5c-.552 0-1-.444-1-1 0-.552.445-1 1-1z"></path>
								</svg> <lable style="font-size:20px">購物車</lable>
							</a> <span class="subnav-item-count">0</span>
						</div></li>
					</br>
		</aside>

		<main class="main">

		<div id="bd-right">
			<!--(begin)inc/ps_wtach_list_search.html-->
			<div id="ypswlsh" class="ypsmodule">
				<div class="bd">
					<form name="form1" method="post" action="">
						<label>商品查詢：</label> <input name="keyword" type="text"
							class="keyword" value="" /> <input class="hidetext search"
							type="submit" value="搜尋" /> <a
							href=""
							target="_blank">說明</a>
					</form>
				</div>
				<div class="ft"></div>
			</div>
			<!--(end) inc/ps_wtach_list_search.html-->


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
											<br>
											<br>
											
											<ul>
<!-- 											////////全部li////// -->
												<li class="pure-menu-item subnav-item">
													<div class="item-conatiner">
														<a href="<%=request.getContextPath()%>/front_end/product/leaseProdPage.jsp"
															class="pure-menu-link subnav-item-link icon-nav-my-store ">
															<svg class="nav-icon nav-icon-favorite" width="25"
																height="22" viewBox="0 0 24 24" data-icon="ec-favorite">
															</svg> <lable style="font-size:20px">全部商品</lable>
														</a>
													</div>
												</li>
											
											
<!-- 											///////已上架li//////// -->
												<li class="pure-menu-item subnav-item">
													<div class="item-conatiner">
														<a href="<%=request.getContextPath()%>/front_end/product/leaseProdPage.jsp?status=1"
															class="pure-menu-link subnav-item-link icon-nav-my-store ">
															<svg class="nav-icon nav-icon-favorite" width="25"
																height="22" viewBox="0 0 24 24" data-icon="ec-favorite">
															</svg> <lable style="font-size:20px">已上架</lable>
														</a>
													</div>
												</li>
<!-- 									//////下架中li///////// -->
												<li class="pure-menu-item subnav-item">
													<div class="item-conatiner">
														<a href="<%=request.getContextPath()%>/front_end/product/leaseProdPage.jsp?status=0"
															class="pure-menu-link subnav-item-link icon-nav-my-store ">
															<svg class="nav-icon nav-icon-favorite" width="25"
																height="22" viewBox="0 0 24 24" data-icon="ec-favorite">
															</svg> <lable style="font-size:20px">下架中</lable>
														</a>
													</div>
												</li>

												<li class="pure-menu-item subnav-item">
													<div class="item-conatiner">
														<a href=""
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

										<form name="form1" method="post" action="">
											<div class="boldhead">
												<div class="wraper" style="background-color: black; padding:15px">
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
														<th><input type="checkbox" /></th>
														<td class="title" colspan="2">商品名稱</td>
														<td>租金</td>
														<td>商品損壞賠償金</td>
														<td>上架/下架</td>
													</tr>
												</thead>
												<jsp:useBean id="prodSvc1" scope="page"
													class="com.product.model.ProdService" />
<!-- 											//////全部商品///////// -->
													
												<c:forEach var="prodVO" items="${prodSvc1.all}">
													<c:if test="${prodVO.memberID == id}">
													<c:if test="${empty param.status}">
														<tbody>

															<tr>
																<th rowspan="3"><input type="checkbox"
																	name="productid" value="p033063085383" /></th>
																<td colspan="5" class="title"><a
																	href="">
																		${prodVO.prodName}</a> <a
																	href=""
																	target="_blank"> <img
																		src="https://s.yimg.com/f/i/tw/mall/yps/ico_caption.gif" />
																</a></td>
															</tr>
															<tr>
																<td rowspan="2" class="thumb">
																	<div class="pre">
																		<table>
																			<tr>
																				<td><a
																					href="http://tw.mall.yahoo.com/item/p033063085383">
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
																		<li>評價： <a class="score"
																			href="">9.6</a>
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
																<td>已上架</td>
																
															</tr>
															<tr>
																<td colspan="3" class="tags">修改狀態：</td>
																<td class="tags conn"><input url=""
																	class="" type="button" value="修改狀態" /></td>
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
																	name="productid" value="p033063085383" /></th>
																<td colspan="5" class="title"><a
																	href="">
																		${prodVO.prodName}</a> <a
																	href=""
																	target="_blank"> <img
																		src="https://s.yimg.com/f/i/tw/mall/yps/ico_caption.gif" />
																</a></td>
															</tr>
															<tr>
																<td rowspan="2" class="thumb">
																	<div class="pre">
																		<table>
																			<tr>
																				<td><a
																					href="http://tw.mall.yahoo.com/item/p033063085383">
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
																		<li>評價： <a class="score"
																			href="">9.6</a>
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
																<td>已上架</td>
																
															</tr>
															<tr>
																<td colspan="3" class="tags">修改狀態：</td>
																<td class="tags conn"><input url=""
																	class="" type="button" value="修改狀態" /></td>
															</tr>
														</tbody>
														</c:if>
													</c:if>
												</c:forEach>


<!-- 										/////////下架中商品////////////////// -->
												
												<c:forEach var="prodVO" items="${prodSvc1.all}">
													<c:if test="${prodVO.memberID == id}">
													<c:if test="${param.status==0 and prodVO.prodStatus==0}">
														<tbody>

															<tr>
																<th rowspan="3"><input type="checkbox"
																	name="productid" value="p033063085383" /></th>
																<td colspan="5" class="title"><a
																	href="">
																		${prodVO.prodName}</a> <a
																	href=""
																	target="_blank"> <img
																		src="https://s.yimg.com/f/i/tw/mall/yps/ico_caption.gif" />
																</a></td>
															</tr>
															<tr>
																<td rowspan="2" class="thumb">
																	<div class="pre">
																		<table>
																			<tr>
																				<td><a
																					href="http://tw.mall.yahoo.com/item/p033063085383">
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
																		<li>評價： <a class="score"
																			href="">9.6</a>
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
																<td>下架中</td>
																
															</tr>
															<tr>
																<td colspan="3" class="tags">修改狀態：</td>
																<td class="tags conn"><input url=""
																	class="" type="button" value="修改狀態" /></td>
															</tr>
														</tbody>
														</c:if>
													</c:if>
												</c:forEach>


											</table>
		</main>
	</div>









	</div>
	<div id="ft">

		<div id="ypswladd" class="ypsmodule yps-pop-win">
			<div class="hd">
				<h4>加入收藏清單</h4>
			</div>
			<div class="bd">

				<form
					action="/service/ajax_add_watchlist?ooxx&_watchCrumb=rt275baEhH5"
					method="post" reload="reload">
					<table>
						<tr class="title">
							<th>商品名稱：</th>
							<td class="pname"></td>
						</tr>
						<tr>
					</table>
					<div class="btn">
						<input type="submit" class="submit hidetext" value="確定" /> <input
							type="button" class="cancel hidetext" value="取消" />
					</div>
				</form>
				<div class="running">
					<span>資料傳輸中.</span><img
						src="https://s.yimg.com/f/i/tw/mall/yps/ico_rotate.gif" />
				</div>

			</div>
			<div class="ft"></div>
		</div>



	</div>
	</div>



	</div>
</body>

</html>

