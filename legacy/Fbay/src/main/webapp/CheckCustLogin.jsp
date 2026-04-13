<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Checking Login</title>

</head>
<body>
	<%@ page import ="java.sql.*" %>
<%

    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
    String username = request.getParameter("username");   
    String password = request.getParameter("password");
	
    ResultSet str;
 
    str = stmt.executeQuery("select * from Account where username='" + username + "'");
    
    if (str.next()){
    	 ResultSet str1;
    	    str1 = stmt.executeQuery("select * from Account where username='" + username + "' and password='" + password + "'"); //executes query that gives that tries to request the given username from DB if it is there
    	    if (str1.next()) { //goes through each username and password and compares with the given username and passwprd
    	    	session.setAttribute("Account", username); // the username will be stored in the session
    	        response.sendRedirect("redirect.jsp"); //gets redirected to a welcome page
    	    } else {
    	        out.println("Invalid password: Please Try Again --> <a href='Customer_Login.jsp'> Go back to Login Page</a>");
    	    }
    }
    else{
    	out.println("Invalid username: Please Try Again --> <a href='Customer_Login.jsp'> Go back to Login Page</a>");
    }
%>
</body>
</html>