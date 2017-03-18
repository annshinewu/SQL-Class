<?php
// --- secure connection to the database
require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");

if($connection) {
    echo 'connected';
} else {
    echo 'there has been an error connecting';
}

$query1 = "SELECT username FROM users WHERE username = '$POST[usernamesignup]'";
$query2 = "SELECT email FROM users WHERE email = '$POST[emailsignup]'";

$result = true;

$usernameExist = pg_fetch_row(pg_query($query1));
$emailExist = pg_fetch_row(pg_query($query2));
if(($usernameExist[0]) || ($emailExist[0])){
    $result = false;
}
else{
    $query = "INSERT INTO users (username, email, password) VALUES ('$_POST[usernamesignup]','$_POST[emailsignup]',crypt('$_POST[passwordsignup]',gen_salt('md5')))";
    $result = pg_query($query);
}

if (!$result) {
    header("location: error.html");
    exit;
}
else{
    header('location: welcome.html');
}

?>
