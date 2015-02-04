<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">



<title>Buy-Ticket</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
google.load('visualization', '1.0', {'packages':['corechart']});
google.load("visualization", "1.0", {'packages':['bar']});
</script>
<script type="text/javascript">
      function drawChart(s,a) {

        // Create the data table.
        var data = new google.visualization.DataTable();
		
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Sold', Number(s)],
          ['Ava', Number(a)]
        ]);

        // Set chart options
        var options = {'title':'How Many Tickets Have Been Sold',
                       'width':300,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>

<script>
$('document').ready(function(){
	if ("<c:out value='${param.login_error}'/>" != "") {
	  	$("#wrongCredentials").show();
	  	$("#login").trigger("click");
	}
	$("#chart_div").hide();
	$("#list").hide();
	
	$('#bgvid').click(function(){     
		   
	    $('html,body').animate({scrollTop: '663px'}, 400);    

	});
	
	$('#deal').click(function(){     
		   
	    $('html,body').animate({scrollTop: '1800px'}, 400);    

	});
	
	$('.learn-more').click(function(){     
		   
	    $('html,body').animate({scrollTop: '0px'}, 400);    

	});
	
	$("#findAll").click(function(){
		$("#ack").html("");
		$.ajax({
			url:"http://localhost:8080/Ticket/rest/userticket/tickets",
			type:"get",
			dataType:"json",
			success:function(data){showAllTicket(data);
									drawStuff(data)}
		});
	});
	$("#clear").click(function(){
		$("#chart_div").empty();
		$("#chart").empty();
		$("#tickets").empty();
		$("#list").hide();
	});
	$("#search").click(function(){
		/*
		$("#columnchart_material").show();
		*/
		$("#chart_div").empty();
		$("#chart").empty();
		$.ajax({
			url:"http://localhost:8080/Ticket/rest/userticket/search",
			type:"get",
			data:{
				dep:$("#dep").val(),
				des:$("#des").val(),
				date:$("#date").val(),
				quantity:$("#quantity").val()
			},
			dataType:"json",
			success:function(data){showAllTicket(data);
									drawStuff(data)}
		});
		return false;
	});

	
	$("#goTran").click(function(){
		if($("#user_name_logedin").text()==""){
			$("#login").trigger("click");
			$("#needLogin").show();
		}else{
			window.location.replace("http://localhost:8080/Ticket/user-transaction.html");
		}
	});
	
	$("#buy").click(function(){
		if($("#user_name_logedin").text()!= ""){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/userticket/buy",
				type:"get",
				data:{
					tid:$("#tid").val(),
					username:$("#username").val(),
					method:$("#method").val(),
					quantity2:$("#quantity2").val(),
				},
				dataType:"json",

			});
			alert("We are processing your request, you will be recieving a comfirmation email!");
		}
		else{
			alert("Please login first");
		}
		return false;
	});
	
	$(".close").click(function(){
		$(".alert").hide();
		$(".reg_error").hide();
	});
	
	 $("#pwd2").keyup(function(){
		 $(".reg_error").hide();
		 $("#register_input").prop('disabled',true);
		 if($("#pwd").val().length==0){
			 $("#pwd_empty").show();
		 }else{
			 if($("#pwd").val()!=$("#pwd2").val()){
				 $("#pwd2_error").show();
			 }else{
				 $("#pwd2_correct").show();
				 if ( $("#right_card").is(':visible') ){
					 $("#register_input").prop('disabled',false);
				 }
				
			 }
		 }
	 });
	 
	 $("#pwd").keyup(function(){
		 $(".reg_error").hide();
		 $("#register_input").prop('disabled',true);
		 if($("#pwd2").val().length!=0){
			 if($("#pwd").val()!=$("#pwd2").val()){
				 $("#pwd2_error").show();
			 }else{
				 $("#pwd2_correct").show();
				 if ($("#right_card").is(':visible') ){
					 $("#register_input").prop('disabled',false);
				 }
			 }
		 }
	 });
		
	 $("#card_input").blur(function(){
		 if($("#card_input").val().length!=16){			 
			$("#wrong_card").show();
		 }
	 });
	 $("#card_input").keyup(function(){
		 $("#wrong_card").hide();
		 $("#right_card").hide();
		 if($("#card_input").val().length==16){
			 if(!checkCard($("#card_input").val())){
				 $("#wrong_card").show();
			 }else{
				 $("#right_card").show();
				 if($("#pwd2_correct").is(':visible')){
					 $("#register_input").prop('disabled',false);
				 }
			 }
			 
		 }
		
	 });
	 $("#username_input").keyup(function(){
			$("#not_email").hide();
			if($("#username_input").val().length!=0){
				if(!validateEmail($("#username_input").val())){				
					$("#not_email").show();
				}
			 }			
	});
		
		$("#register_input").click(function(){
			if($("#username_input").val() !="" && validateEmail($("#username_input").val()) ){
				$.ajax({
					url:"http://localhost:8080/Ticket/rest/user/register",
					type:"post",
					data:{
						username_input:$("#username_input").val(),
						pwd:$("#pwd").val(),
						cardName_input:$("#cardName_input").val(),
						card_input:$("#card_input").val(),
						exp_input:$("#exp_input").val(),
						sec_input:$("#sec_input").val()						
					},
					datatype:"text",
					success:function(data){
						alert(data);
						$("#ref_close").trigger('click');
					}
				});
			}else{
				$("#not_email").show();				
			}
			return false;
		});

	
});
function checkCard($card){
	 var c = $card;
	 var cl = parseInt(c.substr(c.length - 1));
	 var c = c.slice(0,-1)
	 var c = c.split("").reverse().join("");
	 var c = c.split("");
	 var a = 2;
	 var cm = [];
	 for (var i = 0; i < c.length; i++){
		 if (a%2 == 0){var t = c[i]*2;
		 if (t > 9){var t = (t -9);}
		 cm.push(t);
	 }else{cm.push(parseInt(c[i]));}
	 a++;
	 }
	 var f = 0;
	 for (var i = 0; i < cm.length; i++) {f += cm[i];}
	 f = f + cl;
	 if (f%10 == 0){return true;}else{return false;}
}

function validateEmail(sEmail) {
	var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
	if (filter.test(sEmail)) {
		return true;
	}
	else {
		return false;
	}
}

function loginValidation() {
	$("#usernameAndPasswordReq").hide();
	$("#usernameReq").hide();
	$("#passwordReq").hide();   
	$("#wrongCredentials").hide();	
  	if($("#j_username").val().length == 0 && $("#j_password").val().length == 0) {
  		$("#usernameAndPasswordReq").show();
  		return false;
  	} else if ($("#j_username").val().length == 0) {
  		$("#usernameReq").show();
  		return false;
  	} else if ($("#j_password").val().length == 0) {
  		$("#passwordReq").show();
  		return false;
  	} else {
  		return true;
  	}
}
function showAllTicket(data){
	var rows = "";
	$("#tickets").empty();
	$(data.ticket).each(function(i,item){
		var tid=item.tid;
		var dep=item.dep;
		var des = item.des;
		var date = item.depdate;
		var time = item.deptime;
		var price = item.price;
		var total = item.total;
		var sold = item.sold;
		var ave = item.available;
		rows = "<tr><td>" + tid +"</td><td>" + dep  +"</td><td>" + des +"</td><td>" + 
				date +"</td><td>" + time +"</td><td>" + price +"</td><td>" + 
				total +"</td><td>" + sold +"</td><td>" + ave+ "</td><td align=\"center\"> <input name=\"selectedItems\" onClick=\"change()\" type=\"radio\"  value=\""+(i+1)+"\"/></tr>";
		$(rows).appendTo("#tickets");
	});
	$("#list").fadeIn(1000);
}

	function showTransaction(data){
		$("#transaction").val(data);
		
	}
	
	function change(){
		var line = $("input[name='selectedItems']:checked").val()

		$("#dep").val($("tr:nth-child("+line+") td:nth-child(2)").html());
		$("#des").val($("tr:nth-child("+line+") td:nth-child(3)").html());
		$("#date").val($("tr:nth-child("+line+") td:nth-child(4)").html());
		$("#tid").val($("tr:nth-child("+line+") td:nth-child(1)").html());
		$("#quantity2").val($("#quantity").val());
		$("#username").val($("#user_name_logedin").text());

		$("#chart_div").show();
		drawChart($("tr:nth-child("+line+") td:nth-child(8)").html(),$("tr:nth-child("+line+") td:nth-child(9)").html());
		
	}
	
	function drawStuff(data) {
		var data2 = new google.visualization.DataTable();
		 data2.addColumn('string','Ticket ID');
		  data2.addColumn('number', 'Sold');
		  data2.addColumn('number', 'available');
		  data2.addRows($(data.ticket).length);
		  $(data.ticket).each(function(i,item){
			  data2.setValue(i,0,item.tid);
			  data2.setValue(i,1,item.sold);
			  data2.setValue(i,2,item.available);
		  })
	  	  
	    //set the chart options
	    var options = {
	        title: 'Information',
	        width: 400,
	        height: 300
	    };
	    //instantiate and draw our chart, passing in the options
	    var chart = new google.visualization.ColumnChart(document.querySelector('#chart'));
	    chart.draw(data2, options);
	}



</script>

<style>
	.nav {
  			background-color: #f7f7f7;
	}

	.nav button {
  			color: #5a5a5a;
  			font-size: 12px;
  			font-weight: bold;
  			padding: 12px 12px 12px 12px;
  			text-transform: uppercase;
	}

	.nav li {
  			display: inline;
	}
	.nav .container{
			box-sizing: content-box;
			margin-top:10px;
			margin-right:40px;
			
			margin-left:40px;
	}
	
	.showvideo .container {
  	position: relative;
  	top:0px;
  	height:600px;
  	overflow: hidden;
	}

	.showvideo.container video {
   	position: absolute;
    left: 50%;
    top: 50%;
    /* The following will size the video to fit the full container. Not necessary, just nice.*/
    min-width: 100%;
    min-height: 100%;
    -webkit-transform: translate(-50%,-50%);
    -moz-transform: translate(-50%,-50%);
    -ms-transform: translate(-50%,-50%);
    transform: translate(-50%,-50%);
    z-index: 0;
    
    
	}

	.showvideo.Container #centertext {
    	position: relative;
    	z-index: 1;
	}
	
	
	.learn-more {
  background-color: #f7f7f7;
	}

.learn-more h3 {
  font-family: 'Shift', sans-serif;
  font-size: 18px;
  font-weight: bold;
}

.learn-more a {
  color: #00b0ff;
}

.neighborhood-guides{
    background-color:#efefef;
    border-bottom:1px solid #dbdbdb;
}
.neighborhood-guides h2{
    color:#393c3d;
    font-size:24px;
}
.neighborhood-guides p{
    margin-bottom:13px;
    font-size:15px;
}
	
</style>

</head>
<body>
	
	<div class="nav" >
      <div class="container">
        <ul class="pull-left">
          
          <li><button type="submit" class="btn btn-default" id="findAll">Show All Tickets</button></li>
          <li><button type="button" class="btn btn-default" id="goTran">Transaction History</button></li>
        </ul>
        <ul class="pull-right">
          <li><button type="button" class="btn btn-default" id="register" data-target="#myReg" data-toggle="modal" >Register</button></li>
          <li><button type="button" class="btn btn-default" id="login" data-target="#myModal" data-toggle="modal">Login</button></li>
          <sec:authorize ifAllGranted="ROLE_USER">
          <li><c:url value="/j_spring_security_logout" var="logoutUrl"/><div id="user_name_logedin"><sec:authentication property="name"/></div></li>
          <li><a href="${logoutUrl}">Log Out</a></li>
          </sec:authorize>
		
          
        </ul>
      </div>
    </div>
	
	<!--  
	<div class="hero row-fluid dark containerMobileFullWidth">
    		<div id="hero" class="hero-bg moving-background ">
    				<div class="pxp-fluid-height">
    					
    				</div>
    				<video id="bgvid" autoplay="autoplay" muted="muted" poster="https://www.paypalobjects.com/webstatic/en_US/mktg/wright/home/OneTouchCity_Frame1_dark.jpg" width="1600px" height="900px">
        				<source src="https://www.paypalobjects.com/webstatic/en_US/mktg/wright/videos/OneTouchCity.mp4" type="video/mp4" type="video/mp4">
        				<source src="https://www.paypalobjects.com/webstatic/en_US/mktg/wright/videos/OneTouchCity.webm" type="video/webm">
    				</video>
    		</div>
	</div>-->
	
	<div class="showvideo" style="height:600px;background-color: #f7f7f7;">
      <div class="container">
      				<video id="bgvid" autoplay="autoplay" muted="muted" poster="https://www.paypalobjects.com/webstatic/en_US/mktg/wright/home/OneTouchCity_Frame1_dark.jpg" width="1600px" height="900px">
        			<source src="https://www.paypalobjects.com/webstatic/en_US/mktg/wright/videos/OneTouchCity.mp4" type="video/mp4" type="video/mp4">
        			<source src="https://www.paypalobjects.com/webstatic/en_US/mktg/wright/videos/OneTouchCity.webm" type="video/webm">
    				</video>
    			<div id="centertext">	
        			<h1>Find a place to stay.</h1>
        			<p>Rent from people in over 34,000 cities and 192 countries.</p>
        			<a href="#">Learn More</a>
       			</div>
      </div>
    </div>
	
	<div class="row clearfix" >
		<div class="col-md-1 column">
		</div>
		<div class="col-md-4 column">
			<h2 style="font-size: 40px;color:#393c3d;font-family: 'Shift', sans-serif;font-weight: bold;">Ticket</h2>
		</div>
		<div class="col-md-7 column">
		</div>
	</div>
	<div class="row">
		<form class="form-horizontal" role="form">
           
           <div class="col-sm-1"></div>
           <div class="col-sm-2">
			<input type="text" class="form-control input-lg" id="dep" name="dep" placeholder="From"/> 
		   </div>
		   <div class="col-sm-2">
			<input type="text" class="form-control input-lg" id="des" name="des" placeholder="To"/>
		  </div> 
			<div class="col-sm-2">
			<input type="text" class="form-control input-lg" id="date" name="date" placeholder="YYYYMMDD"/> 
			</div>
			<div class="col-sm-2">
			<input type="number" class="form-control input-lg" id="quantity" name="quantity" placeholder=1 />
			</div>
			<div class="col-sm-2">
			<button type="submit" class="btn btn-info" style="color: #5a5a5a;font-size: 12px;font-weight: bold;padding: 12px 12px 12px 12px;text-transform: uppercase;" id="search">S e a r c h</button>
			<button type="reset" class="btn btn-default" style="color: #5a5a5a;font-size: 12px;font-weight: bold;padding: 12px 12px 12px 12px;text-transform: uppercase;" id="clear">Clear</button>
			</div>
			<div class="col-sm-1"></div>
		</form>
	</div>
	<br/>
	
	
	<div class="row">
	<form>
		<div class="col-sm-7"><input type="text" id="tid" name="tid" style="display:none"/>
		<input style="display:none" type="text" id="username" name="username" style="display:none"/> </div>
		
		<div class="col-sm-2">
		<select	class="form-control" id="method" name="method">
  			<option value=0>Card</option>
  			<option value=1>PayPal</option>
		</select>
		</div>
		<div class="col-sm-2">
		<input type="number" id="quantity2" name="quantity2" style="display:none"/>
		<button type="submit" class="btn btn-info" style="color: #5a5a5a;font-size: 12px;font-weight: bold;padding: 12px 12px 12px 12px;text-transform: uppercase;" id="buy">B U Y</button>
		</div>
		
	</form>
	</div>
	
	<div class="row clearfix" >
		<div class="col-md-1 column">
		</div>
		<div class="col-md-4 column">
			<a href="#" id="deal" style="color: #5a5a5a;font-size: 20px;font-weight: bold;padding: 50px 10px;"><span class="glyphicon glyphicon-search"></span>No idea where to go? Take a deal below! </a>
		</div>
		<div class="col-md-7 column">
		</div>
	</div>
	
	<div class="container"  style="height:600px">
	<div class="row clearfix">
		<div class="col-md-8 column">
			<table class="table" id="list">
				<thead>
					<tr>
						<th>Ticket ID</th>
						<th>Departure</th>
						<th>Destination</th>
						<th>Date</th>
						<th>Time</th>
						<th>Price</th>
						<th>Total</th>
						<th>Sold</th>
						<th>Available</th>
						<th>Select</th>
					</tr>
				</thead>
				<tbody id="tickets"></tbody>
			</table>
			
			<div id="chart_div"></div>
		</div>
		<div class="col-md-4 column">
			<div id="chart"></div>
			
		</div>
	</div>
</div>
	
	
	
	
	
	<div class="neighborhood-guides">
       <div class="container">
         <h2>Neighborhood guides</h2>
         <p>Not sure where to stay? We've created neighborhood guides for cities all around the world.</p>
         
         <div class="row">
	      <div class="col-md-4">
	         <div class="thumbnail">
	         	
	             <img src="http://goo.gl/0sX3jq"> 
	         </div>
	         <div class="thumbnail">
	            <img src="http://goo.gl/an2HXY">
	         </div>
	      </div>
	      <div class="col-md-4">
	          <div class="thumbnail">
	            <img src="http://goo.gl/Av1pac">
	         </div>
	         <div class="thumbnail">
	            <img src="http://goo.gl/vw43v1">
	            
	            
	            
	            
	         
	         
	         </div>
	      </div>
	      <div class="col-md-4">
	          <div class="thumbnail">
	          
	          	
	            <img src="http://goo.gl/0Kd7UO">
	         </div>
	      </div>
	     </div>
       </div>
    </div>
  
	      
    
    <div class="learn-more">
	  <div class="container">
		<div class="row">
	      <div class="col-md-4">
			<h3>Travel</h3>
			<p>From apartments and rooms to treehouses and boats: stay in unique spaces in 192 countries.</p>
			<p><a href="#">See how to travel on Airbnb</a></p>
	      </div>
		  <div class="col-md-4">
			<h3>Host</h3>
			<p>Renting out your unused space could pay your bills or fund your next vacation.</p>
			<p><a href="#">Learn more about hosting</a></p>
		  </div>
		  <div class="col-md-4">
			<h3>Trust and Safety</h3>
			<p>From Verified ID to our worldwide customer support team, we've got your back.</p>
			<p><a href="#">Learn about trust at Airbnb</a></p>
		  </div>
	    </div>
	  </div>
	</div>
	
<!-- *********************************************** -->
<!-- *********************************************** -->
<!-- ******************* Login Box ******************-->
<!-- *********************************************** -->
<!-- *********************************************** -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">X</button>
					<h3 class="modal-title">Login</h3>
				</div>
				<div class="modal-body">
					<form action="<c:url value='/Ticket/j_spring_security_check'/>"
						method="POST" id="login-form" role="form">
						<div class="alert" id="needLogin" style="display:none">
							<p>Please Login First</p>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="control-label">Username:</label>
							<input type="text" class="form-control" name="j_username"
								id="j_username" required/>
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label">Password:</label>
							<input type="password" class="form-control" name="j_password"
								id="j_password" required/>
						</div>
						<div class="alert" id="wrongCredentials" style="display: none;">
							<p>The username or password supplied is incorrect</p>
						</div>
						<div class="modal-footer">
							<label for="j_remember">Remember Me</label> <input
								type="checkbox" id="j_remember"
								name="_spring_security_remember_me">
							
							<button type="submit" class="btn btn-primary" id="loginGo">Login!</button>
						</div>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

<!-- *********************************************** -->
<!-- *********************************************** -->
<!-- ******************* Register ******************-->
<!-- *********************************************** -->
<!-- *********************************************** -->
<div class="modal fade" id="myReg" >
<div class="modal-dialog modal-sm"><!--  -->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
          <h3 class="modal-title">Register New User</h3>
        </div>
        <div class="modal-body">
		<form action="" role="form" method="post">
	        <div class="form-group">
	          <label for="email">User Name:</label>
	          <input type="email" class="form-control" id="username_input" placeholder="Enter email" name="username" />
	        </div>
	        <div class="reg_error" id="not_email" style="display: none;">
	        	<p id="warning-msg">Please enter a valid Email address</p>
	        </div>
	        <div class="form-group">
	          <label for="pwd">Password:</label>
	          <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password">
	        </div>
	        <div class="reg_error" id="pwd_empty" style="display: none;">
	        	<p>Please enter password</p>
	        </div>
	       	<div class="form-group">
	          <label for="pwd">Re-enter Password:</label>
	          <input type="password" class="form-control" id="pwd2" placeholder="Re-enter password">
	        </div>
	        <div class="reg_error" id="pwd2_error" style="display: none;">
	        	<p>Passwords are not the same!</p>
	        </div>
	         <div class="reg_error" id="pwd2_correct" style="display: none;">
	        	<p>Checked</p>
	        </div>
	        <div class="form-group">
	        	<label for="cardName">Card Holder:</label>
	          	<input type="text" class="form-control" id="cardName_input"  placeholder="Card Holder">
	        </div>
	        <div class="form-group">
	        	<label for="cardNum">Credit Card Numer:</label>
	          	<input type="text" class="form-control" id="card_input" maxlength="16" placeholder="Your credit number">
	        </div>
	        <div class="reg_error" id="wrong_card" style="display: none;">
	        	<p>Please use a valid card.</p>
	        </div>
	         <div class="reg_error" id="right_card" style="display: none;">
	        	<p>Valid</p>
	        </div>
	        
	         <div class="form-group">
	        	<label for="cardExp">Valid Thru:</label>
	          	<input type="text" class="form-control" id="exp_input" maxlength="4" placeholder="Card Exp date">
	        </div>
	         <div class="form-group">
	        	<label for="cardSec">Security Number:</label>
	          	<input type="text" class="form-control" id="sec_input" maxlength="3" placeholder="Card Security number">
	        </div>
	       
	        
	        <button type="reset" class="btn btn-default " data-dismiss="modal">Close</button>
	        <button type="submit" class="btn btn-default" id="register_input" disabled>Submit</button>
      </form>
		</div>
	 </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->

<sec:authorize ifAllGranted="ROLE_USER">
<div id="user_name_logedin"><sec:authentication property="name"/></div>
<c:url value="/j_spring_security_logout" var="logoutUrl"/>
<a href="${logoutUrl}">Log Out</a>
</sec:authorize>
</body>
</html>