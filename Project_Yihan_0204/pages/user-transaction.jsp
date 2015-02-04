<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User's Transactions</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>



<script>
	$("document").ready(function(){
		$("#list").hide();
		$("#findAll").click(function(){
			$("#ack").html("");
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/userticket/usertransactions",
				type:"get",
				data:{
					username:$("#user_name_logedin").text()
				},
				dataType:"json",
				success:showAllTransaction
			});
		});
		$("#refund").click(function(){
			$.ajax({
				url:"http://localhost:8080/Ticket/rest/userticket/refund",
				type:"get",
				data:{
					transactionid:$("#transactionid").val(),
					tid:$("#tid").val(),
					quantity:$("#quantity").val()
				},
				dataType:"json"
				
			});
			alert("Refund");
			return false;
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
			if(status!="r"){
			rows = "<tr><td>"+transactionid+ "</td><td>"+tid+ "</td><td>"+method+ "</td><td>"+
				quantity+ "</td><td>"+time+ "</td><td>"+status+ 
				"</td><td align=\"center\"> <input name=\"selectedItems\" onClick=\"change()\" type=\"radio\" value=\""+(i+1)+"\"/></tr>";
			}else{
				rows = "<tr><td>"+transactionid+ "</td><td>"+tid+ "</td><td>"+method+ "</td><td>"+
				quantity+ "</td><td>"+time+ "</td><td>"+status+ 
				"</td></tr>";
			}
				$(rows).appendTo("#transactions");
		});
		$("#list").fadeIn(1000);
	}
	
	function change(){
		var line = $("input[name='selectedItems']:checked").val()

		$("#transactionid").val($("tr:nth-child("+line+") td:nth-child(1)").html());
		$("#tid").val($("tr:nth-child("+line+") td:nth-child(2)").html());
		//$("#date").val($("tr:nth-child("+line+") td:nth-child(4)").html());
		$("#quantity").val($("tr:nth-child("+line+") td:nth-child(4)").html());
		
		//$("#quantity2").val($("#quantity").val());
	} 
	
	
	
</script>



</head>
<body>
	
    			
    			
    			
    	<h3>Transaction History</h3>
			<p><input type="number"  style="display:none" id="userid" name="userid" value="4903"/>
			<p>username:	<input id="username" name="username" value="yefuzheng3@gmail.com" readonly="true"/></p>
			<p>password:	<input type="text" id="password" name="password" value="******" readonly="true"/></p>
		<!-- <p>Firstname: 	<input type="text" id="firstname" name="firstname"/></p>
		<p>Lastname: 	<input type="text" id="lastname" name="lastname"/></p>
		<p>Address: 	<input type="text" id="address" name="address"/></p>
		<p>Phone: 		<input type="text" id="phone" name="phone"/></p>
		
		<p>Date : <input type="text" id="date" placeholder="YYYYMMDD"/></p><p id="dateCheck"></p>
		<p>Time : <input type="text" id="time" placeholder="HHMM"/><div id="timeCheck"></div></p> -->
		
			<button type="submit" id="findAll">Show All Transactions</button>
		
		<br/>
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
		
		<form>
			<input	style="display:none" type="text" id="transactionid" name="transactionid"/>
			<input 	style="display:none" type="text" id="tid" name="tid"/>
			<input 	style="display:none" type="number" id="quantity" name="quantity"/>
			<button type="submit" id="refund">Refund</button>
		</form>
    	
    	<sec:authorize ifAllGranted="ROLE_USER">
			<div id="user_name_logedin"><sec:authentication property="name"/></div>
			<c:url value="/j_spring_security_logout" var="logoutUrl"/>
			<a href="${logoutUrl}">Log Out</a>
		</sec:authorize>		
    			
    	
    			
        			
</body>
</html>