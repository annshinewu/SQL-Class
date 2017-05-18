<?php
require ("config.php");
$connection = pg_connect ("host=$DB_HOST dbname=$DB_DATABASE user=$DB_USER password=$DB_PASSWORD");

$cookie_name = "username";
if(isset($_COOKIE[$cookie_name]))  {
    $name =$_COOKIE[$cookie_name];
}


$query = "SELECT userID FROM users WHERE username = '$name';";
$studentID = pg_fetch_result(pg_query($query),0,0);
$query = pg_query("SELECT courseID FROM courseList WHERE studentID = '$studentID'");
while ($row = pg_fetch_array($query)) {
    $courseName = pg_query("SELECT courseName FROM course WHERE courseID = '$row[0]'");
    $course1 = pg_fetch_result($courseName,0,0);
    $courseName  = pg_query("SELECT courseName FROM course WHERE courseID = '$row[1]'");
    $course2 = pg_fetch_result($courseName,0,0);
    $courseName  = pg_query("SELECT courseName FROM course WHERE courseID = '$row[2]'");
    $course3 = pg_fetch_result($courseName,0,0);
    $courseName  = pg_query("SELECT courseName FROM course WHERE courseID = '$row[3]'");
    $course4 = pg_fetch_result($courseName,0,0);
    $courseName  = pg_query("SELECT courseName FROM course WHERE courseID = '$row[4]'");
    $course5 = pg_fetch_result($courseName,0,0);
    $courseName  = pg_query("SELECT courseName FROM course WHERE courseID = '$row[5]'");
    $course6 = pg_fetch_result($courseName,0,0);
    $courseName  = pg_query("SELECT courseName FROM course WHERE courseID = '$row[6]'");
    $course7 = pg_fetch_result($courseName,0,0);
    $courseName  = pg_query("SELECT courseName FROM course WHERE courseID = '$row[7]'");
    $course8 = pg_fetch_result($courseName,0,0);

    echo "<tr>\n";
    echo "<td>", $course1, "</td>",
    "<td>", $couse2, "</td>",
    "<td>", $course3,"</td>",
    "<td>", $course4, "</td>",
    "<td>", $couse5, "</td>",
    "<td>", $couse6, "</td>",
    "<td>", $couse7, "</td>",
    "<td>", $couse8, "</td>",
    "</tr>";
}
?>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="coursestyl.css">
    <title>PASNote -- Course Q&A</title>
</head>
<body style="background-color:#7bb0ed;">

<div class="header">
    <a href="./home.php"> Note Feed</a>
    <a href="./course.html">Courses Q&A</a>
    <div class="imgWithText">
        <img id="profilePic" src="sam.jpg">
        <p>Hi, Typhooner!</p>
    </div>

    <a href="./college.html">College Note</a>
    <a href="./edit.php">Update Profile</a>
</div>
<section class="container">

</section>

<div class="floating-box">
    <a href="SQL.html">SQL</a>
</div>
<div class="floating-box">
    <a href="Python.html">Python</a>
</div>
<div class="floating-box">
    <a href="Calc.html">Pre-Calculus</a>
</div>
<div class="floating-box">
    <a href="Stats.html">AP Statistics</a>
</div>
<div class="floating-box">
    <a href="physics.html">Physics</a>
</div>
<div class="floating-box">
    <a href="robo.html">Robotics</a>
</div>
<div class="floating-box">
    <a href="chem.html">Chemistry</a>
</div>
<div class="floating-box">
    <a href="amlit.html">American Literature</a>
</div>
</body>
</html>