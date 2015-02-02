<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">



<title>Buy-Ticket</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>




<script>
$('document').ready(function(){
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
	

</body>
</html>