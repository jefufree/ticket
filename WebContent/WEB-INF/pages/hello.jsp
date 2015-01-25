<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<p>${msg}</p>
	<form action="result.html" method="post">
		 
		<p>
			password : <input type="text" name="password" />
		</p>
		<p>
			dep : <input type="text" name="dep" />
		</p>
		<input type="submit" value="Add User" />
	</form>
</body>
</html>