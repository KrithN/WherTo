<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WhereTo? Reach places quickly</title>
<link rel="stylesheet" href="css/header.css">


</head>
<body background="Images/background1.png">

<table class="center">
<tr>
<td></td>
<td><p id="heading">Where To</p></td>
<td></td><td></td>


<td><p id="conn">Reach fast!</p></td>
</tr>
</table>
<table>
<tr>
<td></td><td></td><td colspan="3" id="login">Hi User !</td>
</tr>
</table>

<hr>



<div class="tabs">
<form action="MoveController" method="POST">
<table>
<tr>
<td><input  id="pad" type="submit" name="butn" value="Search & Move" /></td>
<td><input  id="pad" type="submit" name="butn" value="Find Directions on Map" /></td>

</tr>
</table>
</form>
</div>


<div class="footer">
<p><a href="#"> About Us </a> |<a href="#"> Contact Us</a></p>
  <p id="smallFont">Powered by NextBillion.ai</p>
</div>

<!-- Ends the Default of all pages -->

</body>
</html>