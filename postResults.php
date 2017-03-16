<?php
    $connection = pg_connect ("host= localhost dbname= postgres user= postgres password= annshine");
?>
</body>
</html>

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
               <th>Email</th>
               <th>Department ID </th>
           </tr>
           <?php
   $teachers = pg_query("select * from teacher");
               while ($row = pg_fetch_array($teachers)) {
                   echo "<tr>\n";
                   echo "<td>", $row[0], "</td>",
                        "<td>", $row[1], "</td>",
                        "<td>", $row[2],"</td>",
                        "<td>", $row[3], "</td>",
                        "<td>", $row[4], "</td>",
                   "</tr>";
               }
               pg_close($connection);
           ?>
       </table>
   </div>
</body>
</html>