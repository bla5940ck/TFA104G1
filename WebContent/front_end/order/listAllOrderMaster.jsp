<%@page import="com.member_coupon.model.MemcouponVO"%>
<%@page import="com.member_coupon.model.MemcouponDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.member.model.DefAddressJDBCDAO"%>
<%@page import="com.member.model.DefAddressVO"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.member.model.MemberService"%>
<%@page import="com.member.model.MemberDAO_interface"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>
<%@page import="com.product.model.*"%>
<%@page import="java.util.stream.Collectors"%>

<!DOCTYPE html>
<html>
<head>
<title>所有訂單資料</title>
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<%
	MemcouponDAO memDAO = new MemcouponDAO();
	List <MemcouponVO> memVO = memDAO.getAll();
	for(MemcouponVO name : memVO){
// 		System.out.println(name.getCoupon_name());
	}

	Integer memID = (Integer) session.getAttribute("id");
// 	System.out.println("會員編號 : " + memID);
	DefAddressJDBCDAO dadao = new DefAddressJDBCDAO();
	List<DefAddressVO> daVO = dadao.getAll();

	OrderMasterService omSVC = new OrderMasterService();
	
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
	List<OrderMasterVO> list = omSVC.getAll();
	
	List<OrderMasterVO> list2 =list.
								stream()
									.filter(o->o.getLeaseID().equals(memID))
										.collect(Collectors.toList());
	if(request.getAttribute("list") != null){
		list2 = (List) request.getAttribute("list");
	}
	
	
	pageContext.setAttribute("list", list2);
%>
<jsp:useBean id="memSVC" scope="page"
	class="com.member.model.MemberService" />
<jsp:useBean id="mcoSVC" scope="page"
	class="com.member_coupon.model.MemcouponService" />
<jsp:useBean id="daSVC" scope="page"
	class="com.member.model.DefAddressService" />

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
			height:865px;
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
			width: 100%;
			background-color: white;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		
		table, th, td {
			border: 1px solid #CCCCFF;
		}
		
		.cart-img{
			display: block;
  			width: 50%;
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
		
		.head{
/* 			border: 1px solid red;		 */
			display: inline-block;
			width: 100%;
		}
		.head2{
/* 		 	border: 1px solid red;		 */
			display: inline-block;
			width: 30%;
		}
		.head3{
/*   		border: 1px solid red;  */
			display: inline-block;
 			text-align:left; 
 			width: 100%;	
		}
		
		.div1{
/*   			border: 1px solid red;   */
			display: inline-block;
			width: 100%;
		}
		.div2{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 25%;
		}
		.div3{
/* 			border: 1px solid red; */
			display: inline-block;
			width: 25%;
		}
		.div4{
/* 			border: 1px solid red; */
			display: inline-block;
			position:relative;
			left:300px;
			width: 15%;
		}
		.div5{
/* 			border: 1px solid red; */
			position: absolute;
			margin-top: 0;
			display: inline-block;
			width: 15%;
		}
		</style>

</head>
<body bgcolor='white'>
	<%@ include file="/includeFolder/headerForLease.file"%>
	<div class="main_content">
	<%@ include file="/includeFolder/leaseMemberAside.file"%>
		<main class="main">
		<h1>我的訂單</h1>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
		<div class="head">
			<div class="head2">
				<jsp:useBean id="OrdserMasterSvc" scope="page" class="com.order.model.OrderMasterService" />
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
					<h5>選擇訂單編號 :  
					<select size="1" name="ordID">
						<c:forEach var="OrderMasterVO" items="${OrdserMasterSvc.all}">
							<c:if test="${OrderMasterVO.leaseID eq id}">
								<option value="${OrderMasterVO.ordID}">${OrderMasterVO.ordID}
							</c:if>
						</c:forEach>
					</select> 
					<input type="hidden" name="action" value="getOne_For_Display">
					<input class="check" type="submit" value="送出">				
					</h5>	
				</FORM>				
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
					<h5>依 月 份 查 詢 : 
					<select  name="month">
						<option value="1">1月</option>
						<option value="2">2月</option>
						<option value="3">3月</option>
					
						<option value="4">4月</option>
						<option value="5">5月</option>
						<option value="6">6月</option>
					
						<option value="7">7月</option>
						<option value="8">8月</option>
						<option value="9">9月</option>
					
						<option value="10" >10月</option>
						<option value="11" >11月</option>
						<option value="12">12月</option>
					</select>
					<input type="hidden" name="action" value="get_Date_Display"> 
					<input class="check" type="submit" value="送出">
				</h5>
				</FORM>
			</div>		
			</div>
			<div class="head3">
			<a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listAllOrderMaster.jsp">全部</a>
			<a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listStatusOrderMaster.jsp?ordStatus=0">已成立</a>
			<a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listStatusOrderMaster.jsp?ordStatus=1">待歸還</a>
			<a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listStatusOrderMaster.jsp?ordStatus=2">已完成</a>
			<a class="aa-browse-btn" href="<%=request.getContextPath()%>/front_end/order/listStatusOrderMaster.jsp?ordStatus=9">已取消</a>
			</div>
			<%@ include file="pageForLease.file"%>
			<div class="div1">
				<hr style="border: 1px solid black;">	
				<c:forEach var="omVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">		 
				<div class="div2">
				<ul>
					<h4>訂單編號 : ${omVO.ordID}</h4>
					<li>承租者 : ${memSVC.getOneMember(omVO.rentID).name}</li>
					<li>交易方式 : 
						<c:choose>
							<c:when test="${omVO.payID == '1'}">超商店到店</c:when>
							<c:otherwise>面交</c:otherwise>
						</c:choose>
					</li>
					<li>折價券 : 
					<jsp:useBean id="mcDAO" class="com.member_coupon.model.MemcouponDAO" />
					<c:set var="count" value="0"/>
					<c:forEach var="mcVO" items="${mcoSVC.getAll()}">
						<c:if test="${count==0}">
							<c:choose>
								<c:when test="${omVO.couponID =='' || omVO.couponID == null}">無</c:when>
								<c:when test="${true}">${mcVO.coupon_name}</c:when>
							</c:choose>
						<c:set var="count" value="1"/>
						</c:if>
					</c:forEach>
					</li>
					<li>運送狀態 : 
					<c:choose>
						<c:when test="${omVO.shipStatus == '0'}">待出貨</c:when>
						<c:when test="${omVO.shipStatus == '1'}">已出貨</c:when>
						<c:when test="${omVO.shipStatus == '2'}">待取貨</c:when>
						<c:when test="${omVO.shipStatus == '3'}">取貨完成</c:when>
						<c:otherwise>商品遺失</c:otherwise>
					</c:choose>
					</li>
					<li>付款狀態 : 
					<c:choose>
						<c:when test="${omVO.payStatus == '0'}">待付款</c:when>
						<c:otherwise>已付款</c:otherwise>
					</c:choose>
					</li>
					<li>訂單狀態 : 
					<c:choose>
						<c:when test="${omVO.ordStatus == '0'}">已成立</c:when>
						<c:when test="${omVO.ordStatus == '1'}">待歸還</c:when>
						<c:when test="${omVO.ordStatus == '2'}">已完成</c:when>
						<c:otherwise>已取消</c:otherwise>
					</c:choose>
					</li>
					</ul>
				</div>
				<div class="div3">
					<ul>
						<li>訂單日期 : <fmt:formatDate value="${omVO.ordDate}" pattern="yyyy-MM-dd" /></li>						
						<li>出貨日期 : 
							<c:choose>
								<c:when test="${omVO.shipDate != null}">
									<fmt:formatDate value="${omVO.shipDate}" pattern="yyyy-MM-dd" />
								</c:when>
								<c:otherwise>待出貨</c:otherwise>
							</c:choose>
						</li>
						<li>到貨日期 : 
							<c:choose>
								<c:when test="${omVO.arrivalDate != null}">
									<fmt:formatDate value="${omVO.arrivalDate}" pattern="yyyy-MM-dd" />
								</c:when>
								<c:otherwise>尚未到貨</c:otherwise>
							</c:choose>
						</li>				
						<li>歸還日期 : 
							<c:choose>
								<c:when test="${omVO.returnDate != null}">
									<fmt:formatDate value="${omVO.returnDate}" pattern="yyyy-MM-dd" />
								</c:when>
								<c:otherwise>待歸還</c:otherwise>
							</c:choose>
						</li>
						<li>承租天數 : ${omVO.rentDays}</li>
						<li>訂單金額 : ${omVO.ordPrice}</li>
					</ul>
				</div>
				<div class="div5">
				<jsp:useBean id="olDAO"	class="com.order.model.OrderListDAOImpl" /> 
					<c:forEach var="olVO" items="${olDAO.findOrderListByOrdID(omVO.ordID)}">
						<img class="cart-img" src="<%=request.getContextPath()%>/prod/ProdServlet?action=detail&no=1&prodID=${olVO.prodID}"alt="img"></a>
					</c:forEach>
				</div>	
				<div class="div4">
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/OrderMasterServlet"style="margin-bottom: 0px;">
						<input class="aa-browse-btn" type="submit" value="狀態修改"> 
						<input type="hidden" name="ordID" value="${omVO.ordID}">
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
					<br>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderListServlet" style="margin-bottom: 0px;">
						<input class="aa-browse-btn" type="submit" value="查看明細"> 
						<input type="hidden" name="ordID" value="${omVO.ordID}"> 
						<input type="hidden" name="action" value="getlist_For_Display">
					</FORM>
				</div>
				<hr style="border: 1px solid black;">
				</c:forEach>
			</div>
			<%@ include file="page2.file"%>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="datetimepicker/jquery.datetimepicker.css" />
<script src="datetimepicker/jquery.js"></script>
<script src="datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>
<script>
 $.datetimepicker.setLocale('zh'); // kr ko ja en
        $("#f_date1").datetimepicker({
           theme: '',          //theme: 'dark',
           timepicker: false,   //timepicker: false,
           step: 1,            //step: 60 (這是timepicker的預設間隔60分鐘)
	       format: 'Y-m',
	       value:'',
	       changeMonth: true,
        });
 </script>
</html>