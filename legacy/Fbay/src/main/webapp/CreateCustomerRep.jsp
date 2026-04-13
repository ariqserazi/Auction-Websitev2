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
    ResultSet rs;
    rs = stmt.executeQuery("select * from CustomerRep where RepUser ='" + userid + "'");
    if (rs.next()) {
    	out.println("Username exists, please try another <a href='CreateNewCustomerRep.jsp'>try again</a>");
    } else {
    	int x = stmt.executeUpdate("insert into CustomerRep (RepUser, RepPassword) values('" +userid+ "', '" +pass + "')");
    	session.setAttribute("CustomerRep", userid); // the username will be stored in the session
        response.sendRedirect("redirect2.jsp");
    	
    }
%>