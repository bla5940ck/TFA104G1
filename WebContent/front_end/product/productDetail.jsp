<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@page import="com.booking.model.*"%>
<%@page import="com.category.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="prod" class="com.product.model.ProdVO" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品詳情頁面</title>
<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/themes/hot-sneaks/jquery-ui.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.3/jquery-ui.min.js"></script>
<!-- <link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />    -->
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>   -->
<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>   -->
<%
	String path = request.getContextPath();
	ProdDAO productDao = new ProdDAO();
	ProdVO product = null;
	BookingVO bk = new BookingVO();
	Integer prodID = null;

	if (request.getParameter("picno") != null) {
		prodID = Integer.parseInt(request.getParameter("picno"));
		product = productDao.findProductByPK(prodID);

	}

	else if (request.getAttribute("bk") != null) {
		bk = (BookingVO) request.getAttribute("bk");
		prodID = bk.getProdID();
		product = productDao.findProductByPK(prodID);
	}

	BookingService bkDao = new BookingService();

	int picAmount = 0;
	//動態算出 資料庫圖片個數
	if (product != null) {
		if (product.getPic1() != null)
			picAmount++;
		if (product.getPic2() != null)
			picAmount++;
		if (product.getPic3() != null)
			picAmount++;
	}
	List<BookingVO> list = null;
	if (product != null) {
		list = bkDao.findDateByProdID(product.getProdID());

	}
%>
<script>
	
	  /// //加入購物車///////
	   function selflog_show(id){ 
		  	
			var myStartDate = new Date(startDate);
			var myEndDate = new Date(endDate);
			var date_dif = (myEndDate - myStartDate) / 86400000;
		  console.log(date_dif);
		  
		 $.ajax({
		    	url:"<%=path%>/prod/ProdServlet",
		    	cache : false,
		    	type: "POST",
		    	async: false,
		    	data: {
		    		action: "cart",
		    		prodID: id,
		    		startDate:$("#startDate").val(),
		    		endDate :$("#endDate").val(),
		    		rent :<%=product.getProdRent()%>,
		    		tatolPrice: date_dif * <%=product.getProdRent()%>,
		    		prodName:"<%=product.getProdName()%>",
		    		
		    	},
		    	error : function(request) {
					alert("傳送請求失敗！");
				},
		    	success: function(data){
		    		$("#ajaxlabel").html(data);
		    	},
		    });
		 };
	
	
	

		
	var disableddates = new Array();  
<%for (int i = 0; i < list.size(); i++) {
				long k = (list.get(i).getEstEnd().getTime() - list.get(i).getEstStart().getTime()) / 86400000;

				for (long j = 0; j <= k + 6; j++) {
					//儲存所有的區間日期
					long d = list.get(i).getEstStart().getTime() + 86400000 * (j - 3);//前3後3緩衝計算
					// 			 String str = sdf.format(new Date(list.get(i).getEstStart().getTime() + 86400000 * j));%>
	disableddates.push(
<%=d%>
	);
<%}
			}%>
	for (var i = 0; i < disableddates.length; i++) {

		disableddates[i] = formatDate(new Date(disableddates[i]));
	}

	function DisableSpecificDates(date) {
		var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
		return [ disableddates.indexOf(string) == -1 ];
	}
	$(function() {
		$("#startDate").datepicker({
			beforeShowDay : DisableSpecificDates,
			dateFormat : "yy-mm-dd",
			minDate : "-d"

		});
	});

	$(function() {
		$("#endDate").datepicker({
			beforeShowDay : DisableSpecificDates,
			dateFormat : "yy-mm-dd",
			minDate : "-d"

		});
	});

	//日期轉換字串
	function formatDate(date) {
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
				+ d.getDate(), year = d.getFullYear();

		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;

		return [ year, month, day ].join('-');
	}
</script>

<style type="text/css">
hr {
	border-color: FF7F00;
}

div.box {
	float: left;
	margin-top: 5px;
	margin-bottom: 5px;
}

div dd {
	margin: 0px;
	font-size: 10pt;
}

div dd.dd_name {
	color: blue;
}

div dd.dd_city {
	color: #000;
}

div #cart {
	margin: 0px auto;
	text-align: right;
}

a {
	text-decoration: none;
}

#userView {
	position: absolute;
	top: 0;
	right: 0;
}

#userView {
	position: absolute;
	top: 0;
	right: 0;
}

.box {
	width: 400px;
}

#show_L img {
	width: 80%;
}

.all_img {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
}

.all_img img {
	width: 80%;
	cursor: pointer;
}
</style>
</head>
<body>


	<!-- <div id ="dialog" title="加入購物車成功"> -->
	<!-- 		<p>12222</p> -->
	<!-- 		</div> -->
	<label id="ajaxlabel"></label>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>



	<div id="userView">
		<a href="memberData.jsp" title="測試超連結"><img
			src="https://img.ltn.com.tw/Upload/ent/page/800/2021/03/14/phpJc0Acy.jpg"
			width="60px"></a> 會員編號<%=session.getAttribute("id")%>

	</div>
	<h1>商品詳情</h1>
	<a href="allProduct.jsp"">首頁</a> >>
	<a href="allProduct.jsp" title="商品頁面">商品列表</a>
	<hr>
	<center>
		<table width="750" height="60" cellpadding="0" cellspacing="0"
			border="0">
			<tr>
				<!-- 商品詳情 -->

				<%
					if (product != null) {
				%>

				<td width="70%" valign="top">
					<table>
						<tr>
							<div class="box">
								<div id='show_L'>
									<img
										src="<%=path%>/prod/ProdServlet?action=detail&picNo=<%=prodID%>&no=1"
										alt="">
								</div>
								<div class="all_img" id="all_img"></div>
							</div>

						</tr>
						<tr>
							<td><B><%=product.getProdName()%></B></td>
						</tr>
						<tr>
							<td>會員編號：<%=product.getMemberID()%></td>
						</tr>
						<tr>
							<td>租金：$<%=product.getProdRent()%>
							</td>
						</tr>

						<tr>
							<td class="start">預計租借日期:<input id="startDate" type="text"><br>
								預計歸還日期:<input id="endDate" type="text">
							</td>
						</tr>
						<tr>
							<td>金額試算: <label id="subtotal" style="color: red"></label>元<input
								type="button" value="試算" id="subtotal_btn">

							</td>
						</tr>
						<tr>
							<td>商品內容: <label id="pro_cot" style="color: blue"><%=product.getProdCot()%></label>

							</td>
						</tr>
					</table>
					<div id="cart">
						<a href="javascript:selflog_show(<%=product.getProdID()%>)"> <%-- 						 <a href="<%=path%>/prod/ProdServlet?action=checkout&prodID=<%=product.getProdID()%>"> --%>
							<img
							src="http://ae01.alicdn.com/kf/H7c4a2878bd1840ab8c1b7a51bdf9c770P.jpg"
							width="60"></a>

					</div>
				</td>

				<%
					}
				%>


				<script>
					//   
					//圖片數量
					var picAmount =
				<%=picAmount%>
					;

					var startDate = "";
					var endDate = "";

					$("#startDate").change(function(e) {
						startDate = $("#startDate").datepicker("getDate");
						$('#endDate').datepicker('option', {

							minDate : new Date(startDate),
							
						});
						
					});

					$("#endDate").change(
							function(e) {
								endDate = $("#endDate").datepicker("getDate");
								var start_str = $.datepicker.formatDate(
										"yy-mm-dd", startDate);
								$('#startDate').datepicker('option', {
									
									maxDate : new Date(endDate)
								});
								
							});

					$("#subtotal_btn").click(function() {

						var myStartDate = new Date(startDate);
						var myEndDate = new Date(endDate);
						var date_dif = (myEndDate - myStartDate) / 86400000;
						var rent =
				<%=product.getProdRent()%>
					$("#subtotal").html((date_dif + 1) * rent);
					});

					//小圖換大圖 
					function change_img(e) {
						let new_sre = e.target.getAttribute('src');
						document.querySelector('#show_L > img').setAttribute(
								'src', new_sre);
					}
					function init() {
						//動態印出資料庫裡的圖片
						for (var i = 1; i <= picAmount; i++) {
							//取得圖片編號對應1 2 3
							var query =
				<%=prodID%>
					+ "&no=" + i;

							$('div.all_img').append(
									"<img src='<%=path%>/prod/ProdServlet?action=detail&picNo="
											+ query + "'>");
						}
						document.querySelectorAll('.all_img > img').forEach(
								function(element) {
									element.addEventListener('click',
											change_img);
								});
					}
					window.addEventListener('load', init);
					
					
				
					
					
					
				</script>