<?php
$connection = pg_connect ("host= localhost dbname= postgres user= postgres password= annshine");

$query = "SELECT * FROM department;";
$result = pg_query($query);

if (!$result) {
       echo "An error occurred.\n";
       exit;
    }

$options = ""; //this is an empty array
while($row = pg_fetch_array($result))
{
 $options = $options."<option>$row[label]</option>";
}
pg_close($connection)
?>


<!DOCTYPE html>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="stylesheet.css"/>
    <title> Teacher Submission Form: </title>
</head>
<body>
<h1> Teacher Submission Form: </h1>
<form class = "form-style-5" action="results.php" method = post>
    <br> First Name: <br>
    <input type= "text" name="FirstName">
    <br> Last Name: <br>
    <input type= "text" name="LastName">
    <br> Email: <br>
    <input type= email name= "Email">
    <br> Departments: <br>
    <select type="select" id="department_id" name="Department">
    <?php echo $options;?> </select>
    <br>
    <input type="submit" value="Submit">
    <input type="reset">
</select>
<br>
</form>
</body>
</html>
