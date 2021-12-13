<%@page import="com.member.model.MemberVO"%>
<%@page import="com.member.model.MemberJDBCDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.order.model.*"%>

<%
	out.print("承租者評價頁面");
	Integer memID = (Integer) session.getAttribute("id");
	OrderMasterVO omVO = (OrderMasterVO) request.getAttribute("OrderMasterVO");
	// 	OrderListVO olVO = new OrderListVO();
	// 	OrderListDAOImpl oldao = new OrderListDAOImpl();
%>

<%
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String formatDate = df.format(new java.util.Date());
	//     out.println(formatDate);
%>
<jsp:useBean id="olDAO" class="com.order.model.OrderListDAOImpl" />


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>訂單資料更新:</title>

<style>
body {
	margin: 0;
	padding: 10px;
	z-index: 1001;
}

img {
	max-width: 100%;
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
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 100px;
}

table, th, td {
	border: 1px solid lightgrey;
	width: 800px;
	text-align: center;
}

th, td {
	padding: 5px;
}

th {
	width: 180px;
}

a.cart-img>img {
	object-fit: contain;
	width: 185px;
	height: 140px;
}

        @import url(https://fonts.googleapis.com/css?family=Roboto:500,100,300,700,400);

/*         * { */
/*             margin: 0; */
/*             padding: 0; */
/*             font-family: roboto; */
/*         } */
        
        a.comment:link,
        a.comment:visited {
            background-color: #191561;
            color: yellow;
            border: 2px solid #191561;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }

        a.comment:hover,
        a.comment:active {
            background-color: yellow;
            color: #191561;
        }

        .cont {
            /* width: 93%; */
            /* max-width: 350px; */
            text-align: center;
            margin: 4% auto;
            /* padding: 30px 0; */
            color: #EEE;
            border-radius: 5px;
            /* border: thin solid #444; */
            overflow: hidden;
        }

        hr {
            margin: 20px;
            border: 1px solid black;
            border-bottom: thin solid rgba(255, 255, 255, 0.1);
        }

        div.title {
            font-size: 2em;
        }

        h1 span {
            font-weight: 300;
            color: #Fd4;
        }

        div.stars {
            width: 270px;
            display: inline-block;
        }

        input.star {
            display: none;
            
        }

        label.star {
            float: right;
            padding: 10px;
            font-size: 36px;
            color: lightyellow;
            transition: all .2s;
            
        }

        input.star:checked~label.star:before {
            content: '\f005';
            color: #FD4;
            transition: all .25s;
        }


        input.star-5:checked~label.star:before {
            color: #FE7;
            text-shadow: 0 0 20px #952;
        }

        input.star-1:checked~label.star:before {
            color: #F62;
        }

        label.star:hover {
            transform: rotate(-15deg) scale(1.3);
        }

        label.star:before {
            content: '\f006';
            font-family: FontAwesome;
        }

        .rev-box {
            /* overflow: hidden; */
            height: 100%;
            width: 100%;
            transition: all .25s;
        }

        textarea.review {
            border: 1px solid black;
            width: 100%;
            max-width: 100%;
            height: 100px;
            padding: 10px;
            box-sizing: border-box;
        }

        label.review {
            display: block;
            transition: opacity .25s;

        }

        input.star:checked~.rev-box {
            height: 125px;
            overflow: visible;
        }

        input.cobt {
            transition-duration: 0.4s;
            color: black;
        }

        .cobt:hover {
            background-color: #191561;
            /* Green */
            color: yellow;
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
	<FORM METHOD="post" ACTION="/TFA104G1/OrderMasterServlet" name="form1">
		<div class="main_content">
			<aside class="aside">
				<nav class="nav">
					<h3>承租者專區</h3>
					<h5>
						會員編號 :
						<%=memID%></h5>
					<ul class="nav_list">
						<h4>
							<a
								href="<%=request.getContextPath()%>/front_end/order/listAllOrderForRent.jsp">全部訂單</a>
						</h4>
						<h4>
							<a
								href="<%=request.getContextPath()%>/front_end/order/listSuccessOrderForRent.jsp">訂單評價</a>
						</h4>
					</ul>
				</nav>
			</aside>
			<main class="main">
				<!-- 				<section id="cart-view"> -->
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="cart-view-area">
								<div class="cart-view-table">
									<div>
										<h4>
											<th>訂單編號</th>
											<td><%=omVO.getOrdID()%></td>
										</h4>
									</div>
									<div id="lease-div">
										<div class="table-responsive">
											<table class="table-1">
												<thead>
													<tr>
														<th>商品圖片</th>
														<th>商品名稱</th>
														<th>出租者</th>
														<th>商品租金</th>
														<th>訂單日期</th>
														<th>承租天數:</th>
														<th>總計</th>
													</tr>
												</thead>
												<%
													OrderListDAOImpl oldao = new OrderListDAOImpl();
													System.out.println(omVO.getOrdID());
													List<OrderListVO> list = oldao.findOrderListByOrdID(omVO.getOrdID());

													for (OrderListVO olVO : list) {

														ProdDAO prodDAO = new ProdDAO();
														ProdVO prodVO = prodDAO.findProductByPK(olVO.getProdID());
														MemberJDBCDAO memDAO = new MemberJDBCDAO();
														MemberVO memVO = memDAO.findByPrimaryKey(omVO.getLeaseID());
												%>
												<tbody>
													<td><a class="cart-img"
														href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=<%=olVO.getProdID()%>">
															<img
															src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=<%=olVO.getProdID()%>"
															alt="img">
													</a></td>
													<td><a id="prodName"
														href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=<%=olVO.getProdID()%>"><%=prodVO.getProdName()%></a></td>
													<td><%=memVO.getName()%></td>
													<td><p id="prodPrice"><%=olVO.getProdPrice()%></p></td>
													<td><fmt:formatDate value="<%=omVO.getOrdDate()%>"
															pattern="yyyy-MM-dd" /></td>
													<td><p id="rentDays"><%=omVO.getRentDays()%></p></td>
													<td><p id="total"><%=olVO.getProdPrice() * omVO.getRentDays()%></p></td>
												</tbody>
												<%
													}
												%>
												<div class="cart-view-total">
													<table class="aa-totals-table">
														<tbody>
															<tr>
																<th>出租者評價</th>
																<td><input type="hidden" name="leaseRank"
																	value="<%=omVO.getLeaseRank() == null ? "" : omVO.getLeaseRank()%>">
																	<p><%=omVO.getLeaseRank() == 0 ? "尚未評分" : omVO.getLeaseRank()+"顆星"%></p>
																</td>
															</tr>
															<tr>
																<th>出租者評論</th>
																<td><input type="hidden" name="LeaseComt"
																	value="<%=omVO.getLeaseComt() == null ? "尚未評論" : omVO.getLeaseComt()%>">
																	<p><%=omVO.getLeaseComt() == null ? "尚未評論" : omVO.getLeaseComt()%></p></td>
															</tr>

															<tr>
																<th>我的評價</th>
																<td><p id="rank"><%=omVO.getRentRank() == 0 ? "尚未評分" : omVO.getRentRank()+"顆星"%></p></td>
															</tr>
															<tr>
																<th>我的評論</th>
																<td><p id="lc"><%=omVO.getRentComt() == null ? "尚未評論" : omVO.getRentComt()%></p></td>
															</tr>
														</tbody>
													</table>

													<table id="review">
														<tr>
															<th>我的評分</th>
														</tr>														
															<td bgcolor="#191561">
														<div class="stars" id="s">
															<input class="star star-5" id="star-5-2" onchange="test" type="radio" name="star" value="5" <%=omVO.getRentRank()== 5 ? "checked" : ""%>/> 
																<label class="star star-5" for="star-5-2"></label> 
															<input class="star star-4" id="star-4-2" onchange="test" type="radio" name="star" value="4" <%=omVO.getRentRank()== 4 ? "checked" : ""%>/> 
																<label class="star star-4" for="star-4-2"></label> 
															<input class="star star-3" id="star-3-2" onchange="test" type="radio" name="star" value="3" <%=omVO.getRentRank()== 3 ? "checked" : ""%>/> 
																<label class="star star-3" for="star-3-2"></label> 
															<input class="star star-2" id="star-2-2" onchange="test" type="radio" name="star" value="2" <%=omVO.getRentRank()== 2 ? "checked" : ""%>/> 
																<label class="star star-2" for="star-2-2"></label> 
															<input class="star star-1" id="star-1-2" onchange="test" type="radio" name="star" value="1" <%=omVO.getRentRank()== 1 ? "checked" : ""%>/> 
																<label class="star star-1" for="star-1-2"></label>
														</div>	
															</td>
														<tr>
															<th>我的評價</th>
														</tr>
														<tr>
															<td>
																<div class="rev-box">
                													<textarea class="review" col="30" name="rentComt" placeholder="在此填寫您的評價"></textarea>
              														<input type="hidden" name="rentRank" id="rentRank">
																	<input type="hidden" name="action" value="update_rent_comment"> 
																	<input type="hidden" name="ordID" value="<%=omVO.getOrdID()%>">
              														<input type="submit" value="送出評價 !">
           														</div>
															</td>													
														</tr>
													</table>
													<center><a href="<%=request.getContextPath()%>/front_end/order/listSuccessOrderForRent.jsp">回前頁</a></center>
												</div>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
<!-- 			<input type="hidden" name="leaseRank" id="leaseRank"> -->
<!-- 			<input type="hidden" name="action" value="update_lease_comment">  -->
<%-- 			<input type="hidden" name="ordID" value="<%=omVO.getOrdID()%>"> --%>
<%-- 			<c:forEach var="olVO" items="${olDAO.getAllOrderList()}"> --%>
<%-- 				<input type="hidden" name="listID" value="${olVO.listID}"> --%>
<%-- 			</c:forEach> --%>
			<%-- 				<input type="hidden" name="listID" value="<%=olVO.getListID()%>"> --%>
<%-- 			<input type="hidden" name="rentComtdate" value="${OrderMasterVO.rentComtdate}">  --%>
<%-- 			<input type="hidden" name="leaseComtdate" value="${OrderMasterVO.leaseComtdate}"> --%>
<%-- 			<center> --%>
<!-- 				<input type="submit" value="確認更新"> -->
<%-- 			</center> --%>
			</main>
		</div>
		<%@ include file="/includeFolder/footer2.file"%>
	</FORM>
</body>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

var test = $("#s");
var rank = $("#rank");
var lc = $("#lc");
console.log((rank).html());
console.log((lc).html());

if((rank).html() != "尚未評分"){
	document.getElementById("review").setAttribute("style","display: none;");
}



test.change(function () {
    //     alert($('input[name=star]:checked').val());
    console.log($('input[name=star]:checked').val());
    var rentRank = $('input[name=star]:checked').val();
    document.getElementById("rentRank").setAttribute('value', rentRank);
    rank.text(rentRank + "顆星");
});

console.log($("#rentRank").val());





	var shipDate = $("#shipDate");
	var getShipDate = $("#getShipDate");
	var shipTimelong = $("#shipTimelong");

	function ShowShipDate() {

		var Today = new Date();
		var shipTime = (Today.getFullYear() + "-" + (Today.getMonth() + 1)
				+ "-" + Today.getDate() + " " + Today.getHours() + ":"
				+ Today.getMinutes() + ":" + Today.getSeconds());
		shipDate.text(shipTime);
		document.getElementById("getShipDate").setAttribute('value', shipTime);
		var shipTimelong = (Today.getTime());
		document.getElementById("shipTimelong").setAttribute('value',
				shipTimelong);

	};

	var arrivalDate = $("#arrivalDate");
	var getArrivalDate = $("#getArrivalDate");
	var arrivalTimelong = $("#arrivalTimelong");

	function ShowArrivalDate() {
		var Today = new Date();
		var arrivalTime = (Today.getFullYear() + "-" + (Today.getMonth() + 1)
				+ "-" + Today.getDate() + " " + Today.getHours() + ":"
				+ Today.getMinutes() + ":" + Today.getSeconds());
		arrivalDate.text(arrivalTime);
		document.getElementById("getArrivalDate").setAttribute('value',
				arrivalTime);
		var arrivalTimelong = (Today.getTime());
		document.getElementById("arrivalTimelong").setAttribute('value',
				arrivalTimelong);

	};

	var returnDate = $("#returnDate");
	var getReturnDate = $("#getReturnDate");
	var returnTimelong = $("#returnTimelong");

	function ShowReturnDate() {
		var Today = new Date();
		var returnTime = (Today.getFullYear() + "-" + (Today.getMonth() + 1)
				+ "-" + Today.getDate() + " " + Today.getHours() + ":"
				+ Today.getMinutes() + ":" + Today.getSeconds());
		returnDate.text(returnTime);
		document.getElementById("getReturnDate").setAttribute('value',
				returnTime);
		var returnTimelong = (Today.getTime());
		document.getElementById("returnTimelong").setAttribute('value',
				returnTimelong);

	};
</script>
</html>
