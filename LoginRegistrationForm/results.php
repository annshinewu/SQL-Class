<?php
$connection = pg_connect ("host= localhost dbname= postgres user= postgres password= annshine");

if($connection) {
    echo 'connected';
} else {
    echo 'there has been an error connecting';
}
$query = "SELECT dep_id FROM department WHERE label = '$_POST[Department]'";
$id = pg_query($query);
$id = pg_fetch_result($id, 0, 0);

$usernameCookie = $_COOKIE['username'];
$emailCookie = $_COOKIE['email'];

$secondEmail = $_POST[secondEmail];
$firstName = $_POST[firstName];
$lastName = $_POST[lastName];
$address = $_POST[address];

$userQuery = "SELECT id FROM users where username = '$usernameCookie' AND email = '$emailCookie'";
$userId = pg_query($userQuery);
$userId = pg_fetch_result($userId, 0, 0);

$time = 'CURRENT_TIMESTAMP';

$query = "INSERT INTO profile (id, username, email, secondEmail, firstName, lastName, address, dep_id, lastUpdate)
VALUES ($userId, '$usernameCookie', '$emailCookie','$secondEmail', '$firstName','$lastName', '$address', $id, $time)";
$result = pg_query($query);

$cookie_name = "login";
$cookie_value = 'true';
setcookie($cookie_name, $cookie_value, time() + (10), "/");

header("location: welcome.php"."?name=".$usernameCookie."&email=".$emailCookie);
exit;
?>
