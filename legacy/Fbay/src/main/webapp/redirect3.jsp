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
            .searchbutton {
                background-color: red;
                color:white;
                padding: 2px 20px;
                margin: 8px;
                cursor: pointer;
                width: 7%;
                opacity: 0.8;
            }
            .questionbutton {
                background-color: blue;
                color:white;
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
<% if ((session.getAttribute("CustomerRep") == null)) { %> // checks if in session
You are not logged in<br/>
<a href="CustomerRepLogin.jsp">Please Login</a>
<%} else { %>
<h1> Welcome <%=session.getAttribute("CustomerRep") %>  </h1>
   <br>
   <br>
        <a href="question.jsp" ><button class = "questionbutton" > View questions</button></a>
        <br>
        <form method = "post" action = "answer.jsp">
        <input type = "text" id = "QuestionID" name = "QuestionID" placeholder = "Question ID">
        <input type = "text" id = "Answer" name = "Answer" placeholder = "Write answer here">
        <button class = "questionbutton">Submit Answer</button>
        </form>
        <br>
        <br>
        
        <a href="Users.jsp" ><button class = "questionbutton" > View users</button></a>
         <p><b>Remove Users:</b></p>
        <form method = "post" action = "Remove_Users.jsp">
        <input type = "text" id = "username" name = "username" placeholder = "username">
         <button class = "searchbutton">Remove</button>
        </form>
        <p><b>Remove bid:</b></p>
        <form method = "post" action = "Remove_Bid.jsp">
        <input type = "text" id = "Remove_AuctionID" name = "ItemID" placeholder = "ItemID">
        <input type = "text" id = "Remove_Bid" name = "bidID" placeholder = "bidID">
        <select name = "bidType" id = "bidType">
                     <option value = "select">select</option>
                     <option value = "Auto_Bid">Auto Bid</option>
                     <option value = "Bid">Bid</option>
                 </select>
        <button class = "searchbutton">Remove</button>
        </form>
        
        <br><br>
        <a href="Auction.jsp" ><button class = "questionbutton" > View Auctions</button></a>
        <p><b>Remove auction:</b></p>
        <form method = "post" action = "Remove_Auction.jsp">
        <input type = "text" id = "Remove_Auction" name = "AuctionID" placeholder = "AuctionID">
        <button class = "searchbutton">Remove</button>
        </form>
        <div class = "topright">
        <a href="LogOutForStaff.jsp" ><button class = "logout"> Logout </button></a> 
        </div>
        <div class = "topleft"> 
        <p><a href = "redirect3.jsp" ><img src = "F-bay.png" width = "300" height = "50"></a></p>

        </div>
<%
    }
%>


</body>
</html>