<?php
require_once "pdo.php";

    if (isset($_POST['title'])){
        $title = $_POST['title'];
    
        $sql = "SELECT * FROM Recipes WHERE title = '$title'";
        
        $stmt = $pdo->query($sql);
        $recipe_ID = $stmt->fetch(PDO::FETCH_ASSOC)['recipe_ID'];
        
        $sql = "DELETE FROM Ingredients WHERE recipe_ID = '$recipe_ID'";
        $stmt = $pdo->query($sql);
        
        $sql = "DELETE FROM Stepsr WHERE recipe_ID = '$recipe_ID'";
        $stmt = $pdo->query($sql);
        
        $sql = "DELETE FROM Notesr WHERE recipe_ID = '$recipe_ID'";
        $stmt = $pdo->query($sql);
        
        $sql = "DELETE FROM Recipes WHERE recipe_ID = '$recipe_ID'";
        $stmt = $pdo->query($sql);
    }
?>