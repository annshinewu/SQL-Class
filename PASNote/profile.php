<?php
require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");

if($connection) {
    echo 'connected';
} else {
    echo 'there has been an error connecting';
}

$username = $_POST[username];
$email = $_POST[email];
$password = $_POST[password];
$major = $_POST[major];
$university = $_POST[university];
$activity = $_POST[activity];
$birthday = $_POST[birthday];

$userQuery = "SELECT userID FROM users where username = '$username'";
$userId = pg_query($userQuery);
$userId = pg_fetch_result($userId, 0, 0);
echo $userId;

$query = "INSERT INTO profile (userID, password, birthday, contactEmail, activity, university, major) 
VALUES ($userId, '$password','$birthday','$email','$activity', '$university', '$major')";
echo $query;
$result = pg_query($query);

$cookie_name = "login";
$cookie_value = 'true';
setcookie($cookie_name, $cookie_value, time() + (10), "/");

header("location: home.php"."?name=".$username);
exit;
?>
