<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="com.product.model.ProdService"%>
<%@page import="com.product.model.ProdVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.memberservice.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://www.itxst.com/js/jquery.js"></script>
<script src="https://www.itxst.com/package/artDialog/artDialog.js"></script>
<link href="https://www.itxst.com/package/artDialog/skins/default.css"
	rel="stylesheet" />
<%
	ProdService prodSvc = new ProdService();
	List<ProdVO> list = prodSvc.getAll();
	list = list.stream().sorted(Comparator.comparing(ProdVO::getProdID)).collect(Collectors.toList());
	if (request.getAttribute("list") != null) {
		list = (List<ProdVO>) request.getAttribute("list");
	}

	pageContext.setAttribute("list", list);
%>

<html>
<head>
<title>商品列表</title>
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
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	margin-right: 10px;
	border: 1px solid #999;
	text-align: center;
	background-color: #F5D998;;
	height: 720px;
}

/*--------------------main區域-------------------- */
main.main {
	background-color: #F0F0F0;
	width: calc(100% - 200px - 10px);
	height: 720px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}

table {
	width: 80%;
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

table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: red;
	display: inline;
}

table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	font-size: 10px;
	border: 1px solid #CCCCFF;
}

th, td {
	height: 100px padding: 5px;
	text-align: center;
}

.pic {
	object-fit: contain;
	width: 95px;
	height: 80px;
}


.class1 {
	background-color: #FFF0AC;
}

input {
	background-color: #FFF0AC;
}

#table2 {
	background-color: #6A6AFF;
	color: white;
	font-weight: bold;
}

a.aa-add-to-cart-btn {
	width: 100%;
	height: 100%;
	margin: 0px;
}
</style>

</head>
<body>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main">
			<table id="table-1">
				<tr>
					<td>

						<h4>
							<a
								href="<%=request.getContextPath()%>/back_end/problemtype/select_page.jsp">回首頁</a>
						</h4>
					</td>
				</tr>

			</table>



			<table id="table2">
				<div>

					<tr>
						<td><a class="aa-add-to-cart-btn"
							href="<%=request.getContextPath()%>/back_end/product/productManager.jsp">全部商品</a></td>
						<td><a class="aa-add-to-cart-btn"
							href="<%=request.getContextPath()%>/msg/MsgProdServlet?action=selectItem&value=2">被檢舉商品</a></td>
						<td><a class="aa-add-to-cart-btn"
							href="<%=request.getContextPath()%>/msg/MsgProdServlet?action=selectItem&value=1">上架中</a></td>
						<td><a class="aa-add-to-cart-btn"
							href="<%=request.getContextPath()%>/msg/MsgProdServlet?action=selectItem&value=0">下架中</a></td>
						<td><a class="aa-add-to-cart-btn"
							href="<%=request.getContextPath()%>/msg/MsgProdServlet?action=selectItem&value=9">停用中</a></td>
					</tr>


				</div>
			</table>



			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/prod/SuspensionServlet"
				name="form1" enctype="multipart/form-data">
				<table style="font-size: 20px">
					<tr>
						<th style="text-align: center;">商品編號</th>
						<th style="text-align: center;">商品名稱</th>
						<th style="text-align: center;">商品租金</th>
						<th style="text-align: center;">商品價值</th>
						<th style="text-align: center;">商品類別</th>
						<th style="text-align: center;">商品處理</th>
						<th style="text-align: center;">查看檢舉內容</th>


					</tr>
					<jsp:useBean id="cateSvc" scope="page"
						class="com.category.model.ProdCategoryService" />
					<%@ include file="page1.file"%>

					<c:forEach var="prodVO" items="${list}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>">

						<tr>
							<td><a
								href="/TFA104G1/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">${prodVO.prodID}</a></td>
							<td><a
								href="/TFA104G1/front_end/product/prodDetail.jsp?prodID=${prodVO.prodID}">${prodVO.prodName}</a></td>
							<td>${prodVO.prodRent}</td>
							<td>${prodVO.prodPrice}</td>
							<td>${cateSvc.findCategoryByPK(prodVO.categoryID).categoryName}</td>


							<td><span class="span_status"> <c:choose>
										<c:when test="${prodVO.prodStatus=='0'}">
											<label style='color: blue'>下架</label>
										</c:when>
										<c:when test="${prodVO.prodStatus=='1'}">
											<label style='color: green'>上架</label>
										</c:when>
										<c:when test="${prodVO.prodStatus=='9'}">
											<label style='color: red'>停用</label>
										</c:when>

									</c:choose>

							</span>&nbsp&nbsp&nbsp <input type="hidden" name="prodID"
								value="${prodVO.prodID}"> <select name="prodStatus"
								size="1" class="prodStatus">

									<c:if test="${prodVO.prodStatus==0 }">
										<option value="0">下架</option>
										<option value="1">上架</option>
										<option value="9">停用</option>
									</c:if>
									<c:if test="${prodVO.prodStatus==1 }">
										<option value="1">上架</option>
										<option value="0">下架</option>
										<option value="9">停用</option>
									</c:if>
									<c:if test="${prodVO.prodStatus==9 }">
										<option value="9">停用</option>
										<option value="0">下架</option>
										<option value="1">上架</option>
									</c:if>

							</select></td>

							<jsp:useBean id="msSvc" scope="page"
								class="com.memberservice.model.MemberServiceService" />
							<c:set var="count" value="0" />
							<c:forEach var="msVO" items="${msSvc.all}">
								<c:if test="${msVO.prodID==prodVO.prodID  }">



									<c:if test="${count== 0}">
										<td><a class=""
											href="<%=request.getContextPath()%>/back_end/memberservice/listOneProblemMsg.jsp?prodID=${prodVO.prodID}"><img
												style="height: 40px"
												src="https://i.pinimg.com/originals/0c/50/95/0c509522f742e45c2c505033458a4791.png"></a></td>
										<c:set var="count" value="1" />
									</c:if>
								</c:if>
							</c:forEach>
							<td style="height: 40px"></td>

						</tr>

					</c:forEach>
				</table>
				<input type="hidden" name="action" value="offShelf">

			</FORM>
			<%@ include file="page2.file"%>

		</main>
	</div>



	<script>
		$("a.findmsg").click(function() {
			a();
			return false;
		});

		function a() {
			art.dialog({
				content : 'hello world!'
			})
		}

		$("select.prodStatus")
				.change(
						function() {

							var that = $(this).closest('td').find('input')
									.eq(0).val()
							// 		alert("123")
							var status = $(this).val();
							console.log(status)
							var spanStatus = $(this).closest('tr').find(
									'span.span_status').eq(0);
							console.log(spanStatus);
							$
									.ajax({
										url : "/TFA104G1/prod/SuspensionServlet",
										type : "POST",
										cache : false,
										data : {
											prodID : that,
											action : "offShelf",
											status : status
										},
										success : function(data) {
											console.log(data);
											if (data == 1) {
												$(spanStatus)
														.html(
																"<label style='color:green'>上架</label>");
											} else if (data == 9) {
												$(spanStatus)
														.html(
																"<label style='color:red'>停用</label>");
											} else if (data == 0) {
												$(spanStatus)
														.html(
																"<label style='color:blue'>下架</label>");
											}

										},
										error : function(e) {
											console.log("失敗");
										}
									});

						});
	</script>
</body>

</html>