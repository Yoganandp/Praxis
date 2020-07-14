<?php
require_once "pdo.php";

    if (isset($_POST['title'])){
        $title = $_POST['title'];
    
        $sql = "SELECT * FROM Traditions WHERE title = '$title'";
        
        $stmt = $pdo->query($sql);
        $tradition_ID = $stmt->fetch(PDO::FETCH_ASSOC)['tradition_ID'];
        
        $sql = "DELETE FROM Items WHERE tradition_ID = '$tradition_ID'";
        $stmt = $pdo->query($sql);
        
        $sql = "DELETE FROM Stepst WHERE tradition_ID = '$tradition_ID'";
        $stmt = $pdo->query($sql);
        
        $sql = "DELETE FROM Notest WHERE tradition_ID = '$tradition_ID'";
        $stmt = $pdo->query($sql);
        
        $sql = "DELETE FROM Traditions WHERE tradition_ID = '$tradition_ID'";
        $stmt = $pdo->query($sql);
    }
?>