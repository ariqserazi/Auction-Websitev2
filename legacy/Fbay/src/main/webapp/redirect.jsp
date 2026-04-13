<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<!DOCTYPE html >
<html>
   <head>
        <title>
            Welcome
        </title>
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
                background-color: blue;
                color:white;
                padding: 2px 20px;
                margin: 8px;
                cursor: pointer;
                width: 10%;
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
            .sell{
                background-color: ghostwhite;
                color: black;
                padding: 10px 50px;
                text-align: center;
                font-size: 15px;
                cursor: pointer;
            }
            .saved{
                background-color: ghostwhite;
                color: black;
                padding: 10px 40px;
                text-align: center;
                font-size: 15px;
                cursor: pointer;
            }
            .FAQ{
                background-color: ghostwhite;
                color: black;
                padding: 10px 40px;
                text-align: center;
                font-size: 15px;
                cursor: pointer;
                Width: 8.5%;
            }
            h1{
                text-align: center;
            }
        </style>
    </head>
<body>
<% if ((session.getAttribute("Account") == null)) { %> // checks if in session
You are not logged in<br/>
<a href="Customer_Login.jsp">Please Login</a>
<%} else { %>
<h1 > Welcome  <%=session.getAttribute("Account") %>  </h1>
     	<br><br><br><br>
        <a href="SearchPage.jsp" ><button class = "questionbutton">See All Auctions</button></a>
       <br>
        <form method = "post" action = "filteredPage.jsp">
            <br>
                 <!-- Drop down for item type -->
                 <label for = "ItemName">Select item type:</label>
                 <select name ="ItemName" id = "ItemName">
                    <option value = "select">select</option>
                     <option value = "Shirt">Shirt</option>
                     <option value = "Pants">Pants</option>
                     <option value = "Jacket">Jacket</option>
                 </select>
                 <br> <br>
                 <!-- Drop down for color -->
                 <label for = "Color">Select item color:</label>
                 <select name = "Color" id = "Color">
                    <option value = "select">select</option>
                     <option value = "Black">Black</option>
                     <option value = "White">White</option>
                     <option value = "Red">Red</option>
                     <option value = "Orange">Orange</option>
                     <option value = "Yellow">Yellow</option>
                     <option value = "Green">Green</option>
                     <option value = "Blue">Blue</option>
                     <option value = "Purple">Purple</option>
                 </select>
                 <br><br>
                 <!-- Drop down for brands -->
                 <label for = "Brand">Select item brand:</label>
                 <select name = "Brand" id = "Brand">
                    <option value = "select">select</option>
                     <option value = "Nike">Nike</option>
                     <option value = "Adidas">Adidas</option>
                     <option value = "Vineyard Vines">Vineyard Vines</option>
                     <option value = "North Face">North Face</option>
                     <option value = "Columbia">Columbia</option>
                     <option value = "Uniqlo">Uniqlo</option>
                     <option value = "Gucci">Gucci</option>
                     <option value = "Chanel">Chanel</option>
                     <option value = "Dior">Dior</option>
                     <option value = "Louis Vuitton">Louis Vuitton</option>
                     <option value = "Lululemon">Lululemon</option>
                     <option value = "Under Armour">Under Armour</option>
                 </select>
                 <br><br>
                 <!-- Drop down for size -->
                 <label for = "size">Select item size:</label>
                 <select name = "size" id = "size">
                     <option value = "select">select</option>
                     <option value = "XS">XS</option>
                     <option value = "S">S</option>
                     <option value = "M">M</option>
                     <option value = "L">L</option>
                     <option value = "XL">XL</option>
                     <option value = "XXL">XXL</option>
                 </select>
                 <br><br>
                  <!-- Drop down for sorting -->
                 <label for = "size">Sort by:</label>
                 <select name = "sort" id = "sort">
                     <option value = "ItemID">ItemID</option>
                     <option value = "End_Date">End Date</option>
                     <option value = "Initial_Price">Initial Price</option>
                     <option value = "Bid_Increment">Bid Increment</option>
                 </select>
                 <br>
                 <button class = "searchbutton">search</button>

        </form>
        <br>
         <form method = "post" action = "buyer_Page.jsp">
            <h2>Input the Item ID of the Item you want to buy,input your amount, and Input the bid Type?</h2>
            <pre><strong>Normal Bid:    </strong></pre>
            <input type = "text" name = "ItemID"  placeholder = "Type your ItemID here">
            <button class = "questionbutton">Bid</button>
            
         
         
              
        </form>
        <form method = "post" action = "auto_buyer_page.jsp">
        <pre><strong>Auto Bid:         </strong></pre>
        <input type = "text" name = "ItemID2"  placeholder = "Type your ItemID here">
             <input type = "text" name = "MaxBid"  placeholder = "Type your Amount here">

                  <button class = "questionbutton">Bid</button>
        
        
        </form>
        <form method = "post" action = "InputQuestions.jsp">
            <h2>Have a question?</h2>
            <input type = "text" name = "question"  placeholder = "Type your question here">
            <button class = "questionbutton">ask</button>
        </form>
        <br>
        <form method = "post" action = "Auction2.jsp">
            <h2>Username of the person you wanna find auctions for</h2>
            <input type = "text" name = "username"  placeholder = "Type username here">
            <button class = "questionbutton">Enter</button>
        </form>
        <br>
        <form method = "post" action = "ShowBids.jsp">
            <h2>History Of Bids for Specific Auction</h2>
            <input type = "text" name = "ItemID"  placeholder = "Type AuctionID here">
            <button class = "questionbutton">Enter</button>
        </form>
        <br><br>
        <br><br>
          <a href="seller_Page.jsp" > <button class = "sell">Sell</button></a>
        <br> <br>

       <a href="saved.jsp" > <button class = "saved">Saved</button></a>
        <br>
        <br>
         <a href = "FAQ.jsp" ><button class = "FAQ">FAQ</button></a>
        <div class = "topright">
         <a href="logout.jsp" ><button class = "logout">Logout</button></a>
        </div>
        <div class = "topleft"> 
        <p><a href = "redirect.jsp" ><img src = "F-bay.png" width = "300" height = "50"></a></p>

        </div>
<%
    }
%>


</body>
</html>