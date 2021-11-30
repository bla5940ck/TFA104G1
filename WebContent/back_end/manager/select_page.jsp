<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>

<title>IBM Manager: Home</title>
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
   <tr><td><h3>IBM Manager: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Manager: Home</p>

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
  <li><a href='<%=request.getContextPath()%>/back_end/manager/listAll.jsp'>List all Managers.</a><br><br></li>
  

  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ManagerServlet" >
        <b>輸入管理者編號 :</b>
        <input type="text" name="managerID">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="msSvc" scope="page" class="com.manager.model.ManagerService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ManagerServlet" >
       <b>選擇管理員編號:</b>
       <select size="1" name="managerID">
         <c:forEach var="managerVO" items="${msSvc.all}" > 
          <option value="${managerVO.managerID}">${managerVO.managerID}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ManagerServlet" >
       <b>選擇管理員姓名:</b>
       <select size="1" name="managerID">
         <c:forEach var="managerVO" items="${msSvc.all}" > 
          <option value="${managerVO.managerID}">${managerVO.managerName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>管理員管理</h3>

<ul>
  <li><a href='addManager.jsp'>Add a new Manager.</a></li>
</ul>
</body>
</html>