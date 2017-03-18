<html>
<body>
<?php
   //require ("config.php");
   //$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");
   $connection = pg_connect ("host= localhost dbname= postgres user= postgres password= annshine");

    if($connection) {
      echo 'connected';
   } else {
       echo 'there has been an error connecting';
   }

    $query = "SELECT id FROM department WHERE label = '$_POST[Department]'";
    $id = pg_query($query);

    $id = pg_fetch_result($id, 0, 0);

   $query = "INSERT INTO teacher (firstName, lastName, email, department_id) VALUES ('$_POST[FirstName]','$_POST[LastName]','$_POST[Email]', $id)";
   $result = pg_query($query);


    if (!$result) {
      header('location: error.html');
      exit;
    }

    header('location: postResults.php');
    exit;
?>
