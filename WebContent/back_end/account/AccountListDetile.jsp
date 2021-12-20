<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.order.model.*"%>
<%@page import="java.sql.Timestamp"%>
<%

DefAddressJDBCDAO dadao = new DefAddressJDBCDAO();
List<DefAddressVO> daVO = dadao.getAll();
List<Integer> list1 = new ArrayList<>();
OrderMasterService ordserMasterSvc = new OrderMasterService();
OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
List<OrderMasterVO> list = ordserMasterSvc.getAll();

for (int i : list1) {
	System.out.println(i);
}
pageContext.setAttribute("list", list);

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account.JSP</title>
</head>
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


table {
	
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
    color: blue;
    display: inline;
  }
  .signOut{
background-color:#6495ed;
}
</style>

<style>
/*-------------------aside區域------------------- */
aside.aside {
	width: 200px;
	height: 720px;
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
	height: 720px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
}


  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }

</style>
<body>
	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
	<%@ include file="/includeFolder/managerAside.file"%>
	<main class="main">
	<table id="table-1">
	<tr><td>
		 <h3>待轉帳資料- AccountListDetile.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back_end/manager/afterLogin.jsp"><img src="<%=request.getContextPath()%>/front_end/member/img/index.jpg" width="100" height="32" border="0"></a></h4>
	</td></tr>
</table>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


	<div>
				<jsp:useBean id="OrdserMasterSvc" scope="page" class="com.order.model.OrderMasterService" />
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
					<b>選擇訂單編號:</b> 
					<select size="1" name="ordID">
						<c:forEach var="OrderMasterVO" items="${OrdserMasterSvc.all}">
							<c:if test="${OrderMasterVO.leaseID == id}">
								<option value="${OrderMasterVO.ordID}">${OrderMasterVO.ordID}
							</c:if>
						</c:forEach>
					</select> 
					<input type="hidden" name="action" value="getOne_For_Display">
					<input type="submit" value="送出">
				</FORM>

				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/OrderMasterServlet">
					<b>輸入訂單編號 (如1):</b> 
					<input type="text" name="ordID"> 
					<input type="hidden" name="action" value="getOne_For_Display"> 
					<input type="submit" value="送出">
				</FORM>
			</div>

<table>
	<tr>
		<!--  <th>選擇</th>-->
		<th>會員編號</th>
		<th>訂單編號</th>
		<th>訂單日期</th>
		<th>訂單金額</th>
		<th>訂單運費</th>
		<th>訂單應收金額</th>
		
		

	</tr>
	<%@ include file="page1.file" %> 
	  <c:forEach var="omVO"  items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
		<tr>
			<!--<td><input type="checkbox" value="修改"></td>  -->
			<td>${omVO.rentID}</td>
			<td>${omVO.ordID}</td>
			<td><fmt:formatDate value="${omVO.ordDate}"
										pattern="yyyy-MM-dd" /></td>
		
			
			<td>${omVO.ordPrice}</td>
			<td>${omVO.shipFee}</td> 
			<!--<td>${memberVO.status}</td>-->
		    <td>double(${omVO.ordPrice})-double(${omVO.shipFee})</td>
			
<%--
			<td>
			     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="停權" >
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			      <input type="hidden" name="action"  value="9"></FORM>
			</td>
		 --%>
		</tr>
</c:forEach> 
</table>
<%@ include file="page2.file" %>

			</main>
	</div>	
</body>
</html>