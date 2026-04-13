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


	
   
 
 <% if ((session.getAttribute("Account") == null)) { %> 
 You are not logged in<br/>
 <a href="Customer_Login.jsp">Please Login</a>
<%} else { %>
 <%=session.getAttribute("Account") %>  
 <%
 	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
    ResultSet rs;
    
    String str = "SELECT * FROM FAQ WHERE QuestionID >= 0";
    ResultSet result = stmt.executeQuery(str);
    out.print("<table>");

	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td>");
	//print out column header
	out.print("QuestionID");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Question");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Answer");
	out.print("</td>");
	out.print("</tr>");

	//parse out the results
	while (result.next()) {
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//Print out current bar name:
		out.print(result.getString("QuestionID"));
		out.print("</td>");
		out.print("<td>");
		//Print out current beer name:
		out.print(result.getString("Question"));
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(result.getString("Answer"));
		out.print("</td>");
		out.print("</tr>");

	}
	out.print("</table>");
	out.print(" <p><a href = 'redirect.jsp' ><img src = 'F-bay.png' width = '300' height = '50'></a></p>"); 

	//close the connection.
	
	
	con.close();
 
   %>
<%
        }
%>
</body>
</html>