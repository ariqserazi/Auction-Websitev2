<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date,  java.text.SimpleDateFormat, java.lang.Double"%>

<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sell Page Back end </title>
</head>
<body>
<%@ page import ="java.sql.*" %>

    
<% if ((session.getAttribute("CustomerRep") == null)) { %> 
You are not logged in<br/>
<a href="CustomerRepLogin.jsp">Please Login</a>
<%} else { %>
<%=session.getAttribute("CustomerRep") %>  
<%

    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();


	String str = "SELECT username from Account";
/* 	String str1 = "S * from Item I , Auction A where I.itemID = A.itemID; "; */
	ResultSet result = stmt.executeQuery(str);
	  out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("username(s)	:");
		out.print("</td>");
		//make a column
	
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("username"));
			out.print("</td>");
			
			out.print("</tr>");
			

			

		}
		
		out.print("</table>"); 
		
		out.print(" <p><a href = 'redirect3.jsp' ><img src = 'F-bay.png' width = '300' height = '50'></a></p>"); 
   
		con.close();
    
    %>

<%
    }
%>
</body>
</html>