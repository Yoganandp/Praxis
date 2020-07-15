<?php
require_once "pdo.php";
    if (isset($_POST['name'])) {
        
        $name = $_POST['name'];
        
        $sql = "SELECT * FROM Users where name = '$name'";
        $stmt = $pdo->query($sql);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
            
        if ( $row === FALSE ) {
            $sql = "INSERT INTO Users (user_ID, name, family_ID) VALUES (NULL, '$name', '17')";
            $stmt = $pdo->query($sql);
        }
     }
    
?>

