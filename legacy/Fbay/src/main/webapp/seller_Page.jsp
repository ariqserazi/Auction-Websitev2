<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date,  java.text.SimpleDateFormat, java.lang.Double"%>

<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
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
            *{
                box-sizing: border-box;
            }
            input [type = "text"]{
                width: 100%;
                height: 5px;
                padding: 25px;
                margin: 55px 0 22px 0;
                border: none;
                outline: none;
                background: whitesmoke;
            }
            .topright{
                position: absolute;
                right: 10px;
                top: 10px;
            }
            .topleft{
                position: absolute;
                top: 10px;
                left: 0px;
            }
            .topmiddle{
                position: absolute;
                vertical-align: middle;
                top: 10px;
            }
            .logout{
                background-color: ghostwhite;
                color: red;
                padding: 10px 20px;
                text-align: center;
                font-size: 10px;
                cursor: pointer;
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
            .Create_Listing {
                background-color: darkcyan;
            }
        </style>
    </head>
    <body>
        <form method = "post" action = "seller_Page_BackEnd.jsp">>
            <br><br><br><h1>Create Listing Details</h1>
            <!-- Drop down for item type -->
            <label for = "ItemName">Select item type:</label>
            <select name ="ItemName" id = "ItemName">
                <option value = "Shirt">Shirt</option>
                <option value = "Pants">Pants</option>
                <option value = "Jacket">Jacket</option>
            </select>
            <br> <br>
            <!-- Drop down for color -->
            <label for = "Color">Select item color:</label>
            <select name = "Color" id = "Color">
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
                <option value = XS>XS</option>
                <option value = "S">S</option>
                <option value = "M">M</option>
                <option value = "L">L</option>
                <option value = "XL">XL</option>
                <option value = "XXL">XXL</option>
            </select>
            <br><br>
            <!-- Drop down for end date -->
            <label for = "countOfDays">Set end of auction:</label>
            <select name = "countOfDays" id = "countOfDays">
                <option value = "1">1 day</option>
                <option value = "2">2 day</option>
                <option value = "3">3 day</option>
                <option value = "4">4 day</option>
                <option value = "5">5 day</option>
                <option value = "6">6 day</option>
                <option value = "7">7 day</option>
                <option value = "8">8 day</option>
                <option value = "9">9 day</option>
                <option value = "10">10 day</option>
            </select>
            <br><br>
            <!-- Drop down for bid increment -->
            <label for = "Bid_Increment">Set bid increment:</label>
            <select name = "Bid_Increment" id = "Bid_Increment">
                <option value = "1.00">$1.00</option>
                <option value = "5.00">$5.00</option>
                <option value = "10.00">$10.00</option>
                <option value = "20.00">$20.00</option>
                <option value = "25.00">$25.00</option>
                <option value = "30.00">$30.00</option>
                <option value = "35.00">$35.00</option>
                <option value = "40.00">$40.00</option>
                <option value = "45.00">$45.00</option>
                <option value = "50.00">$50.00</option>
                <option value = "100.00">$100.00</option>
            </select>
            <br><br>
            <!-- Initial Price bar -->
            <input type = "text" id = "Initial_Price" name = "Initial_Price" placeholder = "Initial Price">
            <br><br>
            <!-- Reserve -->
            <input type = "text" id = "Min_Price" name = "Min_Price" placeholder = "Minimum Price">
            <br><br><input type = "submit" class = "Create_Listing" value = "Create Listing">
        </form>
        <!-- Logout Button -->
        <div class = "topright">
           <a href="logout.jsp" ><button class = "logout"> Logout </button></a> 
        </div>
        <!-- Logo -->
        <div class = "topleft"> 
            <p><a href = 'redirect.jsp' ><img src = "F-bay.png" width = "300" height = "50"></a></p>
            </div>
    </body>
</html>