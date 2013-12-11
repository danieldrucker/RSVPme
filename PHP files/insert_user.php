<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
   <head>
      <title>Insert User</title>
         </head>
            <body>
            <?php
            
            $host = "localhost"; 
            $user = "root"; 
            $pass = ""; 
            $db = "mydb"; 
            
            $mysqli = new mysqli($host, $user, $pass, $db, 3306);
            
            if ($mysqli->connect_errno)
            {
               echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
            }
            
            
            function execute_query($q) {
               
               global $mysqli;         
               $r = $mysqli->query($q);
               if (!$r) {
                  die("Database query failed.");
               } else {
                  echo "Query: $q executed\n"; 
               }
            }
            
            
            $query = "INSERT INTO users (
                     pass,
                     first_name,
                     last_name,
                     nickname,
                     email,
                     date_joined
                     ) VALUES (
                     'password',
                     'Daniel',
                     'Drucker',
                     'Druckcity',
                     'druckcity@yahoo.com',
                     '2004-01-04'
                     ) "; 
            
            execute_query($query);
            
            mysqli_close($mysqli);
            
            ?>

            </body>
</html>
