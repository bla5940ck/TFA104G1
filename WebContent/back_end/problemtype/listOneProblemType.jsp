<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.manager.model.*"%>

<%
	ManagerVO managervo = (ManagerVO) request.getAttribute("managerVO");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>管理員資料新增 - addManager.jsp</title>
    <style>
        * {
            box-sizing: border-box;
        }
        
        body {
            /* border: 1px solid red; */
            margin: 0;
        }
        
        img {
            max-width: 100%;
        }
        
        html {
            /* font-size: 62.5%; */
            --header-height: 60px;
            --aside-width: 240px;
        }
        
        button.btn_hamburger {
            display: none;
        }
        
        @media (max-width:767.98px) {
            button.btn_hamburger {
                display: inline-block;
            }
        }
        /*================header 區域==================*/
        
        header.header {
            border: 1px solid black;
            width: 100%;
            height: var(--header-height);
            background-color: lightgrey;
            /* position: fixed;
            top: 0;
            left: 0; */
            position: sticky;
            top: 0;
        }
        /*================aside 區域==================*/
        
        aside.aside {
            border: 1px solid red;
            /* margin-top: 60px; */
            background-color: orange;
            position: fixed;
            left: 0;
            top: var(--header-height);
            /* top: 60px; */
            width: var(--aside-width);
            height: calc(100% - var(--header-height));
            /*li超出時,加上上下拉卷軸*/
            overflow-y: auto;
            padding: 20px 0;
            transition: all 1s;
        }
        
        @media (max-width:767.98px) {
            aside.aside {
                top: 0;
                height: 100%;
                transform: translateX(-100%);
            }
            aside.aside.-on {
                transform: translateX(0%);
            }
        }
        
        aside.aside nav.nav {
            /* border: 1px solid green; */
        }
        
        aside.aside nav.nav ul.nav_list {
            /* border: 1px solid black; */
            list-style: none;
            margin: 0;
            padding: 0;
        }
        
        aside.aside nav.nav ul.nav_list>li {
            /* border: 1px solid purple; */
        }
        
        aside.aside nav.nav ul.nav_list>li>a {
            /* border-bottom: 1px solid blue; */
            display: block;
            /* width: 100px; */
            text-decoration: none;
            text-align: center;
            padding: 10px 0;
            position: relative;
        }
        
        aside.aside nav.nav ul.nav_list>li>a::after {
            content: "";
            border-bottom: 1px solid white;
            display: inline-block;
            position: absolute;
            left: 50%;
            bottom: 0;
            width: 80%;
            transform: translateX(-50%);
        }
        
        aside.aside nav.nav ul.nav_list>li:last-child>a::after {
            display: none;
        }
        /*================main 區域==================*/
        
        main.main {
            border: 1px solid blue;
            /* height: 1000px; */
            width: calc(100% - var(--aside-width));
            margin-left: var(--aside-width);
            background-color: lightblue;
            min-height: calc(100vh - var(--header-height));
            padding: 20px;
        }
        
        @media (max-width:767.98px) {
            main.main {
                margin-left: 0;
                width: 100%;
            }
        }
        
        main.main ul.item_list {
            border: 1px solid red;
            list-style: none;
            margin: 0;
            padding: 0;
            /*橫向排列*/
            display: flex;
            flex-wrap: wrap;
        }
        
        main.main ul.item_list>li {
            border: 1px solid black;
            width: calc((100% - 60px)/4);
            margin-right: 20px;
            margin-bottom: 20px;
        }
        
        main.main ul.item_list>li:nth-child(4n) {
            margin-right: 0;
        }
        
        @media (max-width:767.98px) {
            main.main ul.item_list>li {
                width: calc((100% - 20px)/2);
            }
            main.main ul.item_list>li:nth-child(2n) {
                margin-right: 0;
            }
        }
        
        main.main ul.item_list>li a {
            display: block;
            border: 1px solid green;
            text-decoration: none;
        }
        
        main.main ul.item_list>li a div.img_block {
            border: 1px solid blue;
            font-size: 0;
        }
        
        main.main ul.item_list>li a span.item_text {
            display: block;
            width: 100%;
            border: 1px solid red;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>
</head>

<body>
    <header class="header">
        <button type="button" class="btn_hamburger">按鈕</button> 樂借所
    </header>

    <aside class="aside -on">
        <button type="button" class="btn_hamburger">按鈕</button> 管理員操作列表
        <nav class="nav">
            <ul class="nav_list">
                <li><a href="#">連結一</a></li>
                <li><a href="#">連結二</a></li>
                <li><a href="#">連結三</a></li>
                <li><a href="#">連結四</a></li>
                <li><a href="#">連結五</a></li>
                <li><a href="#">連結六</a></li>

            </ul>

        </nav>
    </aside>

    <main class="main">
        <ul class="item_list">
          
                
           
            <table id="table-1">
		<tr>
			
			<td>
				<h4>
					<a href="select_page.jsp"><img src="images/tomcat.png"
						width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/ManagerServlet" name="form1">
		<table>
			<tr>
				<td>管理員帳號:</td>
				<td><input type="TEXT" name="managerUser" size="45" /></td>
			</tr>
			<tr>
				<td>管理員姓名:</td>
				<td><input type="TEXT" name="managerName" size="45" /></td>
			</tr>
			<tr>
				<td>管理員密碼:</td>
				<td><input type="TEXT" name="managerPassword" size="45" /></td>
			</tr>
			<tr>
				<td>管理員狀態:</td>
				<td><select name="status" size="1" id="s">
						<option value="0">停用中</option>
						<option value="1">使用中</option>

				</select></td>
			</tr>


		</table>
		<br> <input type="hidden" name="action" value="insert"> 
			
		<input
			type="submit" value="送出新增">
	</FORM>

        </ul>



    </main>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $("button.btn_hamburger").on("click", function() {
            $("aside.aside").toggleClass("-on");
        });
    </script>

</body>

</html>