<?php
require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");

pg_close($connection);
?>


<!DOCTYPE html>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="formStyle.css"/>
    <title> Profile Edit Form: </title>
</head>
<body>
<h1> Profile Edit Form: </h1>
<form class = "form-style-5" action="profile.php" method = post>
    <br> Username: <br>
    <input type= "text" name="username">
    <br> Password: <br>
    <input type= "text" name="password">
    <br> Contact Email: <br>
    <input type= email name= "email">
    <br> Birthday: <br>
    <input type= "text" name= "birthday">
    <br> Activity: <br>
    <input type= "text" name= "activity">
    <br> University: <br>
    <input type= "text" name= "university">
    <br> Major: <br>
    <input type= "text" name= "major">
    <br> <br>
    <input type="submit" value="Submit">
    <input type="reset">
    </select>
    <br>
</form>
</body>
</html>