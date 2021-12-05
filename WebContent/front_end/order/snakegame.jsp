<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
::-moz-selection {
background: #b3d4fc;
text-shadow: none;
}

::selection {
background: #b3d4fc;
text-shadow: none;
}

html {
padding: 30px 10px;
font-size: 20px;
line-height: 1.4;
color: #737373;
background: #f0f0f0;
-webkit-text-size-adjust: 100%;
-ms-text-size-adjust: 100%;
}

html,
input {
font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}

body {
max-width: 500px;
_width: 500px;
padding: 30px 20px 50px;
border: 1px solid #b3b3b3;
border-radius: 4px;
margin: 0 auto;
box-shadow: 0 1px 10px #a7a7a7, inset 0 1px 0 #fff;
background: #fcfcfc;
}

h1 {
margin: 0 10px;
font-size: 50px;
text-align: center;
}

h1 span {
color: #bbb;
}

h3 {
margin: 1.5em 0 0.5em;
}

p {
margin: 1em 0;
text-align: center;
}

.container {
max-width: 380px;
_width: 380px;
margin: 0 auto;
}

input::-moz-focus-inner {
padding: 0;
border: 0;
}
			
#canvas{
margin-left: 5%;
}

nav{
text-align: center;
}
a:link {text-decoration:none; color:black; background-color: #ccc; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px;}
a:visited {text-decoration:none; color:black;}
a:hover {text-decoration:underline; text-decoration:none; color:black;}
a:active {text-decoration:underline; text-decoration:none; color:black;}
</style>
</head>
<body>
<div class="container">
  <h1>Snake Game</h1>
</div>
<canvas id="canvas" width="450" height="450"></canvas>
</body>
<script type="text/javascript">
$(document).ready(function(){
	//Canvas stuff
	var canvas = $("#canvas")[0];
	var ctx = canvas.getContext("2d");
	var w = $("#canvas").width();
	var h = $("#canvas").height();
	
	// variables
	var cw = 10; //size of snake
	var d; //direction
	var food;
	var score;
	var speed = 90; //speed of snake
	
	//snake
	var snake_array; 
	
	function init(){
		d = "right"; //default direction
		create_snake();
		create_food(); 
		score = 0;
		
		if(typeof game_loop != "undefined") clearInterval(game_loop);
		game_loop = setInterval(paint, speed);
	}
	init();
	
	function create_snake(){
		var length = 20; //default length of snake
		snake_array = [];
		for(var i = length-1; i>=0; i--){
			//This will create a horizontal snake starting from the top left
			snake_array.push({x: i, y:0});
		}
	}
	
	function create_food(){
		food = {
			x: Math.round(Math.random()*(w-cw)/cw), 
			y: Math.round(Math.random()*(h-cw)/cw), 
		};
	}
	
	//snake paint
	function paint(){
		//canvas paint
		ctx.fillStyle = "white";
		ctx.fillRect(0, 0, w, h);
		ctx.strokeStyle = "black";
		ctx.strokeRect(0, 0, w, h);
		
		var nx = snake_array[0].x;
		var ny = snake_array[0].y;

		if(d == "right") nx++;
		else if(d == "left") nx--;
		else if(d == "up") ny--;
		else if(d == "down") ny++;
		
		if(nx == -1 || nx == w/cw || ny == -1 || ny == h/cw || check_collision(nx, ny, snake_array)){
			init();
			return;
		}
		
		if(nx == food.x && ny == food.y){
			var tail = {x: nx, y: ny};
			score++;
			create_food();
		}
		else{
			var tail = snake_array.pop();
			tail.x = nx; tail.y = ny;
		}
		//The snake can now eat the food.
		
		snake_array.unshift(tail);
		
		for(var i = 0; i < snake_array.length; i++){
			var c = snake_array[i];
			paint_cell(c.x, c.y);
		}
		
		//food paint
		paint_cell(food.x, food.y);
		var score_text = "Score: " + score;
		ctx.fillText(score_text, 5, h-5);
	}
	
	//lets first create a generic function to paint cells
	function paint_cell(x, y){
		ctx.fillStyle = "black";
		ctx.fillRect(x*cw, y*cw, cw, cw);
		ctx.strokeStyle = "white";
		ctx.strokeRect(x*cw, y*cw, cw, cw);
	}
	
	function check_collision(x, y, array){
		for(var i = 0; i < array.length; i++){
			if(array[i].x == x && array[i].y == y)
			 return true;
		}
		return false;
	}
	
	//keyboard controls
	$(document).keydown(function(e){
		var key = e.which;
		if(key == "37" && d != "right") d = "left";
		else if(key == "38" && d != "down") d = "up";
		else if(key == "39" && d != "left") d = "right";
		else if(key == "40" && d != "up") d = "down";
	})	
})
</script>
</html>