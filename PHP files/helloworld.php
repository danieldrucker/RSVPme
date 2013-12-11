<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
   <head>
      <title>Hello World</title>
         </head>
            <body>
            <?php echo "Hello World!"; ?><br />
            <?php echo "Hello" .  " Seattle!"; ?>
            <?php echo 2 + 3; ?> <br /> <br />
            <?php
            
            $phrase_one = "I am";
            $phrase_two = " the dude.";
            
            $phrase_three = $phrase_one;
            $phrase_three .= $phrase_two;
            echo $phrase_three;
            
            ?>
            <br />
            <?php
            echo strtolower($phrase_three) . "<br />"; 
            echo strtoupper($phrase_three) . "<br /n>"; 
            echo ucwords($phrase_three) . "<br /n>";
            echo "<br /n>";
            echo strlen($phrase_three);
            echo "<br /n>";
            echo "x" . trim(ucwords($phrase_three));
            
            ?>
            <br /> <br /> <br /> <br />
            <?php
            //echo date('Y-m-d');
            //echo "&lt;p&gt;".uniqid()."&lt;/p&gt;"; 
            //echo uniqid();
            $date1 = new DateTime();
            $date1->add(new DateInterval('P5M'));
            $date2 = new DateTime();
            echo $date1->format('Y-m-d') . "\n";
            echo "<br /n>";
            echo $date2->format('Y-m-d') . "\n";;
            $interval = date_diff($date1, $date2);
            echo "<br /n>";
            echo $interval->format('%a') . "\n";;
            //echo date('Y-m-d');
            //echo $lastmonth;
            
            ?>
            <br /> <br /> <br /> <br />
            <?php
            require("common.php");
            $value = uniqid();
            echo gettype($value). "<br /n>";
            echo $value. "<br /n>";
            echo GetSQLValueString($value, "text");
            
            ?>
            </body>
</html>
