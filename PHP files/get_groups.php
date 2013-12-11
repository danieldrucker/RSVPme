<?php

require("common.php");

   $token = GetSQLValueString($_GET['token'], "text");

   if(!empty($_GET) ||  $token != "NULL") 
   {
      // This query retreives the user's information from the database using 
      // their email. 
      $query=     "SELECT user_id
                  FROM tokens
                  WHERE tokens.token = :token"
         ; 
       
      // The parameter values 
      $query_params = array( 
         ':token' => $token 
         ); 
        
      try 
      { 
         // Execute the query against the database 
         $stmt = $db->prepare($query); 
         $result = $stmt->execute($query_params);
      } 
      catch(PDOException $ex) 
      {
         die("Failed to run query: " . $ex->getMessage());
      }
      $user_id = $stmt->fetchColumn(); 
      //echo $user_id;

   }
   
   $query=  "SELECT user_groups.user_id, groups.group_id, groups.created_by, groups.group_name, groups.date_created, groups.public_or_private
            FROM groups
            LEFT OUTER JOIN user_groups
            ON user_groups.user_id = :user_id
            WHERE user_groups.group_id = groups.group_id"

      ; 
    
   // The parameter values 
   $query_params = array( 
      ':user_id' => $user_id
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
       
   

?>