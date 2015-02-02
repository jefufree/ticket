<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
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
			var resultD = rx1.test(inputDate);
			$("#dateCheck").text(resultD);
		});
		$("#time").keyup(function(){			
			var inputTime = $("#time").val();
			var rx2 =/^(([0-1][0-9])|([1-2][0-3]))([0-5][0-9])$/gi;
			var resultT = rx2.test(inputTime);
			$("#timeCheck").text(resultT);
		});
		$("#text").keyup(function(){			
			var newVal = $("#text").val();
			var rx1 = /^([2-9]\d{3}((0[1-9]|1[012])(0[1-9]|1\d|2[0-8])|(0[13456789]|1[012])(29|30)|(0[13578]|1[02])31)|(([2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00))0229)$/gi;
			var rx2 = /^(([0-1][0-9])|([1-2][0-3]))([0-5][0-9])$/gi;
			if(($("#dateCheck").text()=="true")&&($("#timeCheck").text()=="true")){				
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
					$("#settotal").prop('disabled',false);
					$("#setprice").prop('disabled',false);
				}				
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
	<button type="submit" id="findAll">Show All Tickets</button>
	<button type="button" id="addnew"  data-target="#myModal" data-toggle="modal">Add new ticket</button>
	
	
	<p>Search and modify:</p>
	<p>Departure : <input type="text" id="dep" name="dep"/></p>
	<p>Destination : <input type="text" id="des" name="des"/></p>
	<p>Date : <input type="text" id="date" placeholder="YYYYMMDD"/></p><p id="dateCheck"></p>
	<p>Time : <input type="text" id="time" placeholder="HHMM"/><div id="timeCheck"></div></p>
	<p>New Value : <input type="text" id="text" /></p>
		
	<table>
		<tr>
			<th><button type="button" id="enable">Enable the ticket</button></th>
		</tr>
		<tr>
			<th><button class="set" type="button" id="setdep">Set Departure</button></th>
			<th><button class="set" type="button" id="setdes">Set Destination</button></th>
		</tr>
		<tr>
			<th><button class="set" type="button" id="setdate">Set Date</button></th>
			<th><button class="set" type="button" id="settime">Set Time</button></th>
		</tr>
		<tr>
			<th><button class="set" type="button" id="settotal">Set Total</button></th>
			<th><button class="set" type="button" id="setprice">Set Price</button></th>
		</tr>
	</table>
	<div id="ack"></div>
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
	
</body>
</html>