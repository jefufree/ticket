<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script>
	/*
	$(document).ready(function(){
		$("#addForm").on("submit",function(){
			$("#transactionlist").show();
			return false;
		});
		
	});*/
</script>

</head>
<body>
	<p>${msg}</p>
	
	<table id="transactionslist" border="1" width="200">
		<c:forEach var="transaction" items="${list}">
		<tr>
			<td>${transaction.userid}</td>
			<td>${transaction.tid}</td>
		</tr>
		</c:forEach>
	</table>
	<form action="result.html" method="post" id="addForm">
		<p>
			password : <input type="text" name="password" />
		</p>
		<p>
			dep : <input type="text" name="dep" />
		</p>
		<input type="submit" id="add" value="Add User" />
	</form>
</body>
</html>