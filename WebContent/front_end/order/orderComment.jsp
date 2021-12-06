<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
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

/*-------------------aside區域------------------- */
aside.aside {
	width: 200px;
	height: 620px;
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
	height: 620px;
	display: inline-block;
	vertical-align: top;
	font-size: 1rem;
	border: 1px solid #999;
	padding: 10px;
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

/*************** 訊息框 *****************/
*{
  margin:0;
  padding:0;
  box-sizing:border-box;
  border:0;
}
body{
  font: 13px/100% tahoma;
  }
.clear{clear:both;}
.wrapper{
  width:400px;
  margin:10px auto;
}
.commentBox{
  
}
fieldset{
  padding:10px;
  background:#69bdf4;
}
.form_grp{
  margin-bottom:10px;
}
label{
  width:100%;
  height:32px;
  line-height:32px;
  display:block;
  margin-bottom:10px;
  font-size:18px;
  color:#fff;
 padding-left:34px; background:url(https://cdn3.iconfinder.com/data/icons/glypho-free/64/pen-checkbox-32.png) no-repeat left center;
}
textarea{
  width:100%;
  height:100px;
  padding:10px;
  border:1px solid #eee;
  resize:none;
}
button{
  padding:5px 20px;
  background-color:#0e7ec7;
  color:#fff;
  float:right;
}
.viewCmnt{
  clear:both;
  overflow:hidden;
  position:relative;
/*   background:#c8e7fb; */
  border-bottom:1px solid #A6DAFC;
}
.viewCmnt p {
  width:100%;
  float:left;
  padding:10px;
  font-size:14px;
  line-height:20px;
  }
.edit, .delete{
  position:absolute;
  width:20px;
  height:20px;
  display:none;
  cursor:pointer;
  bottom:5px;
  padding:2px;
   }
.viewCmnt:hover .edit, .viewCmnt:hover .delete{
  display:block;
}
.edit{
  right:26px;  background:url(https://cdn4.iconfinder.com/data/icons/miu/22/editor_pencil_pen_edit_write_-16.png) no-repeat center #0e7ec7;
}
.delete{
  right:5px;
  background:url(https://cdn2.iconfinder.com/data/icons/flat-ui-icons-24-px/24/cross-24-16.png) no-repeat center #0e7ec7;
  z-index:2;
}
</style>
<body>
	<%@ include file="/includeFolder/header2.file"%>
	<div class="main_content">
		<aside class="aside">
			<nav class="nav">
				<ul class="nav_list">
					<h2>出租者專區</h2>
					<h4>
						<a href="<%=request.getContextPath()%>/front_end/order/listAllOrderMaster.jsp">全部訂單</a>
					</h4>
				</ul>
			</nav>
		</aside>
		<main class="main">
			<div class="wrapper">
				<div class="commentBoxfloat">
					<form id="cmnt">
						<fieldset>
							<div class="form_grp">
								<label>評論</label>
								<textarea id="userCmnt"
									placeholder="請輸入您的評論"></textarea>
							</div>
							<div class="form_grp">
								<button type="button" id="submit">Submit</button>
							</div>
						</fieldset>
					</form>
				</div>
				<div id="cmntContr"></div>
			</div>
		</main>
	</div>
	<%@ include file="/includeFolder/footer2.file"%>
</body>
<script type="text/javascript">
$(function(){
	  var inDexValue;
	  
	    $('button').click( function() {
	      if($('#userCmnt').val().length == ''){
	       alert('Please Enter Your Comment');
	       return true;
	      }
	      var userCmnt = $('#userCmnt').val();
	      if($('#submit').hasClass('editNow')){
	                 
	        $('#cmntContr>div.viewCmnt').eq(inDexValue).children('p').html(userCmnt);
	        
	      }else{      
	    
	    $('#cmntContr').append("<div class='viewCmnt'><p>"+ userCmnt + "</p><span class='edit'></span><span class='delete'></span></div>");
	     }
	      $('#userCmnt').val('');
	      $(this).removeClass('editNow');
	  });
	    
	  // Delete 
	  $('#cmntContr').on('click', '.delete', function(){   
	    confirm("Delete Coformation");
	    $(this).parent().remove();
	  });
	  // Edit
	  $('#cmntContr').on('click', '.edit', function(){
	   
	    var toEdit = $(this).prev('p').html();
	    //alert(toEdit);
	    $('#userCmnt').val(toEdit);
	    $('button').addClass('editNow');
	    inDexValue = $(this).parent('div.viewCmnt').index();
	    
	  });
	  });
</script>
</html>