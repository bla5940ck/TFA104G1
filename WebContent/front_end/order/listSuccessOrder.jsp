<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.stream.Collectors"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<%
	Integer memID = (Integer) session.getAttribute("id");
	OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();

	OrderMasterService omSVC = new OrderMasterService();
	List<OrderMasterVO> list = omSVC.getAll();

	List<OrderMasterVO> list2 =list.
								stream()
									.filter(o->o.getLeaseID()==memID)
										.filter(o->o.getOrdStatus()==2)
											.collect(Collectors.toList());

	if(request.getAttribute("list") != null){
		list2 = (List)request.getAttribute("list");
	}
	
	pageContext.setAttribute("list", list2);
%>
<jsp:useBean id="prodSVC" scope="page" class="com.product.model.ProdService" />
<jsp:useBean id="memSVC" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="mcoSVC" scope="page" class="com.member_coupon.model.MemcouponService" />
<jsp:useBean id="daSVC" scope="page" class="com.member.model.DefAddressService" />

<html>
<head>
<meta charset="UTF-8">
<title>訂單狀態查詢</title>
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
	width: 150px;
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
	width: calc(100% - 150px - 10px);
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
	font-size: 12px;
}

table, th, td {
	border: 1px solid lightgrey;
}

th, td {
	padding: 5px;
	text-align: left;
}
</style>
</head>

<body bgcolor='white'>
	<%@ include file="/includeFolder/header.file"%>
	<div class="main_content">
	<%@ include file="/includeFolder/leaseMemberAside.file"%>
		<main class="main">
		<jsp:useBean id="OrdserListSvc" scope="page" class="com.order.model.OrderListService" />

			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<div>
				 <h5>依日期查詢訂單</h5>
				 <FORM id="DATE" METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
						 起始日期: <input name="startDate" id="f_date1" type="text" style="width: 75px;">
						 結束日期: <input name="endDate" id="f_date2" type="text" style="width: 75px;">
						<input type="hidden" name="action" value="get_date_forLease_order">
					</FORM>
			</div>
			<table id="table-1">
				<tr>
					<th>訂單編號</th>
					<th>承租者</th>
					<th>交易方式</th>
					<th>折價券</th>

					<th>訂單狀態</th>
					<th>訂單日期</th>

					<th>出貨日期</th>
					<th>到貨日期</th>
					<th>歸還日期</th>
					<th>承租天數</th>
					<th>訂單金額</th>
				</tr>
				<%@ include file="pageForLease.file"%>
				<c:forEach var="omVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">		 
							<tr>
								<td>${omVO.ordID}</td>
								<td>${memSVC.getOneMember(omVO.rentID).name}</td>
								<c:choose>
									<c:when test="${omVO.payID == '1'}">
										<td>信用卡</td>
									</c:when>
									<c:otherwise>
										<td>面交</td>
									</c:otherwise>
								</c:choose>

								<jsp:useBean id="mcDAO" class="com.member_coupon.model.MemcouponDAO" />
								<c:set var="count" value="0"/>
									<c:forEach var="mcVO" items="${mcoSVC.getAll()}">
										<c:if test="${count==0}">
											<c:choose>
												<c:when test="${omVO.couponID =='' || omVO.couponID == null}">
													<td>無</td>
												</c:when>
												<c:when test="${true}">
													<td>${mcVO.coupon_name}</td>
												</c:when>
											</c:choose>
												<c:set var="count" value="1"/>
										</c:if>
									</c:forEach>


								<c:choose>
									<c:when test="${omVO.ordStatus == '0'}">
										<td>已成立</td>
									</c:when>
									<c:when test="${omVO.ordStatus == '1'}">
										<td>待歸還</td>
									</c:when>
									<c:when test="${omVO.ordStatus == '2'}">
										<td>已完成</td>
									</c:when>
									<c:otherwise>
										<td>已取消</td>
									</c:otherwise>
								</c:choose>

								<td><fmt:formatDate value="${omVO.ordDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${omVO.shipDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${omVO.arrivalDate}"
										pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${omVO.returnDate}"
										pattern="yyyy-MM-dd" /></td>
								<td>${omVO.rentDays}</td>
								<td>${omVO.ordPrice}</td>
								<td>
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/OrderMasterServlet"
										style="margin-bottom: 0px;">
										<input type="submit" value="評價"> 
										<input type="hidden" name="ordID" value="${omVO.ordID}"> 
										<input type="hidden" name="action" value="getComment_For_Display">
									</FORM>
								</td>
							</tr>
				</c:forEach>
			</table>
			<%@ include file="page2.file"%>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link   rel="stylesheet" type="text/css" href="datetimepicker/jquery.datetimepicker.css" />
<script src="datetimepicker/jquery.js"></script>
<script src="datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
$("#f_date1").blur(function(){
// 	alert(1);
	console.log($("#f_date1").val());
	if($("#f_date1").val() != null && $("#f_date1") != ''){		
		$("#f_date2").blur(function(){
			console.log($("#f_date2").val());
			if($("#f_date2").val != null && $("#f_date2") != ''){
				$("#DATE").submit();
// 				$.ajax({
<%-- 					url:"<%=request.getContextPath()%>/OrderMasterServlet", --%>
// 					type:"POST",
// 					data:{
// 						startDate:($("#f_date1").val()),
// 						endDate:($("#f_date2").val()),
// 						action:"get_Date_Order",
			
// 					},
// 						dataType:"json",
// 				});
			}		
		})	
	}	
});

        $.datetimepicker.setLocale('zh'); // kr ko ja en
        $("#f_date1").datetimepicker({
           theme: '',          //theme: 'dark',
           timepicker: false,   //timepicker: false,
           step: 1,            //step: 60 (這是timepicker的預設間隔60分鐘)
	       format: 'Y-m-d H:i:s',
	       value:'',
        });
        $("#f_date2").datetimepicker({
           theme: '',          //theme: 'dark',
           timepicker: false,   //timepicker: false,
           step: 1,            //step: 60 (這是timepicker的預設間隔60分鐘)
	       format: 'Y-m-d H:i:s',
	       value:'',
        });

</script>

</html>