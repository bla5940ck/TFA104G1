<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>

<%		
	Integer memID = (Integer)session.getAttribute("id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<style>
input.memberId {
	background-color: lightgray;
}

main {
	text-align: center;
	font-family: helvetica;
}

canvas {
	border: 2px solid rgb(151, 149, 149);
}
table {
	width: 100%;
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
btn1, btn2, btn3, btn4 {
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: normal;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
}
</style>

<%@ include file="/includeFolder/header.file"%>
<body>
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 錯誤表列 -->


	<!-- / catg header banner section -->

	<!-- Cart view section -->
	<section id="aa-myaccount">
		<div class="container">
			<div class="row" id="row1">
				<div class="col-md-12" id="col-md-12">
					<!-- 					<div class="aa-myaccount-area" id="aa-myaccount-area"> -->
					<div class="row" id="row2">
						<!--<div class="col-md-6" id="col-md-6"> -->
						<div class="aa-myaccount-login" id="aa-myaccount-login">

	
	<c:if test="${b==true}">
		<script>
 			alert("領取成功");
		</script>
	</c:if>

	<c:if test="${b==false}">
			<script>
			alert("已領取過");
		</script>
	</c:if>
	<main>
	<br>
							<h2>小遊戲</h2>
							<h4>操作方式:上=W，下=S，左=A，右=D</h4>
							<h3>分數<p id="score" class="score"></p></h3>	
							
							<input type="hidden" name="finalScore" class="finalScore">
							<canvas id="stage" height="400" width="520"></canvas>

							<script>
	
							/**
							 * Namespace
							 */
							var Game      = Game      || {};
							var Keyboard  = Keyboard  || {}; 
							var Component = Component || {};

							/**
							 * Keyboard Map
							 */
							 Keyboard.Keymap = {
									  65: 'left',
									  87: 'up',
									  68: 'right',
									  83: 'down'
									};

							/**
							 * Keyboard Events
							 */
							Keyboard.ControllerEvents = function() {
							  
							  // Setts
							  var self      = this;
							  this.pressKey = null;
							  this.keymap   = Keyboard.Keymap;
							  
							  // Keydown Event
							  document.onkeydown = function(event) {
							    self.pressKey = event.which;
							  };
							  
							  // Get Key
							  this.getKey = function() {
							    return this.keymap[this.pressKey];
							  };
							};

							/**
							 * Game Component Stage
							 */
							Component.Stage = function(canvas, conf) {  
							  
							  // Sets
							  this.keyEvent  = new Keyboard.ControllerEvents();
							  this.width     = canvas.width;
							  this.height    = canvas.height;
							  this.length    = [];
							  this.food      = {};
							  this.score     = 0;
							  this.direction = 'right';
							  this.conf      = {
							    cw   : 10,
							    size : 5,
							    fps  : 1000  
							  };
							  // Merge Conf
							  if (typeof conf == 'object') {
							    for (var key in conf) {
							      if (conf.hasOwnProperty(key)) {
							        this.conf[key] = conf[key];
							      }
							    }
							  }
							  
							};

							/**
							 * Game Component Snake
							 */
							Component.Snake = function(canvas, conf) {
							  
							  // Game Stage
							  this.stage = new Component.Stage(canvas, conf);
							  
							  // Init Snake
							  this.initSnake = function() {
							    
							    // Itaration in Snake Conf Size
							    for (var i = 0; i < this.stage.conf.size; i++) {
							      
							      // Add Snake Cells
							      this.stage.length.push({x: i, y:0});
									}
								};
							  
							  // Call init Snake
							  this.initSnake();
							  
							  // Init Food  
							  this.initFood = function() {
									
							    // Add food on stage
							    this.stage.food = {
										x: Math.round(Math.random() * (this.stage.width - this.stage.conf.cw) / this.stage.conf.cw), 
										y: Math.round(Math.random() * (this.stage.height - this.stage.conf.cw) / this.stage.conf.cw), 
									};
								};
							  
							  // Init Food
							  this.initFood();
							  
							  // Restart Stage
							  this.restart = function() {
							    this.stage.length            = [];
							    this.stage.food              = {};
							    this.stage.score             = 0;
							    this.stage.direction         = 'right';
							    this.stage.keyEvent.pressKey = null;
							    this.initSnake();
							    this.initFood();
							  };
							};

							/**
							 * Game Draw
							 */
							Game.Draw = function(context, snake) {
							  
							  // Draw Stage
							  this.drawStage = function() {
							    
							    // Check Keypress And Set Stage direction
							    var keyPress = snake.stage.keyEvent.getKey(); 
							    if (typeof(keyPress) != 'undefined') {
							      snake.stage.direction = keyPress;
							    }
							    
							    // Draw White Stage
									context.fillStyle = "white";
									context.fillRect(0, 0, snake.stage.width, snake.stage.height);
									
							    // Snake Position
							    var nx = snake.stage.length[0].x;
									var ny = snake.stage.length[0].y;
									
							    // Add position by stage direction
							    switch (snake.stage.direction) {
							      case 'right':
							        nx++;
							        break;
							      case 'left':
							        nx--;
							        break;
							      case 'up':
							        ny--;
							        break;
							      case 'down':
							        ny++;
							        break;
							    }
							    
							    // Check Collision
// 							    if (this.collision(nx, ny) == true) {
// 							    	console.log("結束了");
// 							    	//	自動重新開始
// 							    	//  snake.restart();
							      
// 							    	 var finalScore = $(".score");
// 										document.getElementById("score").setAttribute('value',
// 										finalScore);
										
										
							    	
// 							    	return;
// 							    }
							 	if (this.collision(nx, ny) == true && snake.stage.score > 2) {
							    	console.log("結束了");
									document.getElementById("btn3").disabled = false
									return;
							    }
							    
							     if (this.collision(nx, ny) == true && snake.stage.score > 1) {
							    	console.log("結束了");
									document.getElementById("btn2").disabled = false
									return;
							    }
							     
							    if (this.collision(nx, ny) == true && snake.stage.score > 0) {
							    	console.log("結束了");
									document.getElementById("btn1").disabled = false
										return;
							    }
							   
							    
							    // Logic of Snake food
							    
							    if (nx == snake.stage.food.x && ny == snake.stage.food.y) {
							      var tail = {x: nx, y: ny};
							      snake.stage.score++;
							    	
							      	//分數
								    //console.log(snake.stage.score);
							      
							      	snake.initFood();
							    } else {
							      var tail = snake.stage.length.pop();
							      tail.x   = nx;
							      tail.y   = ny;	
							    }
							    snake.stage.length.unshift(tail);
							    
							    // Draw Snake
							    for (var i = 0; i < snake.stage.length.length; i++) {
							      var cell = snake.stage.length[i];
							      this.drawCell(cell.x, cell.y);
							     }
							    
							    // Draw Food
							    this.drawCell(snake.stage.food.x, snake.stage.food.y);
							    
							    // Draw Score
							    context.fillText('Score: ' + snake.stage.score, 5, (snake.stage.height - 5));
							  	
							    // 分數
							    console.log(snake.stage.score);
							    var endScore = snake.stage.score;
							    $(".score").text(endScore);
							    							  						    
							  };			
							  
							  
							  
// 							 var endScore = snake.stage.score;
// 							 console.log(endScore);  
							  
							  
							  
							  
							  
							  
							  // Draw Cell
							  this.drawCell = function(x, y) {
							    context.fillStyle = 'rgb(170, 170, 170)';
							    context.beginPath();
							    context.arc((x * snake.stage.conf.cw + 6), (y * snake.stage.conf.cw + 6), 4, 0, 2*Math.PI, false);    
							    context.fill();
							  };
							  
							  // Check Collision with walls
							  this.collision = function(nx, ny) {  
							    if (nx == -1 || nx == (snake.stage.width / snake.stage.conf.cw) || ny == -1 || ny == (snake.stage.height / snake.stage.conf.cw)) {
							      return true;
							    }
							    return false;    
								}
							};


							/**
							 * Game Snake
							 */
							Game.Snake = function(elementId, conf) {
							  
							  // Sets
							  var canvas   = document.getElementById(elementId);
							  var context  = canvas.getContext("2d");
							  var snake    = new Component.Snake(canvas, conf);
							  var gameDraw = new Game.Draw(context, snake);
							  
							  // Game Interval
							  setInterval(function() {gameDraw.drawStage();}, snake.stage.conf.fps);
							};


							/**
							 * Window Load
							 */
							window.onload = function() {
							  var snake = new Game.Snake('stage', {fps: 100, size: 4});
							};
							
					
							
</script>

							<br> <br>

<%-- 							<center> --%>
<!-- 								<a class="aa-browse-btn" -->
<!-- 									href="/TFA104G1/front_end/getCoupon/getCoupon.jsp"><span -->
<!-- 									class="fa fa-long-arrow-left"></span>回上一頁</a> -->
<%-- 							</center> --%>
							
								<a class="aa-browse-btn"
									href="game.jsp">再挑戰一次</a>
<!-- 									href="JavaScript:window.location.reload()">再挑戰一次</a> -->
									
									


<br>
<br>
		
		
						<center><h2>挑戰成功折價券領取專區</h2></center>
	<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>

	
<!-- 	/*=====承租方評級=====*/ -->
<!-- 	var rr = $("#rr"); -->
<%-- 	if(<%=omVO.getRentRank()%> == 1){ --%>
<!-- 		rr.text("1"); -->
<%-- 	}else if(<%=omVO.getRentRank()%> == 2){ --%>
<!-- 		rr.text("2"); -->
<%-- 	}else if(<%=omVO.getRentRank()%> == 3){ --%>
<!-- 		rr.text("3"); -->
<%-- 	}else if(<%=omVO.getRentRank()%> == 4){ --%>
<!-- 		rr.text("4"); -->
<%-- 	}else if(<%=omVO.getRentRank()%> == 5){ --%>
<!-- 		rr.text("5"); -->
<!-- 	}else{ -->
<!-- 		rr.text("尚未評分"); -->
<!-- 	} -->

			<table>		

				<tr>	
					<td>滿1分</td>
					<td>再接再厲</td>
					<td>5元</td>
					<td>
						<FORM METHOD="post"
							ACTION="getcoupon.do"
							style="margin-bottom: 0px;">
							<input id="btn1" disabled type="submit" value="領取"> 
							<input type="hidden" name="member_id" value="<%=memID%>"> 
							<input type="hidden" name="category_id" value="1"> 
							<input type="hidden" name="coupon_id" value="1"> 
							<input type="hidden" name="coupon_name" value="滿1分折5元"> 
							<input type="hidden" name="discount" value="5"> 
							<input type="hidden" name="status" value="0"> 
							<input type="hidden" name="start_date" value=""> 
							<input type="hidden" name="end_date" value=""> 
							<input type="hidden" name="action" value="gameInsert">
						</FORM>
					</td>
			</tr>
				<tr>	
					<td>滿2分</td>
					<td>不錯喔</td>
					<td>10元</td>
					<td>
						<FORM METHOD="post"ACTION="getcoupon.do"style="margin-bottom: 0px;">
							<input id="btn2" disabled type="submit" value="領取"> 
							<input type="hidden" name="member_id" value="<%=memID%>"> 
							<input type="hidden" name="category_id" value="1"> 
							<input type="hidden" name="coupon_id" value="2"> 
							<input type="hidden" name="coupon_name" value="滿2分折10元"> 
							<input type="hidden" name="discount" value="10"> 
							<input type="hidden" name="status" value="0"> 
							<input type="hidden" name="start_date" value=""> 
							<input type="hidden" name="end_date" value=""> 
							<input type="hidden" name="action" value="gameInsert">
						</FORM>
					</td>
			</tr>
				<tr>	
					<td>滿3分</td>
					<td>達人</td>
					<td>20元</td>
					<td>
						<FORM METHOD="post"ACTION="getcoupon.do"style="margin-bottom: 0px;">
							<input id="btn3" disabled type="submit" value="領取"> 
							<input type="hidden" name="member_id" value="<%=memID%>"> 
							<input type="hidden" name="category_id" value="1"> 
							<input type="hidden" name="coupon_id" value="3"> 
							<input type="hidden" name="coupon_name" value="滿3分折20元"> 
							<input type="hidden" name="discount" value="20"> 
							<input type="hidden" name="status" value="0"> 
							<input type="hidden" name="start_date" value=""> 
							<input type="hidden" name="end_date" value=""> 
							<input type="hidden" name="action" value="gameInsert">
						</FORM>
					</td>
			</tr>
				<tr>	
					<td>滿200分</td>
					<td>神</td>
					<td>50元</td>
					<td>
						<FORM METHOD="post"
							ACTION="getcoupon.do"
							style="margin-bottom: 0px;">
							<input id="btn4" disabled type="submit" value="領取"> 
							<input type="hidden" name="member_id" value="<%=memID%>"> 
							<input type="hidden" name="category_id" value="1"> 
							<input type="hidden" name="coupon_id" value="4"> 
							<input type="hidden" name="coupon_name" value="滿200分折50元"> 
							<input type="hidden" name="discount" value="50"> 
							<input type="hidden" name="status" value="0"> 
							<input type="hidden" name="start_date" value=""> 
							<input type="hidden" name="end_date" value=""> 
							<input type="hidden" name="action" value="gameInsert">
						</FORM>
					</td>
			</tr>
			</table>

	<br> <br>
						</div>
						<!-- 						</div> -->
					</div>
				</div>
			</div>
		</div>

		<center><a class="aa-browse-btn" href="/TFA104G1/front_end/product/homePage.jsp"><span class="fa fa-long-arrow-left"></span>回首頁</a></center>
								<br>
	<br>
		</main>
		<!-- 		</div> -->
	</section>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
</html>