<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.sql.Timestamp"%>
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


/* Date javaDate = new Date();

out.println(javaDate.getTime()); */


// create a new Date object
/* Date startDate = new Date();
int count = 10;

// format the date using the SimpleDateFormat class
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss ");

// print the date to the JSP page
out.println(dateFormat.format(startDate)); 


 String current = dateFormat.format(startDate);

//Create a SimpleDateFormat object



//Create a Calendar object
Calendar c = Calendar.getInstance();

//Set the date to the current date
c.setTime(dateFormat.parse(current));

//Add 10 days to the date
c.add(Calendar.DATE, count);

//Print the new date
out.println(dateFormat.format(c.getTime()));  */
  
Date startDate = new Date();

SimpleDateFormat sdf = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
java.util.Date endDate = sdf.parse("2023:11:2 12:12:12");
/* Date endDate = new Date(); */

long startTime = startDate.getTime();
long endTime = endDate.getTime();
out.println(startTime);
out.println(endTime); 
long timeRemaining = endTime - startTime;
Date remainingTime = new Date();
remainingTime.setTime(timeRemaining);
out.println(sdf.format(startDate));
out.println(remainingTime); 
//seller_Page_BackEnd.jsp


//Create a SimpleDateFormat object
/* SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

//Parse a date string using the SimpleDateFormat object
java.util.Date utilDate = sdf.parse("2022-12-14");

//Convert the util.Date object to an sql.Date object
java.sql.Date sqlDate = java.sql.Date.valueOf(utilDate.toString()); */

    
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