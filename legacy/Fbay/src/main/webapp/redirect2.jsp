<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
        <style>
            body {
                font-family: Helvetica;
                background-color: white;
            }
            * {
                box-sizing: border-box;
            }
            input [type = "text"]{
                width: 100%;
                height: 5px;
                padding: 25px;
                margin: 55px 0 22px 0;
                display: inline-block;
                border: none;
                outline: none;
                background: whitesmoke;
            }
            .report {
                background-color: lightblue;
                color:black;
                padding: 2px 20px;
                margin: 8px;
                cursor: pointer;
                width: 15%;
                opacity: 0.8;
            }
            .questionbutton {
                background-color: lightblue;
                color:black;
                padding: 2px 20px;
                margin: 8px;
                cursor: pointer;
                width: 10%;
                opacity: 0.8;
            }
            .topright{
                position: absolute;
                right: 10px;
                top: 10px;
            }
            .topleft{
                position: absolute;
                top: 1px;
                left: 0px;
            }
            .logout{
                background-color: ghostwhite;
                color: red;
                padding: 10px 20px;
                text-align: center;
                font-size: 10px;
                cursor: pointer;
            }
            h1{
                text-align: center;
            }
        </style>
</head>
<body>
<% if ((session.getAttribute("Admin") == null)) { %> // checks if in session
You are not logged in<br/>
<a href="Admin_Login.jsp">Please Login</a>
<%} else { %>

<br> Do you want to Logout <a href="LogOutForStaff.jsp">Log out</a>
<br>
  <h1 >Welcome <%=session.getAttribute("Admin") %>  </h1>
        <br><br><br><br>
        <a href="CreateNewCustomerRep.jsp" ><button class = "questionbutton">Create Customer Representative</button></a>
       <br>
       
       <form method = "post" action = "TotalEarnings.jsp">
            <h2>Generate sales report for:</h2>
            <input type = "text" name = "username"  placeholder = "Type the username here">
            <button class = "report">Enter</button>
        </form>
       <form method = "post" action = "TypeEarnings.jsp">
        <label for = "size">Select item type:</label>
                 <select name = "type" id = "type">
                     <option value = "select">select</option>
                     <option value = "shirt">Shirt</option>
                     <option value = "pants">Pants</option>
                     <option value = "jacket">Jacket</option>
                 </select>
                 <button class = "report">Item Type</button>
       </form>
       <a href="ItemEarnings.jsp" ><button class = "questionbutton">Best Selling Items</button></a>
       <br>
       <a href="BestBuyers.jsp" ><button class = "questionbutton">Best Buyers</button></a>
       <br>
       
        <div class = "topright">
           <a href="LogOutForStaff.jsp"> <button class = "logout">Logout</button></a>
        </div>
        <div class = "topleft"> 
        <p><a href = 'redirect2.jsp' ><img src = "F-bay.png" width = "300" height = "50"></a></p>
        </div>
<%
    }
%>


</body>
</html>