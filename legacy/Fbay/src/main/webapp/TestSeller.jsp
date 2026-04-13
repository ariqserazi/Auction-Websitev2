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
<%

    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
    String ItemName = request.getParameter("ItemName");
    String Color = request.getParameter("Color");
    String Brand = request.getParameter("Brand");
    String size = request.getParameter("size");
    String Initial_Price1 = request.getParameter("Initial_Price");
    String Bid_Increment1 = request.getParameter("Bid_Increment");
    String Min_Price1 = request.getParameter("Min_Price");
/*     String countOfDays = request.getParameter("countOfDays");
    int count = Integer.parseInt(countOfDays); */
    int count = 10;
    double Initial_Price = Double.parseDouble(Initial_Price1);
    double Bid_Increment = Double.parseDouble(Bid_Increment1);
    double Min_Price = Double.parseDouble(Min_Price1);  
    Date today = new Date();
 	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
 	String current = dateFormat.format(today);
 	java.sql.Date StartDate =  java.sql.Date.valueOf(current);
 	//Create a Calendar object
 	Calendar c = Calendar.getInstance();
 	//Set the date to the current date
 	c.setTime(dateFormat.parse(current));
 	//Add the count variable of days to the date
 	c.add(Calendar.DATE, count);
 	java.sql.Date EndDate =  java.sql.Date.valueOf(dateFormat.format(c.getTime()));
 	

    //int ItemID = 0; 
    ResultSet str;
/*   	out.println(ItemID+1);
    out.println(Color);
    out.println(Brand);
    out.println(size);
    out.println(ItemID);
    out.println(ItemID); */

    int ItemID = 0; 
    ResultSet str1;
    	
    int x = stmt.executeUpdate("insert into Item(ItemName, Color, Brand, size) values( '" + ItemName+ "', '" +Color+ "','" +Brand + "','" + size + "')");
	str1 = stmt.executeQuery(" select ItemID from (select * from Item order by ItemID desc limit 1) MostRecID");
	if (str1.next()) {
		ItemID = str1.getInt(1);
	}
	int y = stmt.executeUpdate("insert into Auction (ItemID , EndDate, StartDate, countOfDays, Initial_Price, Bid_Increment, Min_Price) values( "+ ItemID + " , '" + EndDate+ "', '" +StartDate+ "','"+ count + "','" +Initial_Price + "','" + Bid_Increment + "','"+ Min_Price + "')");
	int z = stmt.executeUpdate("insert into " +ItemName + " (ItemID) values( " + ItemID + " )");
   	response.sendRedirect("redirect.jsp");
    
    
    %>
    
<% if ((session.getAttribute("Account") == null)) { %> 
You are not logged in<br/>
<a href="Customer_Login.jsp">Please Login</a>
<%} else { %>
<%=session.getAttribute("Account") %>  


<%
    }
%>
</body>
</html>