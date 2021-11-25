<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
   <tr><td><h3>Promo: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for Promo: Home</p>

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
  <li><a href='listAll_promo.jsp'>List</a> all Promo.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="promo.do" >
        <b>輸入員工編號 (如7001):</b>
        <input type="text" name="promo_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="promoSvc" scope="page" class="com.promo.model.PromoService" />
   
  <li>
     <FORM METHOD="post" ACTION="promo.do" >
       <b>選擇員工編號:</b>
       <select size="1" name="promo_id">
         <c:forEach var="promoVO" items="${promoSvc.all}" > 
          <option value="${promoVO.promo_id}">${promoVO.promo_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="promo.do" >
       <b>選擇員工姓名:</b>
       <select size="1" name="promo_id">
         <c:forEach var="promo_id" items="${promoSvc.all}" > 
          <option value="${promoVO.promo_id}">${promoVO.promo_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>員工管理</h3>

<ul>
  <li><a href='add_promo.jsp'>Add</a> a new Emp.</li>
</ul>

</body>
</html>