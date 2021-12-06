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
 <link href="<%=request.getContextPath()%>/front_end/product/css/style2.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="https://s.yimg.com/qs/mall/yps/common/yps.20170504.2017-0504-153103.css" />

<style>

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



	<%@ include file="/includeFolder/header.file"%>

	<div class="main_content">
		<aside class="aside"> <br>
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
				<h3 style="font-weight: bold;" class="subnav-title">個人相關</h3>
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
							</a> <span class=""></span>
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
					
					<br>
						<li class="pure-menu-item subnav-item">
						<div class="item-conatiner">
							<a href=""
								class="pure-menu-link subnav-item-link icon-nav-notification ">
								<svg class="nav-icon nav-icon-notification" width="22"
									height="22" viewBox="0 0 24 24" data-icon="ec-notification">
								</svg> <lable style="font-size:20px">會員管理</lable>
							</a>
						</div>
					</li>
					<br>
						<li class="pure-menu-item subnav-item">
						<div class="item-conatiner">
							<a href=""
								class="pure-menu-link subnav-item-link icon-nav-notification ">
								<svg class="nav-icon nav-icon-notification" width="22"
									height="22" viewBox="0 0 24 24" data-icon="ec-notification">
								</svg> <lable style="font-size:20px">帳務管理</lable>
							</a>
						</div>
					</li>
					
					<br>
					
					
					
					
					
					
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
							<a href="" class="pure-menu-link subnav-item-link icon-nav-cart ">
								<svg class="nav-icon nav-icon-cart" width="22" height="22"
									viewBox="0 0 24 24" data-icon="ec-cart"> <path
									d="M9.5 10.5H16c.552 0 1 .444 1 1 0 .552-.445 1-1 1H9.5c-.552 0-1-.444-1-1 0-.552.445-1 1-1zM10 21c0-1.105-.895-2-2-2s-2 .895-2 2 .895 2 2 2 2-.895 2-2zm9.5 0c0-1.105-.895-2-2-2s-2 .895-2 2 .895 2 2 2 2-.895 2-2zM4.496 2H4.5c.552.005.998.445 1 .996L7 15h11.5L20 4.996S20.082 4 21 4c.915 0 1 .762 1 1l-1.5 11.004c0 .55-.448.996-1 .996H6c-.552 0-1-.45-1-.996L3.616 4H1.01C.45 4 0 3.556 0 3c0-.552.45-1 1.01-1H4.495zM9.5 5.5H16c.552 0 1 .444 1 1 0 .552-.445 1-1 1H9.5c-.552 0-1-.444-1-1 0-.552.445-1 1-1z"></path>
								</svg> <lable class="cart-member" style="font-size:20px">購物車</lable>
							</a> <span class="subnav-item-count" style="color:blue"></span>
						</div></li>
					</br>
		</aside>

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
																<c:if test="${prodVO.prodStatus==2}">
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
		
		
		
	</script>



</body>

</html>

