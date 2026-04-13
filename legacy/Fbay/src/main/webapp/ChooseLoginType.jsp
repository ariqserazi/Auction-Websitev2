<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Choose Login Type</title>
<style>
      body {
        font-family: Arial, Helvetica, sans-serif;
        background-color: white;
      }
      * {
        box-sizing: border-box;
      }
      .vertical {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 200px;
      }
      .container {
  height: 200px;
  position: relative;
}

      .registerbtn {
        background-color: lightblue;
        color: black;
        padding: 16px 20px;
        margin: 20px;
        cursor: pointer;
        width: 80%;
        opacity: 0.9;
      }
      .registerbtn:hover {
        opacity: 1;
      }
      a {
        color: blue ;
      }
      .login{
          background: whitesmoke;
          text-align: center;
      }
      .topleft{
                position: absolute;
                top: 10px;
                left: 0px;
            }
  </style>
</head>
<body>
<div class = "topleft"> 
    <a href = 'https://www.ebay.com/' ><img src = "F-bay.png" width = "300" height = "50"></a>
    </div>
    <br>
    <br>
    <br>
<center> <h1> WELCOME TO FBAY CHOOSE YOUR ACCOUNT TYPE</h1></center>
	
<div class = "container"> 
	<div class = "vertical">
    <a href="Customer_Login.jsp" ><button class = "registerbtn">Customer</button></a>
     
     <a href="Admin_Login.jsp"><button class = "registerbtn">Admin</button></a>
     
     <a href="CustomerRepLogin.jsp"><button class = "registerbtn">Customer Rep</button></a>
     </div>
</div>
</body>
</html>