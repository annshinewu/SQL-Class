<?php

$cookie_name = "login";
if(isset($_COOKIE[$cookie_name]))  {
    $name = $_GET["name"];
}
else {
    header('location: index.html');
    exit;
}

$cookie_name = "username";
$cookie_value = $name;
setcookie($cookie_name, $cookie_value, time() + (30), "/");

?>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="subpages.css">
    <title>PASNote</title>
</head>
<body style="background-color:powderblue;">

<div class="header">
    <a href="./home.php"> Note Feed</a>
        <a href="./course.php">Courses Q&A</a>
    <div class="imgWithText">
        <img id="profilePic" src="sam.jpg">
        <p>Hi, Typhooner!</p>
    </div>

    <a href="./college.html">College Note</a>
    <a href="./edit.php">Update Profile</a>

</div>
<section class="container">
    <div>

        <input checked id="one" name="multiples" type="radio" value="1">
        <label for="one">1</label>

        <input id="two" name="multiples" type="radio" value="2">
        <label for="two">2</label>

        <input id="three" name="multiples" type="radio" value="3">
        <label for="three">3</label>

        <input id="four" name="multiples" type="radio" value="4">
        <label for="four">4</label>

        <input id="five" name="multiples" type="radio" value="5">
        <label for="five">5</label>

        <input id="six" name="multiples" type="radio" value="6">
        <label for="six">6</label>

        <input id="seven" name="multiples" type="radio" value="7">
        <label for="seven">7</label>

        <input id="eight" name="multiples" type="radio" value="8">
        <label for="eight">8</label>

        <div class="container">
            <div class="carousel">
                <img src="1.jpg" alt="Landscape 1">
                <img src="2.jpg" alt="Landscape 2">
                <img src="3.jpg" alt="Landscape 3">
                <img src="4.jpg" alt="Landscape 4">
                <img src="5.jpg" alt="Landscape 5">
                <img src="6.jpg" alt="Landscape 6">
                <img src="7.jpg" alt="Landscape 7">
                <img src="8.jpg" alt="Landscape 8">
            </div>
        </div>
    </div>
</section>
</body>
</html>
