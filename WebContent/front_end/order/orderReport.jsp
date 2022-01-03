<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


<html>
<head>

<title>管理者頁面</title>
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
	background-color:#F5D998;;
	height:720px;
}



/*--------------------main區域-------------------- */
main.main {
	background-color: 	#F0F0F0; 
	
	background-repeat:no-repeat;
	background-size: cover;
	opacity:1;
	width: calc(100% - 200px - 10px);
	height: 720px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
	z-index:2;
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


.class1{
background-color:#FFF0AC;
}

input{
background-color:#FFF0AC;
}

button{
background-color: #FFF0AC;
}


</style>

</head>
<body bgcolor='white'>

	<%@ include file="/includeFolder/managerHeader.file"%>
	<div class="main_content">
		<%@ include file="/includeFolder/managerAside.file"%>
		<main class="main" >
		
		<div id="chartContainer" style="height: 80%px; width: 100%;"></div>
		
		
		</main>
	</div>	
</body>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
 <script>
        window.onload = function() {
		
        	
        		
        	$.ajax({
        		url:"/TFA104G1/ReportServlet",
        		dataType:"json",
        		data:{
        			action:"report",
        		},
        		success:function(data){
        			console.log(data);
        			console.log(data.list);
        			console.log(data.list.length);
        			
        			
        	
        	
            var chart = new CanvasJS.Chart("chartContainer", {
                animationEnabled: true,
                theme: "light1", // "light1", "light2", "dark1", "dark2"
                title: {
                    text: "每月訂單報表"
                },
                axisY: {
                    title: "訂單數量"
                },
                data: [{
                    type: "column",
                    showInLegend: true,
                    legendMarkerColor: "grey",
                    legendText: "月份",
                    dataPoints:data.list 
                    	
                    	
                    	
                    	[{
                    		
                        y: 1,
                        label: "January"
                    }, {
                        y: 266455,
                        label: "February"
                    }, {
                        y: 169709,
                        label: "March"
                    }, {
                        y: 158400,
                        label: "April"
                    }, {
                        y: 142503,
                        label: "May"
                    }, {
                        y: 101500,
                        label: "June"
                    }, {
                        y: 97800,
                        label: "July"
                    }, {
                        y: 80000,
                        label: "August"
                    }, {
                        y: 80000,
                        label: "September"
                    }, {
                        y: 80000,
                        label: "October"
                    }, {
                        y: 80000,
                        label: "November"
                    }, {
                    	
                        y: 1,
                        label: 1
                    	
                    }]
                }]
            });
            chart.render();
            
        		},error:function(e){
        			console.log()
        		}
        	
        	});

        }
    </script>
</html>