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

<% if ((session.getAttribute("Account") == null)) { %> 
You are not logged in<br/>
<a href="Customer_Login.jsp">Please Login</a>
<%} else { %>
<%=session.getAttribute("Account") %>  
     <%
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
    String question = request.getParameter("question");   
	int x = stmt.executeUpdate("insert into FAQ (Question) values('" +question +"')");
	response.sendRedirect("redirect.jsp");

    
 %>
<%
        }
%>
</body>
</html>