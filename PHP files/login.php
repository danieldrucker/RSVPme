<?php 

   // First we execute our common code to connect to the database and start the session 
   require("common.php"); 
   
   $email_input = GetSQLValueString($_POST['email'], "text");
   $password_input = GetSQLValueString($_POST['password'], "text");
    
   // This if statement checks to determine whether the login form has been submitted 
   // If it has, then the login code is run, otherwise the form is displayed 
   if(!empty($_POST) || $email_input == "NULL" || $password_input == "NULL") 
   { 
      // This query retreives the user's information from the database using 
      // their email. 
      $query = " 
         SELECT 
            user_id,  
            pass, 
            email, 
            salt 
         FROM users 
         WHERE 
            email = :email 
         "; 
       
      // The parameter values 
      $query_params = array( 
         ':email' => $email_input 
         ); 
        
      try 
      { 
         // Execute the query against the database 
         $stmt = $db->prepare($query); 
         $result = $stmt->execute($query_params); 
      } 
      catch(PDOException $ex) 
      { 
         // Note: On a production website, you should not output $ex->getMessage(). 
         // It may provide an attacker with helpful information about your code.
         echo "Invalid Email";
         die("Failed to run query: " . $ex->getMessage());
      } 
       
      // This variable tells us whether the user has successfully logged in or not. 
      // We initialize it to false, assuming they have not. 
      // If we determine that they have entered the right details, then we switch it to true. 
      $login_ok = false; 
       
      // Retrieve the user data from the database.  If $row is false, then the username 
      // they entered is not registered. 
      $row = $stmt->fetch(); 
      if($row) 
      { 
         // Using the password submitted by the user and the salt stored in the database, 
         // we now check to see whether the passwords match by hashing the submitted password 
         // and comparing it to the hashed version already stored in the database. 
         $check_password = hash('sha256', $password_input . $row['salt']); 
         for($round = 0; $round < 65536; $round++) 
         { 
            $check_password = hash('sha256', $check_password . $row['salt']); 
         } 
          
         if($check_password === $row['pass']) 
         { 
            // If they do, then we flip this to true 
            $login_ok = true;
            //echo "LOGIN WORKED!!!";
            //echo $check_password, $row['pass'];
         } 
      } 
      
      // If the user logged in successfully, then we send them to the private members-only page 
      // Otherwise, we display a login failed message and show the login form again 
      if($login_ok) 
      { 
         $token = uniqid();
         $query = " 
            INSERT INTO tokens ( 
               user_id,
               token,
               last_used
            )  VALUES ( 
               :user_id,
               :token,
               :last_used
            ) "; 
         
         $date = new DateTime();
         $date = $date->format('Y-m-d');
         
         // The parameter values 
         $query_params = array( 
            ':user_id' => $row['user_id'],
            ':token' => $token,
            ':last_used' => $date
            ); 
        
         try 
         { 
            // Execute the query against the database 
            $stmt = $db->prepare($query); 
            $result = $stmt->execute($query_params); 
         } 
         catch(PDOException $ex) 
         { 
            // Note: On a production website, you should not output $ex->getMessage(). 
            // It may provide an attacker with helpful information about your code.  
            die("Failed to run query: " . $ex->getMessage()); 
         }
         echo $token;
      } 
      else 
      { 
         // Tell the user they failed 
         echo "Failed to Login."; 
         
      } 
   } 
    
?>