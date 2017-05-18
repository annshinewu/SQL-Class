<?php
require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");

if($connection) {
    echo 'connected';
} else {
    echo 'there has been an error connecting';
}

$name = $_POST['username'];
$pass = $_POST['password'];

//$query = "SELECT username FROM users WHERE username = '$name' AND password = crypt('$pass', password);";
$query = "SELECT username FROM users WHERE username = '$name' AND password = '$pass';";

$result = pg_fetch_row(pg_query($query));

if(!$result){
    header('location:index.html');
    exit;
}
else{
    $cookie_name = "login";
    $cookie_value = "true";
    setcookie($cookie_name, $cookie_value, time() + (5), "/");
    header("location: home.php"."?name=".$name);
    $cookie_name = "username";
    $cookie_value = $name;
    setcookie($cookie_name, $cookie_value, time() + (5), "/");
    exit;
}