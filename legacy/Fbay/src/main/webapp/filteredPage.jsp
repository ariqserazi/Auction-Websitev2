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

    
<% if ((session.getAttribute("Account") == null)) { %> 
You are not logged in<br/>
<a href="Customer_Login.jsp">Please Login</a>
<%} else { %>
<%=session.getAttribute("Account") %>  
<%

    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
    String ItemName = request.getParameter("ItemName");
    String Color = request.getParameter("Color");
    String Brand = request.getParameter("Brand");
    String size = request.getParameter("size");
    String SortBy = request.getParameter("sort");
    String order = "";
    switch(SortBy){
    case "ItemID":
    	order = "ItemID";
    	break;
    case "End_Date":
    	order = "EndDate";
    	break;
    case "Initial_Price":
    	order = "Initial_Price";
    	break;
    case "Bid_Increment":
    	order = "Bid_Increment";
    	break;
    default:
    	order = "";
    }

	String str = "SELECT A.ItemID, ItemName, Color, Brand, size, StartDate, EndDAte, countOfDays, Initial_Price, Bid_Increment from Item I inner join Auction A on I.ItemID = A.ItemID where ItemName = '" + ItemName + "' and Color = '" + Color + "' and Brand = '" + Brand + "' and size = '" + size + "' order by "+order;
/* 	String str1 = "S * from Item I , Auction A where I.itemID = A.itemID; "; */
	ResultSet result = stmt.executeQuery(str);
	  out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("ItemID");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("ItemName");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Color");
		out.print("</td>");
		out.print("<td>");
		out.print("Brand");
		out.print("</td>");
		out.print("<td>");
		out.print("size");
		out.print("</td>");
		out.print("<td>");
		out.print("StartDate");
		out.print("</td>");
		out.print("<td>");
		out.print("EndDate");
		out.print("</td>");
		out.print("<td>");
		out.print("countOfDays");
		out.print("</td>");
		out.print("<td>");
		out.print("Initial_Price");
		out.print("</td>");
		out.print("<td>");
		out.print("Bid Increment");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("ItemID"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("ItemName"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("Color"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("Brand"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("size"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("StartDate"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("EndDate"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("countOfDays"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("Initial_Price"));
			out.print("<td>");
			out.print(result.getString("Bid_Increment"));
			out.print("</td>");
			out.print("</td>");
			out.print("</tr>");
			

			

		}
		
		out.print("</table>"); 
		
		out.print(" <p><a href = 'redirect.jsp' ><img src = 'F-bay.png' width = '300' height = '50'></a></p>"); 
   
		con.close();
    
    %>

<%
    }
%>
</body>
</html>