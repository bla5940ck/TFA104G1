<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="com.member.model.*"%>
<%@page import="com.member_coupon.model.*"%>
<%@page import="com.promo_list.model.*"%>
<%@page import="com.member.model.*"%>
<%@page import="com.order.model.*"%>
<%@ page import="com.product.model.*"%>
<%
	ProdDAO prodDAO = new ProdDAO();
	ProdVO prodVO = prodDAO.findProductByPK(1);

	DefAddressJDBCDAO dadao = new DefAddressJDBCDAO();
	List<DefAddressVO> list2 = dadao.getAll();
	
	DefAddressVO daVO = new DefAddressVO();
	
	MemberJDBCDAO medao = new MemberJDBCDAO();
	MemberVO meVO = medao.findByPrimaryKey(1);

	MemcouponDAO mcdao = new MemcouponDAO();
	List<MemcouponVO> list = mcdao.getAll();
%>

<html>
<head>
<title>結帳 :</title>

<style>
* {
	box-sizing: border-box;
	text-decoration: none;
	list-style: none;
}

body {
	margin: 0;
	padding: 10px;
}

img {
	max-width: 100%;
}

header.header {
	background-color: #ddd;
	width: 100%;
	margin: 0 auto 10px auto;
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
	background-color: #ddd;
	width: 200px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: #ddd;
	width: calc(100% - 200px - 10px);
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
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

table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid black;	
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>

<body bgcolor='white'>
<%@ include file="header.file" %>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet" name="form1">
		<div class="main_content">
			<aside class="aside">
				<nav class="nav">
					<h1>標題</h1>
					<ul class="nav_list">
						<li><a href="#">連結</a></li>
						<li><a href="#">連結</a></li>
					</ul>
				</nav>
			</aside>
			<main class="main">
				<div>
					<h3>結帳頁面</h3>
				</div>

				<table id="table-1">
					<h3>確認以下資訊</h3>
					<li><a href="#">返回購物車</a></li>
					<tr>
						<td>商品名稱 :</td>
						<td><a id="prodName"
							href="<%=request.getContextPath()%>/product_view/productDetail.jsp?picno=1"><%=prodVO.getProdName()%></a></td>
					</tr>
					<tr>
						<td>預定租借起日:</td>
						<td><input name="estStart" id="#f_date1" type="text"></td>
					</tr>
					<tr>
						<td>預定租借訖日:</td>
						<td><input type="text" name="estEnd" id="#f_date2"></td>
					</tr>
					<tr>
						<td>承租天數:</td>
						<td><p id="rentDays"></p></td>
					</tr>
					<tr>
						<td>您的姓名:</td>
						<td><input type="hidden" name="rentID" value="<%=meVO.getMemberId()%>"><%=meVO.getName()%></td>
					</tr>
					
					<jsp:useBean id="poDAO"
						class="com.order.model.PaymentOptionsDAOImpl" />
					<tr>
						<td>選擇付款方式:</td>
						<td><select size="1" name="payID">
								<c:forEach var="poVO" items="${poDAO.getAllPaymentOptions()}">
									<option value="${poVO.payID}">${poVO.payName}
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td>選擇折價券:</td>
						<td><select size="1" name="couponID" id="cpn">
								<option id="disc" value="">
									<%
									for (int i = 0; i < list.size(); i++) {
										MemcouponVO mcVO = list.get(i);
										if (mcVO.getMember_id() == 3) {
											PromolistDAO pldao = new PromolistDAO();
											PromolistVO plVO = pldao.findByPrimaryKey(mcVO.getCoupon_id());
								%>
								
								<option id="disc" value="<%=mcVO.getCoupon_id()%>">!!<%=plVO.getCoupon_name()%>!!
									 可折扣 :
									<%=Math.round(plVO.getDiscount())%>元<br>
								</option>
								<%
									}
									}
								%>
						</select></td>
					</tr>
					<tr>
						<td>預設物流:</td>
						<td><select size="1" name="storeCode" id="cpn">
								<option value="0">我的超商選項
									<%									
									Integer id = meVO.getMemberId();
									for(int i = 0; i < list2.size(); i++){
										DefAddressVO daVO1 = list2.get(i);
										if(daVO1.getMemberId() == id){
								%>			
								<option id="def711" value="<%=daVO1.getCode711()%>"><%=daVO1.getName711()%> / <%=daVO1.getRecipient()%> / <%=daVO1.getRecptPhone()%><br>
								</option>
								<%
										}
									}
								%>
						</select></td>
					</tr>				
					<tr>
						<td>商品小計:</td>
						<td><input type="hidden" name="prodPrice" value="100">100</td>
					</tr>
					<tr>
						<td>折扣:</td>
						<td><p id="discount"></p></td>
					</tr>
					<tr>
						<td>運費:</td>
						<td><input type="hidden" name="shipFee" value="60">60</td>
					</tr>
					<tr>
						<td>訂單金額:</td>
						<td><input type="hidden" name="ordPrice" value="160">160</td>
					</tr>
				</table>
				<input type="hidden" name="action" value="submit_order">
				<input type="hidden" name="prodID" value="<%=prodVO.getProdID()%>"> 
				<input type="hidden" name="prodName" value="<%=prodVO.getProdName()%>">
				<input type="submit" value="送出訂單 !">
			</main>
		</div>
		<footer class="footer"> footer區域 </footer>
	</FORM>
	</head>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
//         $.datetimepicker.setLocale('zh');
//         $('#f_date1').datetimepicker({
// 	       theme: '',              //theme: 'dark',
// 	       timepicker:false,       //timepicker:true,
// 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
// 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
// 		   value: new Date(),   // value:   new Date(),
//            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
//            //startDate:	            '2017/07/10',  // 起始日
//            //minDate:               '-1970-01-01', // 去除今日(不含)之前
//            //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
//         });
</script>

</html> 