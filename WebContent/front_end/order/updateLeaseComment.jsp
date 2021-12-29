<%@page import="com.member.model.MemberVO"%>
<%@page import="com.member.model.MemberJDBCDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.order.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>訂單資料更新:</title>
<%
	Integer memID = (Integer) session.getAttribute("id");
	OrderMasterVO omVO = (OrderMasterVO) request.getAttribute("OrderMasterVO");
%>

<%
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String formatDate = df.format(new java.util.Date());
%>
<jsp:useBean id="olDAO" class="com.order.model.OrderListDAOImpl" />



<style>
		* {
			box-sizing: border-box;
			text-decoration: none;
			list-style: none;
		}
		
		body {
			margin: 0;
			padding: 0px;
		}
		
		img {
			max-width: 100%;
		}
		
		header.header {
			background-color: #ddd;
			width: 100%;
			margin: 0 auto 0px auto;
			border: 1px solid #999;
		}
		
		@media all and (min-width:576px) and (max-width:767.98px) {
			header.header {
				width: 540px;
			}
		}
		
		@media ( max-width :575.98px) {
			header.header {
				width: 100%;
			}
		}
		
		div.main_content {
			width: 100%;
			margin: 0 auto;
			font-size: 0;
			/*   border:1px solid red; */
		}
		
		@media all and (min-width:576px) and (max-width:767.98px) {
			div.main_content {
				width: 540px;
			}
		}
		
		@media ( max-width :575.98px) {
			div.main_content {
				width: 100%;
			}
		}
		/*-------------------aside區域------------------- */
		aside.aside {
			height:800px;
			width: 200px;
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			margin-right: 6px;
			margin-left: 4px;
			border: 1px solid #999 ;
			border-color: transparent #191561 transparent transparent;
		}
		
		/*--------------------main區域-------------------- */
		main.main {
			background-color: white;
			width: calc(100% - 200px - 10px);
			display: inline-block;
			vertical-align: top;
			font-size: 1rem;
			border: 1px solid white;
			padding: 0px;
		}
		
		@media ( max-width : 575.98px) {
			aside.aside, main.main {
				display: block;
			}
			aside.aside {
				width: 100%;
				margin: 0 0 10px 0;
			}
			main.main {
				width: 100%;
			}
		}
		
		footer.footer {
			background-color: #ddd;
			width: 100%;
			margin: 10px auto 0 auto;
			border: 1px solid #999;
		}
		
		@media all and (min-width:576px) and (max-width:767.98px) {
			footer.footer {
				width: 540px;
			}
		}
		
		@media ( max-width :575.98px) {
			footer.footer {
				width: 100%;
			}
		}
		
		/*--------------------table區域-------------------- */
		table {
			width: 80%;
			background-color: white;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		
		table, th, td {
/* 			border: 1px solid #CCCCFF; */
		}
		
		.cart-img{
			display: block;
  			width: 100%;
  			height: auto;
  			margin: 0 auto
			
			
		}
		.dateBtn{
		    background-color: #191561;
   			border: 1px solid #191561;
   			color: white;
		}
		.check{
		    background-color: #191561;
   			border: 1px solid #191561;
   			color: white;
		}
		.div1{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 100%;
		}
		.div2{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 15%;
		}
		.div3{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 15%;
		}
		.div4{
/* 			border: 1px solid red; */
			display: inline-block;
			position:relative;
			left:205px;
			width: 15%;
		}
		.div5{
/* 			border: 1px solid red; */
			position: absolute;
			margin-top: 0;
			display: inline-block;
			width: 15%;
		}
		
		.aa-totals-table{
/* 			border: 1px solid red;  */
			display: inline-block;
			width: 100%;
		}
		
		.rankarea{
/* 			border: 1px solid red;  */
			display: inline-block;
			widows: 40%;
		}
		.mine{
/* 			border: 1px solid red;  */
			display: inline-block;
			width: 37%;
			vertical-align: top;
		}
        @import url(https://fonts.googleapis.com/css?family=Roboto:500,100,300,700,400);

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

        div.title {
            font-size: 2em;
            display: inline-block;
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
<%
OrderListDAOImpl oldao = new OrderListDAOImpl();
System.out.println(omVO.getOrdID());
List<OrderListVO> list = oldao.findOrderListByOrdID(omVO.getOrdID());

for (OrderListVO olVO : list) {
	ProdDAO prodDAO = new ProdDAO();
	ProdVO prodVO = prodDAO.findProductByPK(olVO.getProdID());
	MemberJDBCDAO memDAO = new MemberJDBCDAO();
	MemberVO memVO = memDAO.findByPrimaryKey(omVO.getRentID());
%>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
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
			<%@ include file="/includeFolder/leaseMemberAside.file"%>
			<main class="main">
			<br>
			<h1>訂單評價</h1>
				<div class="div1">
					<div class="div2">
						<ul>
							<li>訂單編號 : <%=omVO.getOrdID()%></li>
							<li>商品名稱 : 
							<a id="prodName" href="<%=request.getContextPath()%>/front_end/product/prodDetail.jsp?prodID=<%=olVO.getProdID()%>"><%=prodVO.getProdName()%></a>
							</li>
							<li>承租者 : <%=memVO.getName()%></li>
							<li>商品租金 : <%=olVO.getProdPrice()%> 元</li>
							<li>訂單日期 : <fmt:formatDate value="<%=omVO.getOrdDate()%>" pattern="yyyy-MM-dd" /></li>
							<li>承租天數 : <%=omVO.getRentDays()%> 天</li>
							<li>總計金額 : <%=olVO.getProdPrice() * omVO.getRentDays()%> 元</li>
						</ul>
					</div>
						<div class="div3">
							<img class="cart-img" src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=<%=olVO.getProdID()%>"alt="img">
						</div>
					<hr style="border: 1px solid black;">
						<%
							}
						%>
					</div>	
					<div>
						<ul>
							<li>承租者評分 : <%=omVO.getRentRank() == 0 ? "尚未評分" : omVO.getRentRank()+"顆星"%></li>
							<li>承租者評論 : <%=omVO.getRentComt() == null || omVO.getRentComt().length() == 0 ? "尚未評論" : omVO.getRentComt()%></li>
						</ul>
					</div>
						<hr style="border: 1px solid black;">
						<div class="aa-totals-table">
						<div class="mine">
							<ul>
								<li style="font-size: large;">我的評分 : <p id="rank"><%=omVO.getLeaseRank() == 0 ? "尚未評分" : omVO.getLeaseRank()+"顆星"%></p></li>	
								<li style="font-size: large;">我的評論 : <p id="lc"><%=omVO.getLeaseComt() == null || omVO.getLeaseComt().length() == 0 ? "尚未評論" : omVO.getLeaseComt()%></p></li>	
							</ul>
						</div>
						<div class="rankarea">
						
						<table id="review">
																					
								<td bgcolor="#191561">
							<div class="stars" id="s">
								<input class="star star-5" id="star-5-2" onchange="test" type="radio" name="star" value="5" <%=omVO.getLeaseRank()== 5 ? "checked" : ""%>/> 
								<label class="star star-5" for="star-5-2"></label> 
								<input class="star star-4" id="star-4-2" onchange="test" type="radio" name="star" value="4" <%=omVO.getLeaseRank()== 4 ? "checked" : ""%>/> 
								<label class="star star-4" for="star-4-2"></label> 
								<input class="star star-3" id="star-3-2" onchange="test" type="radio" name="star" value="3" <%=omVO.getLeaseRank()== 3 ? "checked" : ""%>/> 
								<label class="star star-3" for="star-3-2"></label> 
								<input class="star star-2" id="star-2-2" onchange="test" type="radio" name="star" value="2" <%=omVO.getLeaseRank()== 2 ? "checked" : ""%>/> 
								<label class="star star-2" for="star-2-2"></label> 
								<input class="star star-1" id="star-1-2" onchange="test" type="radio" name="star" value="1" <%=omVO.getLeaseRank()== 1 ? "checked" : ""%>/> 
								<label class="star star-1" for="star-1-2"></label>
							</div>	
								</td>
							
							<tr>
								<td>
									<div class="rev-box">
                						<textarea class="review" col="30" name="leaseComt" placeholder="在此填寫您的評價"></textarea>
              							<input type="hidden" name="leaseRank" id="leaseRank">
										<input type="hidden" name="action" value="update_lease_comment"> 
										<input type="hidden" name="ordID" value="<%=omVO.getOrdID()%>">
              							<center><input class="aa-browse-btn" type="submit" value="送出評價 !">
										<a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listSuccessOrder.jsp">回前頁</a></center>
           							</div>
								</td>													
							</tr>
						</table>
						</div>
						</div>
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
    var leaseRank = $('input[name=star]:checked').val();
    document.getElementById("leaseRank").setAttribute('value', leaseRank);
    rank.text(leaseRank + "顆星");
});

console.log($("#leaseRank").val());

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
