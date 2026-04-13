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
	Integer item = Integer.valueOf(request.getParameter("ItemID"));
	Integer bidID = Integer.valueOf(request.getParameter("bidID"));
	String Type = request.getParameter("bidType");  
	 
	 if(Type.equals("Bid")){
	 	String result7 = "delete From Bid where ItemID = '" + item + "' and bidID = '" +bidID + "'";
		PreparedStatement remove = con.prepareStatement(result7);
		remove.executeUpdate();
	 }
	 else{
		String result7 = "delete From Auto_Bid where ItemID = '" + item + "' and bidID = '" +bidID + "'";
		PreparedStatement remove = con.prepareStatement(result7);
		remove.executeUpdate();
	 }
     response.sendRedirect("redirect3.jsp");


%>
       
<%
    }
%>
</body>
</html>