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
	<% if ((session.getAttribute("Admin") == null)) { %> // checks if in session
	You are not logged in<br/>
	<a href="Admin_Login.jsp">Please Login</a>
	<%} else {
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String entity = request.getParameter("type");
			String str = "";
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			if(entity.equals("shirt")){
				str = "select it.ItemID, ab.username, Amount_Earned from Shirt it inner join (select au.ItemID, username, Amount_Earned from Auction au inner join (select ItemID, MAX(amount) as Amount_Earned from Bid group by ItemID) ba ON au.ItemID = ba.ItemID and au.winner <> \"null\") ab ON it.itemID = ab.itemID";
			}
			else if(entity.equals("pants")){
				str = "select it.ItemID, ab.username, Amount_Earned from Pants it inner join (select au.ItemID, username, Amount_Earned from Auction au inner join (select ItemID, MAX(amount) as Amount_Earned from Bid group by ItemID) ba ON au.ItemID = ba.ItemID and au.winner <> \"null\") ab ON it.itemID = ab.itemID";			}
			else{
				str = "select it.ItemID, ab.username, Amount_Earned from Jacket it inner join (select au.ItemID, username, Amount_Earned from Auction au inner join (select ItemID, MAX(amount) as Amount_Earned from Bid group by ItemID) ba ON au.ItemID = ba.ItemID and au.winner <> \"null\") ab ON it.itemID = ab.itemID";
			}
			//out.println(str);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Username");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("ItemID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Amount Earned");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("username"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("ItemID"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("Amount_Earned"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();
			out.print(" <p><a href = 'redirect2.jsp' ><img src = 'F-bay.png' width = '300' height = '50'></a></p>"); 

		} catch (Exception e) {
		}
	}
	%>

</body>
</html>