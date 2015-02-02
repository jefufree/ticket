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




<script>
$('document').ready(function(){
	if ("<c:out value='${param.login_error}'/>" != "") {
	  	$("#wrongCredentials").show();
	  	$("#login").trigger("click");
	}
	$("#list").hide();
	
	
	
	$("#findAll").click(function(){
		$("#ack").html("");
		$.ajax({
			url:"http://localhost:8080/Ticket/rest/userticket/tickets",
			type:"get",
			dataType:"json",
			success:showAllTicket
		});
		
	});
	
	$("#search").click(function(){
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
			success:showAllTicket
		});
		return false;
	});
	
	$("#buy").click(function(){
		if($("#user_name_logedin").text()!= ""){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/userticket/buy",
				type:"get",
				data:{
					tid:$("#tid").val(),
					userid:$("#userid").val(),
					method:$("#method").val(),
					quantity2:$("#quantity2").val(),
				},
				dataType:"json",
				success:showTransaction
			});
		}
		else{
			alert("123");
		}
		return false;
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
				 $("#register_input").prop('disabled',false);
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
				 $("#register_input").prop('disabled',false);
			 }
		 }
	 });
	
	$("#loginGo").on("click",loginValidation);

});

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
	})
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
		//$("#quantity").val($("tr:nth-child("+line+") td:nth-child(5)").html());
		$("#tid").val($("tr:nth-child("+line+") td:nth-child(1)").html());
		$("#quantity2").val($("#quantity").val());
	}



</script>


</head>
<body>
	
	<button type="button" id="login" data-target="#myModal" data-toggle="modal">Login</button>
	<button type="button" id="register" data-target="#myReg" data-toggle="modal" >Register</button>

	<button type="submit" id="findAll">Show All Tickets</button>
	
	
	<div id="ack"></div>
	<form >
		
		<p>
			dep : <input type="text" id="dep" name="dep"/>
		</p>
		<p>
			des : <input type="text" id="des" name="des"/>
		</p>
		<p>
			date : <input type="text" id="date" name="date" placeholder="YYYYMMDD"/>
		</p>
		<!--  <p>
			time : <input type="text" id="time" placeholder="HHMM"/>
		</p>-->
		<p>
			quantity : <input type="text" id="quantity" name="quantity" placeholder=1 />
		</p>
	
		<!-- <button type="button" id="addnew">Add new ticket</button> -->
		
		<button type="submit" id="search">Search</button>

	</form>
	<br/>
	
	<table id="list" border="1" width="200">
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
		<tbody id="tickets"></tbody>
	</table>
	
	<form>
		<input type="text" id="tid" name="tid"/>
		<input type="text" id="userid" name="userid"/>
		<select id="method" name="method">
  			<option value=0>Card</option>
  			<option value=1>PayPal</option>
		</select>
		<input type="number" id="quantity2" name="quantity2"/>
		<button type="submit" id="buy">Buy</button>
	</form>
	
	<div id="transaction"></div>
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
						<div class="form-group">
							<div class="alert" style="display: none;"
								id="usernameAndPasswordReq">
								<p>Username and password are required</p>
							</div>
							<label for="recipient-name" class="control-label">Username:</label>
							<input type="text" class="form-control" name="j_username"
								id="j_username" />

							<div class="alert" style="display: none;" id="usernameReq">
								<p>Username is required</p>
							</div>
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label">Password:</label>
							<input type="password" class="form-control" name="j_password"
								id="j_password" />
						</div>
						<div class="alert" style="display: none;" id="passwordReq">
							<p>Password is required</p>
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
<div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
          <h3 class="modal-title">Register New User</h3>
        </div>
        <div class="modal-body">
		<form action="successreg.html" role="form" method="post">
	        <div class="form-group">
	          <label for="email">User Name:</label>
	          <input type="email" class="form-control" id="username_input" placeholder="Enter email" name="username">
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
	        	<p>Good to go</p>
	        </div>
	        <button type="button" class="btn btn-default " data-dismiss="modal">Close</button>
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