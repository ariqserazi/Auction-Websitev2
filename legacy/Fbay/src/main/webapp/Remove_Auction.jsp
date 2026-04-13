<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date,  java.text.SimpleDateFormat, java.lang.Double"%>

<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% if ((session.getAttribute("CustomerRep") == null)) { %> 
You are not logged in<br/>
<a href="CustomerRepLogin.jsp">Please Login</a>
<%} else { %>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Integer item = Integer.valueOf(request.getParameter("AuctionID"));
	 
	 String getItem = "Select ItemID from Auction where ItemID = '" + item + "'";
 	 ResultSet items = stmt2.executeQuery(getItem);
 	 int iid = 0;
 	 String delBid = "";
 	 int result8;
 	 while(items.next()){
 		 iid = items.getInt("ItemID");
 		 delBid = "Delete From Bid where ItemID='"+iid+"'";
 		 result8 = stmt.executeUpdate(delBid);
 	 }
	 	String result7 = "delete From Auction where ItemID = '" + item + "'";
		PreparedStatement remove = con.prepareStatement(result7);
		remove.executeUpdate();
		
     response.sendRedirect("redirect3.jsp");


%>
       
<%
    }
%>
</body>
</html>