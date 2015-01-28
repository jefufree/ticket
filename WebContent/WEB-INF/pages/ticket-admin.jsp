<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
<script>
	$(document).ready(function(){
		$("#list").hide();
		$("#findAll").click(function(){
			$("#ack").html("");
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/admin/printall",
				type:"get",
				dataType:"json",
				success:showAllTicket
			});
		});
		$("#addnew").click(function(){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/admin/save",
				type:"get",
				dataType:"text",
				data:{
					dep:$("#dep").val(),
					des:$("#des").val()
				},				
				success:(function(data){
					$("#ack").html(data)
				})
			});
			return false;			
		});
		$("#disable").click(function(){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/admin/disable",
				type:"get",
				dataType:"text",
				data:{
					dep:$("#dep").val(),
					des:$("#des").val(),
					date:$("#date").val(),
					time:$("#time").val()
				},				
				success:(function(data){
					$("#ack").html(data);
				})
			});
			return false;
		});
		$("#enable").click(function(){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/admin/enable",
				type:"get",
				dataType:"text",
				data:{
					dep:$("#dep").val(),
					des:$("#des").val(),
					date:$("#date").val(),
					time:$("#time").val()
				},				
				success:(function(data){
					$("#ack").html(data);
				})
			});
			return false;
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
					date +"</td><td>" + time +"</td><td>" + price +"</td><td>" + 
					 +"</td><td>" + total +"</td><td>" + sold +"</td><td>" + ave+ "</td></tr>";
			$(rows).appendTo("#tickets");
		})
		$("#list").fadeIn(1000);
	}
	
</script>
</head>
<body>
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
			date : <input type="text" id="date"  placeholder="YYMMDD"/>
		</p>
		<p>
			time : <input type="text" id="time" placeholder="HHMM"/>
		</p>
		<p>
			new value : <input type="text" name="newDep" />
		</p>
		<!--  <input type="submit" value="Add Ticket" />-->
		<button type="button" id="addnew">Add new ticket</button>
		<button type="button" id="disable">Disable the ticket</button>
		<button type="button" id="enable">Enable the ticket</button>
		<!-- <button type="submit" id="setdep">Set Departure</button> -->
		<!-- <button type="submit" id="setdes">Set Destination</button> -->
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
		</tr>
		<tbody id="tickets"></tbody>
	</table>
</body>
</html>