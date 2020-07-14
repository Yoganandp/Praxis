<?php
require_once "pdo.php";

    if (isset($_POST['old_name']) && isset($_POST['new_name']) && isset($_POST['users'])){
        $old_name = $_POST['old_name'];
        $new_name = $_POST['new_name'];
        $users = $_POST['users'];
    
        $sql = "UPDATE Families SET name = '$new_name' WHERE name = '$old_name'";
        $stmt = $pdo->query($sql);
        
        $sql = "SELECT * FROM Families where name = '$new_name'";
        $stmt = $pdo->query($sql);
        $family_ID = $stmt->fetch(PDO::FETCH_ASSOC)['family_ID'];
        
        $sql = "Update Users SET family_ID = '17' WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
    
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
