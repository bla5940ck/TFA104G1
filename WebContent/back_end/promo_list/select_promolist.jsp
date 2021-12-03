<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>專案明細管理區</title>
<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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
</style>
</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>專案明細</h3><h4>( MVC )</h4></td></tr>
</table>

<p>專案明細</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAll_promolist.jsp'>專案列表</a><br><br></li>
  

  <jsp:useBean id="promolistSvc" scope="page" class="com.promo_list.model.PromolistService" />
   
  <li>
     <FORM METHOD="post" ACTION="promolist.do" >
       <b>選擇折價券編號:</b>
       <select size="1" name="coupon_id">
         <c:forEach var="promolistVO" items="${promolistSvc.all}" > 
          <option value="${promolistVO.coupon_id}">${promolistVO.coupon_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
<!--   <li> -->
<!--      <FORM METHOD="post" ACTION="promo.do" > -->
<!--        <b>選擇員工姓名:</b> -->
<!--        <select size="1" name="status"> -->
<%--          <c:forEach var="status" items="${promoSvc.all}" >  --%>
<%--           <option value="${promoVO.status}">${promoVO.status} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--      </FORM> -->
<!--   </li> -->
</ul>


<h3>新增專案明細</h3>

<ul>
  <li><a href='add_promolist.jsp'>新增專案明細</li>
</ul>

</body>
</html>