<?php
require_once "pdo.php";

    if ( isset($_POST['name']) && isset($_POST['users'])){
        $name = $_POST['name'];
        $users = $_POST['users'];
    
        $sql = "INSERT INTO Families (family_ID, name, image) VALUES (NULL, '$name', NULL)";
        $stmt = $pdo->query($sql);
        
        $sql = "SELECT * FROM Families where name = '$name'";
        $stmt = $pdo->query($sql);
        $family_ID = $stmt->fetch(PDO::FETCH_ASSOC)['family_ID'];
    
        foreach ($users as $user){
            $sql = "SELECT * FROM Users where name = '$user'";
            $stmt = $pdo->query($sql);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ( $row === FALSE ) {
                $sql = "INSERT INTO Users (user_ID, name, family_ID) VALUES (NULL, '$user', '$family_ID')";
                $stmt = $pdo->query($sql);
            }
            else{
                $sql = "UPDATE Users SET family_ID = '$family_ID' WHERE name = '$user'";
                $stmt = $pdo->query($sql);
            }
        }        
    
    }
    
?>
