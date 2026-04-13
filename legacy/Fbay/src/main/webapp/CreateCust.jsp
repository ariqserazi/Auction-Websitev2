<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%

	
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	String userid = request.getParameter("username");   
	String pass = request.getParameter("password");
    ResultSet result;
    result = stmt.executeQuery("select * from Account where username='" + userid + "'");
    if (result.next()) {
    	out.println("Username exists, please try another <a href='CreateNewCust.jsp'>try again</a>");
    } else {
    	int x = stmt.executeUpdate("insert into Account (username, password) values('" +userid+ "', '" +pass+ "')");
    	session.setAttribute("user", userid); // the username will be stored in the session
        response.sendRedirect("Customer_Login.jsp");
    	
    }
%>