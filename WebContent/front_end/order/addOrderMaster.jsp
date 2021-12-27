<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="com.member.model.*"%>
<%@page import="com.member_coupon.model.*"%>
<%@page import="com.promo_list.model.*"%>
<%@page import="com.member.model.*"%>
<%@page import="com.order.model.*"%>
<%@ page import="com.product.model.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="com.google.gson.Gson"%>

<%
// 	System.out.println("進入新增");
%>

<html>
<head>
<title>結帳 :</title>
<style> 
a.cart-img>img {
	object-fit: contain;
	width: 185px;
	height: 140px;
}
</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<FORM METHOD="post" ID="cart-form" ACTION="<%=request.getContextPath()%>/OrderMasterServlet" name="form1">
		<div class="main_content">
			<section id="cart-view">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="cart-view-area">
								<div class="cart-view-table">
									<div>
										<h3>訂單確認</h3>
									</div>
									<h3>確認以下資訊</h3>

									<%
										boolean flag = true;

										List<CartVO> checkoutList = (List<CartVO>) request.getAttribute("checkoutList");
										List<OrderListVO> orderList = new ArrayList();
										for (CartVO cartVO : checkoutList) {
										
											Integer memID = (Integer) session.getAttribute("id");
// 											System.out.println("承租者編號 : " + memID);
											//會員名稱
											MemberService memSVC = new MemberService();
											System.out.println(cartVO.getLeaseID());
											MemberVO memVO = memSVC.getOneMember(cartVO.getLeaseID());
											String leaseName = memVO.getName();
											//起訖日
											Date esstr = cartVO.getEstStart();
											Date eestr = cartVO.getEstEnd();
											long rd = ((eestr.getTime()) - (esstr.getTime()));
											Date rdd = new Date(rd);
											Integer rentDays = new Integer((rdd.getDate()));
											Integer rentDay = new Integer((rdd.getDay()));
											// 預設物流
											DefAddressJDBCDAO dadao = new DefAddressJDBCDAO();
											List<DefAddressVO> list2 = dadao.getAll();
											DefAddressVO daVO = new DefAddressVO();

											// 折價券
											MemcouponDAO mcdao = new MemcouponDAO();
											List<MemcouponVO> list = mcdao.getAll();
											MemcouponVO mcVO = new MemcouponVO();

											//商品租金+總金額
											Integer rent = cartVO.getRent();
											// 				 	System.out.println("商品租金 : " + rent);
											Integer totalPrice = cartVO.getTotalPrice();
											// 				 	System.out.println("總租金 : " + totalPrice);
											pageContext.setAttribute("list", checkoutList);

											OrderListVO olVO = new OrderListVO(); // 第一筆明細a
											olVO.setProdID(cartVO.getProdID());
											olVO.setProdPrice(cartVO.getRent());
											olVO.setEstStart(cartVO.getEstStart());
											olVO.setEstEnd(cartVO.getEstEnd());
											orderList.add(olVO);
									%>
									<div id="lease-div">
										<div class="table-responsive">
											<table class="table">
												<thead>
													<tr>
														<th>商品圖片</th>
														<th>商品名稱</th>
														<th>商品租金</th>
														<th>預計租借日</th>
														<th>預計歸還日</th>
														<th>承租天數:</th>
														<th>總計</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td><a class="cart-img" href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?cookie=y&prodID=<%=cartVO.getProdID()%>">
														<img src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=<%=cartVO.getProdID()%>" alt="img"></a></td>
														<td><a id="prodName" href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=<%=cartVO.getProdID()%>"><%=cartVO.getProdName()%></a></td>
														<td><input type="hidden" name="prodPrice" value="<%=rent%>"><%=rent%> 元</td>
														<td><input type="hidden" name="estStart" value="<%=cartVO.getEstStart()%>"><%=cartVO.getEstStart()%></td>
														<td><input type="hidden" name="estEnd" class="estEnd" value="<%=cartVO.getEstEnd()%>"><%=cartVO.getEstEnd()%></td>
														<td><input type="hidden" name="rentDays" value="<%=rentDays%>"><%=rentDays%> 天</td>
														<td><input type="hidden" class="prodPrice"name="prodPrice" id="prodPrice" value="<%=totalPrice%>"><%=totalPrice%>元</td>
														<input type="hidden" name="rentID" value="<%=memID%>">
														<input type="hidden" name="leaseID"	class="leaseID" value="<%=cartVO.getLeaseID()%>">
														<input type="hidden" name="prodID"	value="<%=cartVO.getProdID()%>">
														<input type="hidden" name="prodName" value="<%=cartVO.getProdName()%>">
														<input type="hidden" name="leaseName" class="leaseName" value="<%=leaseName%>">
													</tr>
											</table>
											<%
												}
												session.setAttribute("list1", orderList);
											%>
											<div class="cart-view-total">
											    <h4 style="text-align:center;">結帳資訊</h4>									
												<table class="aa-totals-table">
													<tbody>
														<jsp:useBean id="poDAO"
															class="com.order.model.PaymentOptionsDAOImpl" />
														<tr>
															<td>取貨方式:</td>
															<td><select size="1" name="payID"
																style="width: 120px">
																	<c:forEach var="poVO"
																		items="${poDAO.getAllPaymentOptions()}">
																		<option value="${poVO.payID}">${poVO.payName}
																	</c:forEach>
															</select></td>
														</tr>

														<jsp:useBean id="daDAO" class="com.member.model.DefAddressDAO" />
														<jsp:useBean id="meDAO" class="com.member.model.MemberDAO" />

														<tr>
															<td>取貨資訊:</td>
															<td><select size="1" name="code711" style="width: 230px">
																<option value=0>面交自取
																<c:forEach var="daVO" items="${daDAO.getAll()}">
																	<c:choose>
																		<c:when test="${daVO.memberId == id}">
																			<option value="${daVO.code711}">${daVO.name711+=" / 收件人: "+=daVO.recipient += daVO.recptPhone}
																		</c:when>
																	</c:choose>
																</c:forEach>
																</select></td>
														</tr>
														<jsp:useBean id="plDAO"	class="com.promo_list.model.PromolistDAO" />
														<jsp:useBean id="mcDAO" class="com.member_coupon.model.MemcouponDAO" />
														<tr>
															<td>選擇折價券:</td>
															<td><select size="1" id="coupon">
																	<option value="0">請選擇折價券
																		<c:forEach var="mcVO" items="${mcDAO.getAll()}">
																			<c:choose>
																				<c:when test="${mcVO.member_id == id && mcVO.status == 0}">
																					<option data-id="${mcVO.coupon_id}"
																						value="${Math.round(mcVO.discount)}">${mcVO.coupon_name}
																				</c:when>
																			</c:choose>
																		</c:forEach>
															</select></td>
														</tr>
														<tr>
															<td>折扣:</td>
															<td><p id="discount"></p></td>
														</tr>
														<tr>
															<td>運費:</td>
															<td><input type="hidden" id="shipFee" name="shipFee" value="60">60 元</td>
														</tr>
														<tr>
															<td>訂單金額:</td>
															<td><p id="thisOrder"></p></td>
														</tr>
													</tbody>
												</table>
												<a href="#" class="aa-cart-view-btn" >送出訂單</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<input type="hidden" name="action" value="submit_order">
		<input type="hidden" name="couponID" id="couponID"> 
		<input type="hidden" name="def711" value="${daVO.def711}">
		<input type="hidden" name="ordPrice" id="ordPrice">		
	</FORM>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>

var leaseID = $("input.leaseID");
console.log(leaseID);
var set = new Set();
// leaseID.each(function(index, item){
// 	console.log($(item).val());
// 	// array.push($(item).val());
// 	set.add($(item).val());
// });

var estEnd = $("input.estEnd");
var estEndSet = new Set();
estEnd.each(function(index, item){
	estEndSet.add($(item).val());
})

$("a.aa-cart-view-btn").click(function(){
	leaseID.each(function (index, item) {
		console.log($(item).val());
		set.add($(item).val());
	});
	estEnd.each(function (index, item) {
		estEndSet.add($(item).val());
	})
	// console.log(set.size);
	if(set.size == 1){
		if(estEndSet.size == 1){
			$("#cart-form").submit();
			
		}else{
			alert("您選擇的起訖日不同! 請回購物車調整! 謝謝!");
			return false;
		}
	}else{
		alert("您選擇的出租方不同! 請回購物車調整! 謝謝!");
		return false;
	}
});


	var coupon = $("#coupon"); //折價券
	var discount = $("#discount"); //折扣
	var thisOrder = $("#thisOrder"); //前端顯示的訂單金額
	var prodPrice = $("#prodPrice"); //商品小計
	var orderPrice = $("#orderPrice"); //回傳servlet的訂單金額

	var total = 0;
	var form = $("input.prodPrice");
	
	form.each(function(index, item) {
		
		// console.log("索引值：" + index + "； 內容：" + $(item).val());
		total += parseInt($(item).val());

		var data_id = "";

		coupon.change(function() {
// 			alert(coupon.val());
			discount.text(coupon.val() + "元");

			var finalPrice = parseInt(total - coupon.val() + 60);
			thisOrder.text(parseInt(total - coupon.val() + 60) + "元");
			document.getElementById("ordPrice").setAttribute('value',
					finalPrice);

			data_id = $("#coupon option:selected").attr('data-id');
// 			console.log(data_id);

			document.getElementById("couponID").setAttribute('value', data_id);

		});

		thisOrder.text(total + "元");
	});

	// 	thisOrder.text(parseInt(totalPrice-(coupon).val()+ 60) + "元");
	// 	thisOrder=parseInt(couponID.val() + prodPrice.val())+ 60 ;
	document.getElementById("ordPrice").setAttribute('value',
			total - coupon.val() + 60);
		

</script>

</html>