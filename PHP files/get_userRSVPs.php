<?php

require("common.php");



   $event_id = GetSQLValueString($_GET['event_id'], "int");

   if(!empty($_GET) ||  $group_id != "NULL") 
   {
      $query = "SELECT users.first_name, users.last_name, event_RSVP.user_RSVP 
         FROM event_RSVP, users
         WHERE users.user_id = event_RSVP.user_id AND event_RSVP.event_id = :event_id
         ORDER BY
           CASE user_RSVP
             WHEN 'yes' THEN 1
             WHEN 'maybe' THEN 2
             WHEN 'no' THEN 3
             ELSE 4
           END";
       
      // The parameter values 
      $query_params = array( 
          ':event_id' => $event_id 
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