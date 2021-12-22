<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.postboard.model.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<style>
input.memberId {
	background-color: lightgray;
}

body {
	text-align: center;
	font-family: helvetica;
}

canvas {
	border: 2px solid rgb(151, 149, 149);
}
</style>

<%@ include file="/includeFolder/header.file"%>
<body>
	
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
	<br>
							<h2>小遊戲</h2>
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
							    if (this.collision(nx, ny) == true) {
							    	
							    	//	自動重新開始
							    	//  snake.restart();
							      
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
							  	
							    //分數
							    console.log(snake.stage.score);
							    
							  };							  
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
							<center>
								<a class="aa-browse-btn"
									href="JavaScript:window.location.reload()">再挑戰一次</a>
							</center>
<%-- 							<center> --%>
<!-- 								<a class="aa-browse-btn" -->
<!-- 									href="/TFA104G1/front_end/getCoupon/game.jsp"><span -->
<!-- 									></span>再挑戰一次</a> -->
<%-- 							</center> --%>
							<br> <br>

						</div>
						<!-- 						</div> -->
					</div>
				</div>
			</div>
		</div>
		<!-- 		</div> -->
	</section>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
</html>