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

<% if ((session.getAttribute("CustomerRep") == null)) { %> 
You are not logged in<br/>
<a href="CustomerRepLogin.jsp">Please Login</a>
<%} else { %>
<%=session.getAttribute("CustomerRep") %>  
     <%
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
    String Answer = request.getParameter("Answer");   
    String QuestionID = request.getParameter("QuestionID");   

	
    ResultSet str;

/*     str = stmt.executeQuery("select * from FAQ where QuestionID ='" + QuestionID + "'");
 */
    ResultSet result;
    result = stmt.executeQuery("select * from FAQ where QuestionID='" + QuestionID + "'");
    if (!result.next()) {
    	out.println("Question ID does not exist, please try another <a href='redirect3.jsp'>try again</a>");
    } else {
    	/* //Update FAQ  set Answer = Answer  where QuestionID = 1; */
    	int x = stmt.executeUpdate("Update FAQ set Answer = '" +Answer+ "' where QuestionID = " + QuestionID );
    	response.sendRedirect("redirect3.jsp");
    	
    }

    
 %>
<%
        }
%>
</body>
</html>