<?php

require("common.php");

   $group_id = GetSQLValueString($_GET['group_id'], "int");

   if(!empty($_GET) ||  $group_id != "NULL") 
   {
      // This query retreives the user's information from the database using 
      // their email. 
         $query = "SELECT event_id, event_name, event_time, event_place, event_detail
         FROM event
         WHERE group_id = :group_id
         "; 
       
      // The parameter values 
      $query_params = array( 
          ':group_id' => $group_id 
         ); 
        
      try 
      { 
         // Execute the query against the database 
         $stmt = $db->prepare($query); 
         $stmt->execute($query_params); 
      } 
      catch(PDOException $ex) 
      {
         die("Failed to run query: " . $ex->getMessage());
      }
      
      
      $posts = array();
      while($row = $stmt->fetch(PDO::FETCH_ASSOC))
      {
         //var_dump($row);
         $posts[] = $row;
      }
      
      $json = json_encode($posts);
      echo $json;
   }
       
   

?>