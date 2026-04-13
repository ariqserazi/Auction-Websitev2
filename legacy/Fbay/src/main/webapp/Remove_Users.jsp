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
<% if ((session.getAttribute("CustomerRep") == null)) { %> // checks if in session
You are not logged in<br/>
<a href="CustomerRepLogin.jsp">Please Login</a>
<%} else { %>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	//Statement stmt3 = con.createStatement();
	String userid = request.getParameter("username");  
	 int result7;
	 int result6;
	 int result5;
	 int result4;
	 int result3;
	 int result2;
	 int result1;
	 int result;
	 String getItem = "Select ItemID from Auction where username = '" + userid + "'";
 	 ResultSet items = stmt2.executeQuery(getItem);
 	 int iid = 0;
 	 String delBid = "";
 	 int result8;
 	 while(items.next()){
 		 iid = items.getInt("ItemID");
 		 delBid = "Delete From Bid where ItemID='"+iid+"'";
 		 result8 = stmt.executeUpdate(delBid);
 	 }
	 result7 = stmt.executeUpdate("Delete From Pants where username= '" + userid + "'");
	 result6 = stmt.executeUpdate("Delete From Shirt where username= '" + userid + "'");
	 result5 = stmt.executeUpdate("Delete From Jacket where username= '" + userid + "'");
	 result2 = stmt.executeUpdate("Delete From Bid where username='" + userid + "'");
	 result3 = stmt.executeUpdate("Delete From Auto_Bid where username= '" + userid + "'");
	 result4 = stmt.executeUpdate("Delete From Auction where username= '" + userid + "'");
	 result1 = stmt.executeUpdate("Delete From Item where username='" +  userid + "'");
	 result = stmt.executeUpdate("Delete From Account where username='" + userid + "'");
     response.sendRedirect("redirect3.jsp");


%>
       
<%
    }
%>
</body>
</html>