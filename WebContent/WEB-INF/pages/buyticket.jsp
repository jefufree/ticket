<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html >
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>


<body>
	<p>${msg}</p>
	
	<p>${trans}</p>
	
	<table id="ticketlist" border="1" width="200">
	
		<tr>
			<td>No.</td>
			<td>Dep</td>
			<td>Des</td>
			<td>DepDate</td>
			<td>Price</td>
			<td>Available</td>
			<td>qty</td>
			
		</tr>
		<c:forEach var="ticket" items="${list}">
		
		<tr>
		
			<td>${ticket.tid}</td>
			<td>${ticket.dep}</td>
			<td>${ticket.des}</td>
			<td>${ticket.depdate}</td>
			<td>${ticket.price}</td>
			<td>${ticket.available}</td>
			<td>${quantity}</td>
			
		
		</tr>
		
		</c:forEach>
	</table>
	<!-- <input style="display:none" name="qty" value="${quantity}"/> -->
	
	<form action="buying.html" method=get>
	
	<button type="submit" ></button>
	</form>
	<form action="usersearch.html" method="post" id="searchForm">
		<p>
			DEP: <input type="text" name="dep" />
		</p>
		<p>
			DES : <input type="text" name="des" />
		</p>
		<p>
			DEPDATE : <input type="text" name="depdate" />
		</p>
		<p>
			QTY : <input type="number" name="quantity" />
		</p>
		<input type="submit" id="search" value="Search" />
	</form>
</body>
</html>