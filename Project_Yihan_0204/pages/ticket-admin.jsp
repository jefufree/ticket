<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
<style>
label{
    font-size: 115%;
}
body{
	background-image: url("img/admin -background.jpg");
	z-index:0;
}
.jumbotron{
	background: white;
	opacity: 0.7;
	z-index:-1;
}

#myModal{
	z-index:10;
}
</style>
<script>
	$(document).ready(function(){
		$("#list").hide();
		$(".set").prop('disabled',true);
		$("#save_tickets").click(function(){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/admin/save",
				type:"get",
				data:{
					dep:$("#dep_input").val(),
					des:$("#des_input").val()
				},	
				dataType:"json",		
				success:showTicket
			});		
		});

		$("#findAll").click(function(){
			$("#ack").html("");
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/admin/printall",
				type:"get",
				dataType:"json",
				success:showAllTicket
			});
		});
		$("#disable").click(function(){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/admin/disable",
				type:"get",
				data:{
					dep:$("#dep").val(),
					des:$("#des").val(),
					date:$("#date").val(),
					time:$("#time").val()
				},				
				dataType:"json",		
				success:showTicket
			});
			return false;
		});
		
		$(".set").click(function(){
			var id = $(this).attr("id");
			switch(id){
				case "setdep":
					var urlval= "http://localhost:8080/Ticket/rest/admin/setdep";
					break;
				case "setdes":
					var urlval= "http://localhost:8080/Ticket/rest/admin/setdes";
					break;
				case "setdate":
					
					var urlval= "http://localhost:8080/Ticket/rest/admin/setdate";
					break;
				case "settime":
					var urlval= "http://localhost:8080/Ticket/rest/admin/settime";
					break;
				case "settotal":
					var urlval= "http://localhost:8080/Ticket/rest/admin/settotal";
					break;
				case "setprice":
					var urlval= "http://localhost:8080/Ticket/rest/admin/setprice";
					break;
			}
			$.ajax({
				url:urlval,
				type:"get",
				data:{
					dep:$("#dep").val(),
					des:$("#des").val(),
					date:$("#date").val(),
					time:$("#time").val(),
					text:$("#text").val()
				},				
				dataType:"json",		
				success:showTicket
			});
			return false;
		});
		
		$("#enable").click(function(){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/admin/enable",
				type:"get",
				data:{
					dep:$("#dep").val(),
					des:$("#des").val(),
					date:$("#date").val(),
					time:$("#time").val()
				},				
				dataType:"json",		
				success:showTicket
			});
			return false;
		});
		$("#date").keyup(function(){
			var inputDate = $("#date").val();
			var rx1 = /^([2-9]\d{3}((0[1-9]|1[012])(0[1-9]|1\d|2[0-8])|(0[13456789]|1[012])(29|30)|(0[13578]|1[02])31)|(([2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00))0229)$/gi;
			if(inputDate==""){
				$("#date_ok").hide();
				$("#date_not_ok").hide();
			}
			else if(rx1.test(inputDate)){
				$("#date_ok").show();
				$("#date_not_ok").hide();
			}else{
				$("#date_not_ok").show();
				$("#date_ok").hide();
			}
			/*
			var resultD = rx1.test(inputDate);
			$("#dateCheck").text(resultD);
			*/
		});
		$("#time").keyup(function(){		
			
			var inputTime = $("#time").val();
			var rx2 =/^(([0-1][0-9])|([1-2][0-3]))([0-5][0-9])$/gi;
			if(inputTime==""){
				$("#time_ok").hide();
				$("#time_not_ok").hide();
			}
			else if(rx2.test(inputTime)){
				$("#time_ok").show();
				$("#time_not_ok").hide();
			}else{
				$("#time_not_ok").show();
				$("#time_ok").hide();
			}
			/*
			var resultT = rx2.test(inputTime);
			$("#timeCheck").text(resultT);
			*/
		});
		$("#text").keyup(function(){			
			var newVal = $("#text").val();
			var rx1 = /^([2-9]\d{3}((0[1-9]|1[012])(0[1-9]|1\d|2[0-8])|(0[13456789]|1[012])(29|30)|(0[13578]|1[02])31)|(([2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00))0229)$/gi;
			var rx2 = /^(([0-1][0-9])|([1-2][0-3]))([0-5][0-9])$/gi;
							
			if($.isNumeric($("#text").val())){
				$(".set").prop('disabled',false);
				if(!rx2.test(newVal)){
					$("#settime").prop('disabled',true);
				}
				if(!rx1.test(newVal)){
					$("#setdate").prop('disabled',true);
				}
			}else if(!newVal){
				$(".set").prop('disabled',true);
			}else{
				$("#setdep").prop('disabled',false);
				$("#setdes").prop('disabled',false);
				/*
				$("#settotal").prop('disabled',false);
				$("#setprice").prop('disabled',false);
				*/
			}				
			
		});
	});
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
					date +"</td><td>" + time +"</td><td>" + price +"</td><td>" + total 
					+"</td><td>" + sold +"</td><td>" + ave+ "</td><td align=\"center\"> <input name=\"selectedItems\" onClick=\"change()\" type=\"radio\"  value=\""+(i+1)+"\"/></tr>";
			$(rows).appendTo("#tickets");
		});
		$("#list").fadeIn(1000);
	}
	function showTicket(data){
		if(data==null){
			$("#ack").html("Illigal ");
			}
		else{
			var rows ="";
			$("#tickets").empty();
			var tid= data.tid;
			var dep= data.dep;
			var des = data.des;
			var date = data.depdate;
			var time = data.deptime;
			var price = data.price;
			var total = data.total;
			var sold = data.sold;
			var ave = data.available;
			rows = "<tr><td>" + tid +"</td><td>" + dep  +"</td><td>" + des +"</td><td>" + 
					date +"</td><td>" + time +"</td><td>" + price +"</td><td>" + total 
					+"</td><td>" + sold +"</td><td>" + ave+ "</td><td align=\"center\"> <input name=\"selectedItems\" onClick=\"change()\" type=\"radio\"  value=\""+1+"\"/></tr>";
					
			$(rows).appendTo("#tickets");
			$("#ack").html("Ticket No. "+tid+" modified!");
			$("#list").fadeIn(1000);
			$("#dep").val(dep);
			$("#des").val(des);
			$("#date").val(date);
			$("#time").val(time);
		}
	}
	function change(){
		var line = $("input[name='selectedItems']:checked").val()

		$("#dep").val($("tr:nth-child("+line+") td:nth-child(2)").html());
		$("#des").val($("tr:nth-child("+line+") td:nth-child(3)").html());
		$("#date").val($("tr:nth-child("+line+") td:nth-child(4)").html());
		$("#time").val($("tr:nth-child("+line+") td:nth-child(5)").html());
		var ave = $("tr:nth-child("+line+") td:nth-child(9)").html();
		$("#dateCheck").text("true");
		$("#timeCheck").text("true");
		if(ave!=-1){
			$(".set").hide();
			$("#settotal").show();
		}else{
			$(".set").show();
		}	
	}
</script>
</head>
<body ng-app>
<div class="container">
	<div class="jumbotron">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-2"></div>
		<div class="col-md-4"></div>
		<sec:authorize ifAllGranted="ROLE_ADMIN">
			<div id="user_name_logedin" class="col-md-2"><sec:authentication property="name"/></div>
			<c:url value="/j_spring_security_logout" var="logoutUrl"/>
			<div class="col-md-2">
				<a href="${logoutUrl}">Log Out</a>
			</div>
			</sec:authorize>
	</div>
	<h2>Search and modify:</h2>
	<div class="row">
		<div class="col-md-6">
			<form class="form-horizontal" role="form">
				
				<div class="form-group">
					<div class="col-md-2"></div>
					<label class="control-label col-md-3" for="dep">Departure : </label>
					<div class="col-md-7">
						<input class="form-control" type="text" id="dep" name="dep"/>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-md-2"></div>
					<label class="control-label col-md-3" for="des">Destination :</label>
				 	<div class="col-md-7">
						<input class="form-control" type="text" id="des" name="des"/>
				 	</div>
				</div>
				
				<div class="form-group">
					<div class="col-md-2"></div>
					<label class="control-label col-md-3" for="date">Date :</label>
				 	<div class="col-md-7">
						<input class="form-control" type="text" id="date" placeholder="YYYYMMDD"/>
						<span id="date_ok" class="glyphicon glyphicon-ok" style="display:none"></span>
						<span id="date_not_ok" class="glyphicon glyphicon-remove" style="display:none"></span>
				 	</div>
				</div>
				
				<div class="form-group">
					<div class="col-md-2"></div>
					<label class="control-label col-md-3" for="time">Time :</label>
				 	<div class="col-md-7">
						<input class="form-control" type="text" id="time" placeholder="HHMM"/>
						<span id="time_ok" class="glyphicon glyphicon-ok" style="display:none"></span>
						<span id="time_not_ok" class="glyphicon glyphicon-remove" style="display:none"></span>
				 	</div>
				</div>
				
				<div class="form-group">
					<div class="col-md-2"></div>
					<label class="control-label col-md-3" for="text">New Value :</label>
				 	<div class="col-md-7">
						<input class="form-control" type="text" id="text"/>
				 	</div>
				</div>
		
			</form>
		</div>
		<div class="col-md-4">
			<div class="row">
				<div class="col-md-2"></div>
				<button type="submit" class="btn btn-success col-md-4" id="findAll">Show All Tickets</button>
				<div class="col-md-1"></div>
				<button type="button" class="btn btn-success col-md-4" id="addnew"  data-target="#myModal" data-toggle="modal">Add new ticket</button>
			</div>
			</br>
			
			
			<div class="row">
				<div class="col-md-2"></div>
				<button class="set btn btn-success col-md-4" type="button" id="setdep">Set Departure</button>
				<div class="col-md-1"></div>
				<button class="set btn btn-success col-md-4" type="button" id="setdes">Set Destination</button>
			</div>
			</br>
					
			<div class="row">
				<div class="col-md-2"></div>
				<button class="set btn btn-success col-md-4" type="button" id="setdate">Set Date</button>
				<div class="col-md-1"></div>
				<button class="set btn btn-success col-md-4" type="button" id="settime">Set Time</button>
			</div>
			</br>	
					
			<div class="row">
				<div class="col-md-2"></div>
				<button class="set btn btn-success col-md-4" type="button" id="settotal">Set Total</button>
				<div class="col-md-1"></div>
				<button class="set btn btn-success col-md-4" type="button" id="setprice">Set Price</button>
			</div>
			</br>		
					
			<div class="row">
				<div class="col-md-2"></div>
				<button type="button" class="btn btn-success col-md-9" id="enable">Enable the ticket</button>
			</div>
			</br>
				
		</div>
	</div>
	<br/>
	<div class="container2">
		<table  id="list"  class="table table-hover">
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
	</div>
<div class="modal fade" id="myModal" >
	<div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
          <h3 class="modal-title">All Tickets</h3>
        </div>
        <div class="modal-body">
        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">dep:</label>
	            <input type="text" class="form-control" id="dep_input"/>
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label">des:</label>
	            <input type="text" class="form-control" id="des_input"/>
	          </div>
        </form>
		</div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default " data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" data-dismiss="modal" id="save_tickets" >Save Tickets</button>
        </div>
				
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
 </div>
</div>
</body>
</html>