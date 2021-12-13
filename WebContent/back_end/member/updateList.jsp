<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
  MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //MemPdrServlet.java(Concroller), 存入req的memberVO物件

%>

<html>
<head>
<title>單筆會員資料審核 - updateList.jsp</title>

<style>
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
</style>

<style>
  table {
	width: 600px;
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

</head>
<body bgcolor='white'>

<!--  <h4>此頁暫練習採用 Script 的寫法取值:</h4>-->
<table id="table-1">
	<tr><td>
		 <h3>單筆會員資料審核 - updateList.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back_end/member/listAllPdrMember.jsp"><img src="<%=request.getContextPath()%>/front_end/member/img/LogingPIC.jpg" width="200" height="90" border="0">回首頁</a></h4>
	</td></tr>
</table>

<div></div>
<div></div>
<div></div>
<div></div>
<div></div>
<div></div>
<div></div>

<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemStatusServlet" style="margin-bottom: 0px;"> --%>

			    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemStatusServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="通過">
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			      <input type="hidden" name="status"  value="1"></FORM>

			 
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/member/MemStatusServlet" style="margin-bottom: 0px;">
			     <input type="submit" value="不通過">
			     <input type="hidden" name="memberId"  value="${memberVO.memberId}">
			      <input type="hidden" name="status"  value="9"></FORM>


<table>
	<tr>
		<th>註冊日期</th>
		<th>會員編號</th>
		<th>員工姓名</th>
		<th>出生日期</th>
		<th>身分證字號</th>
		<th>MAIL</th>
		<th>戶籍地址</th>
		<th>身分證正面</th>
		<th>身分證反面</th>
	</tr>
	<tr>
		<td><fmt:formatDate value="${memberVO.creatDate}" pattern="yyyy-MM-dd "/></td>
		<td><%=memberVO.getMemberId()%></td>
		<td><%=memberVO.getName()%></td>
		<td><fmt:formatDate value="${memberVO.birthday}" pattern="yyyy-MM-dd "/></td>
		<td><%=memberVO.getIdcn()%></td>
		<td><%=memberVO.getEmail()%></td>
		<td><%=memberVO.getAddress()%></td>
 		
	<%-- 	<td><%=memberVO.getIdcF()%></td> --%>  
	<%--<td width="300px"> --%>
	<%--			<c:if test="${empty memberVO.getIdcF()}" var="condition">
				<img src="<%=request.getContextPath()%>/front_end/img/images/X.png" width="200" height="200"/> 
				</c:if> --%>
		<%--		    <c:if test="${not empty memberVO.getIdcF()}" var="condition"> --%>
		<%--	    <img  src='<%=request.getContextPath()%>/member/MemStatusServlet?memberId=${memberVO.memberId}' width='300' height='200' /> --%> 
		<%--			</c:if> --%>
	<%--	<img id="preview_progressbarTW_img" src="#"  width="300px"   height="200px"  style = "display:none" />
			<input type="file" id="progressbarTWInput" name="ad_pic" size="25" accept="image/gif, image/jpeg, image/png" value="${memberVO.idcF}"/>
		--%>
	<%--	<c:set var="mimg" value="<%=memberVO.getIdcF()%>" /> --%>
		
		<%--
		  MemberService memSvc = new MemberService();
		  List<MemberVO> list = memSvc.getPdrMember();
		  MemberVO memberVO2 = null;
		  for (int i=0; i<list.size(); i++) {
			  if (memberVO.getMemberId() == list.get(i).getMemberId())
				  memberVO2 = list.get(i);
		  } --%>
	<%-- 	  <%
				byte b[] = (byte[]) pageContext.getAttribute("mimg");
			//	byte b[] = (byte[]) memberVO2.getIdcF();
						String movie_pic = Base64.encode(b);
						if (null == movie_pic ||"".equals(movie_pic))
							movie_pic ="1111";
				%>
		
		<img class="moviein_pic" src="data:image/jpg;base64,<%=movie_pic%>">
		
			</td> --%>

		<%-- <td>${memberVO.idcF}</td>  --%>
		<%--				<td>
		<%
		
					byte b[] = (byte[]) pageContext.getAttribute("mimg");
						String movie_pic = Base64.encode(b);
						if (null == movie_pic )
							movie_pic ="321";
				%>
		
		<img class="moviein_pic" src="data:image/jpg;base64,<%=movie_pic%>">

			</td>      
			<td><%=memberVO.getIdcB()%></td>
			--%>
			
			
			<!-- 身分證正面 -->
			<td>
					<c:set var="img" value="${memberVO.idcF}" />
					<%
					byte b[] = (byte[]) pageContext.getAttribute("img");
						String idcF = Base64.encode(b);
						if (null == idcF || "".equals(idcF))
							idcF ="123";
					%>
					<img class="idc" src="data:image/jpg;base64,<%=idcF%>"width="200">
			</td>
			<!-- 身分證反面 -->
			<td>
					<c:set var="img2" value="${memberVO.idcB}" />
					<%
					byte b2[] = (byte[]) pageContext.getAttribute("img2");
						String idcB = Base64.encode(b2);
						if (null == idcB || "".equals(idcB))
							idcB ="123";
					%>
					<img class="idc2" src="data:image/jpg;base64,<%=idcB%>"width="200">
			</td>
		
		
		
	</tr>
</table>




</body>
</html>