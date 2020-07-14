<?php
require_once "pdo.php";

    if (isset($_POST['name'])){
        $name = $_POST['name'];
       
        $sql = "Update Users SET family_ID = '16' WHERE name = '$name'";
        $stmt = $pdo->query($sql);
        
    }

?>