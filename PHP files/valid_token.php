<?php

require("common.php");

if (valid_id($_POST['token'], $db))
{
   echo "True";
}
else
{
   return "False";
}

?>