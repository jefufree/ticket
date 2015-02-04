<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello World</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/test.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>

	<link rel="stylesheet" href="http://s3.amazonaws.com/codecademy-content/courses/ltp/css/bootstrap.css">
    <link href="http://s3.amazonaws.com/codecademy-content/courses/ltp/css/shift.css" rel="stylesheet">

<script>
	$("document").ready(function(){
		$("#list").hide();
		$('#bgvid').click(function(){     
			   
		    $('html,body').animate({scrollTop: '500px'}, 400);    

		})
		$("#findAll").click(function(){
			$("#ack").html("");
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/userticket/usertransactions",
				type:"get",
				data:{
					userid:$("#userid").val()
				},
				dataType:"json",
				success:showAllTransaction
			});
		});
	});
	
	function showAllTransaction(data){
		var rows = "";
		$("#transactions").empty();
		$(data.transaction).each(function(i,item){
			var transactionid=item.transactionid;
			var tid=item.tid;
			var	method=item.method;
			var	quantity=item.quantity;
			var time=item.time;
			var status=item.status;
			rows = "<tr><td>"+transactionid+ "</td><td>"+tid+ "</td><td>"+method+ "</td><td>"+
				quantity+ "</td><td>"+time+ "</td><td>"+status+ 
				"</td><td align=\"center\"> <input name=\"selectedItems\" onClick=\"change()\" type=\"radio\" value=\""+(i+1)+"\"/></tr>";
			$(rows).appendTo("#transactions");
		});
		$("#list").fadeIn(1000);
	}
	
	
	
</script>



</head>
<body>

	<div class="nav">
      <div class="container">
        <ul class="pull-left">
          <li><a href="#">Name</a></li>
          <li><a href="#">Browse</a></li>
        </ul>
        <ul class="pull-right">
          <li><a href="#">Sign Up</a></li>
          <li><a href="#">Log In</a></li>
          <li><a href="#">Help</a></li>
        </ul>
      </div>
    </div>

	

    <div class="showvideo">
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
    
    <div class="showcontents">
    	<div class="container">
    		<div class="row">
	      		<div class="col-md-8">
	      		
	      			<table id="list" border="1" width="200">
			<tr>
				<th>Transaction ID</th>
				<th>Ticket ID</th>
				<th>Method</th>
				<th>Quantity</th>
				<th>Time</th>				
				<th>Status</th>
				<th>Select</th>
			</tr>
			<tbody id="transactions"></tbody>
		</table>
	      		
	      		</div>
	      	
	      	
	      		<div class="col-md-4">
	      		
	      				<p><input type="number"  style="display:none" id="userid" name="userid" value="4903"/>
				<p>username :	<input id="username" name="username" value="yefuzheng3@gmail.com" readonly="true"/></p>
				<p>password :	<input type="text" id="password" name="password" value="******"/></p>
				<p>Firstname: 	<input type="text" id="firstname" name="firstname"/></p>
				<p>Lastname : 	<input type="text" id="lastname" name="lastname"/></p>
				<p>Address  : 	<input type="text" id="address" name="address"/></p>
				<p>Phone    : 	<input type="text" id="phone" name="phone"/></p>
				
				<button type="submit" id="findAll">Show All Transactions</button>		
	      		
	      		
	      		</div>
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

</body>
</html>