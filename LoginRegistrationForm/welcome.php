<?php
$cookie_name = "login";
$cookie_name2 = "check";
echo $_COOKIE[$cookie_name2];
#if(!isset($_COOKIE[$cookie_name2])){
    if(isset($_COOKIE[$cookie_name]))  {
        $name = $_GET["name"];
        $email = $_GET["email"];
        #echo "success";
    }
    #else {
        #header('location: index.html#tologin');
        #echo 'first';
        #exit;
    #}
#}
else {
    header('location: index.html#tologin');
    #echo 'second';
    exit;
}

$cookie_name = "username";
$cookie_value = $_GET['name'];
setcookie($cookie_name, $cookie_value, time() + (30), "/");


$cookie_name = "email";
$cookie_value = $_GET['email'];
setcookie($cookie_name, $cookie_value, time() + (30), "/");

?>

<?php
$connection = pg_connect ("host= localhost dbname= postgres user= postgres password= annshine");
?>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="tablestylesheet.css"/>
</head>
<body>
<div id="container">
    <table>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Address</th>
            <th>Department</th>
            <th>Username</th>
            <th>First Email</th>
            <th>Second Email</th>
            <th>Last Updated</th>
        </tr>
        <?php
        $name = $_GET["name"];
        $email = $_GET["email"];
        //$profile = pg_query("SELECT firstName, lastName, address, dep_id, username, users.email, profile.email from users INNER JOIN profile USING (id) WHERE username ='".$_COOKIE["username"]."';");
        #$profile = pg_query("SELECT firstname, lastname, address, dep_id, username, email, secondEmail, lastUpdate from profile WHERE username = '$name' AND email = '$email' ORDER BY lastUpdate DESC LIMIT 1;");
        #SELECT firstname, lastname, address, label, username, email, secondEmail, lastUpdate from profile INNER JOIN department USING (dep_id) WHERE username = 'annshinewu' AND email = 'annshinewu@pacificamerican.org' ORDER BY lastUpdate DESC LIMIT 1;
        $profile = pg_query("SELECT firstname, lastname, address, label, username, email, secondEmail, lastUpdate from profile INNER JOIN department USING (dep_id) WHERE username = '$name' AND email = '$email' ORDER BY lastUpdate DESC LIMIT 1;");
        $value = pg_fetch_result($profile, 0, 0);
        if(!$value){
            echo "<tr>\n";
            echo "<td>", "", "</td>",
            "<td>", "", "</td>",
            "<td>", "", "</td>",
            "<td>", "", "</td>",
            "<td>", $name, "</td>",
            "<td>", $email, "</td>",
            "<td>", "", "</td>",
            "<td>", "", "</td>",
            "</tr>";
        }
        else {
            while ($row = pg_fetch_array($profile)) {
                echo "<tr>\n";
                echo "<td>", $row[0], "</td>",
                "<td>", $row[1], "</td>",
                "<td>", $row[2], "</td>",
                "<td>", $row[3], "</td>",
                "<td>", $row[4], "</td>",
                "<td>", $row[5], "</td>",
                "<td>", $row[6], "</td>",
                "<td>", $row[7], "</td>",
                "</tr>";
            }
        }
        pg_close($connection);
        ?>
    </table>
    <form class = "form-style-5" action="edit.php" method = post>
    <p class="edit button">
        <input type="submit" value="Edit Profile"/>
    </p>
    </form>
    <form class = "form-style-5" action="logout.php" method = post>
    <p class="edit button">
            <input type="submit" value="Back"/>
    </p>
    </form>
</div>
</body>
</html>
