<?php
require_once "pdo.php";

    if (isset($_POST['family_ID']) && isset($_POST['old_title']) && isset($_POST['new_title']) 
        && isset($_POST['author']) && isset($_POST['rating']) && isset($_POST['serves']) 
        && isset($_POST['time']) && isset($_POST['ingredients']) && isset($_POST['steps'])
        && isset($_POST['notes'])){
        
        $family_ID = $_POST['family_ID'];
        $old_title = $_POST['old_title'];
        $new_title = $_POST['new_title'];
        $author = $_POST['author'];
        $rating = $_POST['rating'];
        $serves = $_POST['serves'];
        $time = $_POST['time'];
        $ingredients = $_POST['ingredients'];
        $steps = $_POST['steps'];
        $notes = $_POST['notes'];
    
        $sql = "UPDATE Recipes SET title = '$new_title', author = '$author', rating = '$rating',
        serves = '$serves', time = '$time' WHERE title = '$old_title'"; 
        
        $stmt = $pdo->query($sql);
        
        $sql = "SELECT * FROM Recipes where title = '$new_title'";
        $stmt = $pdo->query($sql);
        $recipe_ID = $stmt->fetch(PDO::FETCH_ASSOC)['recipe_ID'];
        
        $sql = "DELETE FROM Ingredients WHERE recipe_ID = '$recipe_ID'";
        $stmt = $pdo->query($sql);
        $sql = "DELETE FROM Stepsr WHERE recipe_ID = '$recipe_ID'";
        $stmt = $pdo->query($sql);
        $sql = "DELETE FROM Notesr WHERE recipe_ID = '$recipe_ID'";
        $stmt = $pdo->query($sql);
    
        foreach ($ingredients as $ingredient){
            $sql = "INSERT INTO Ingredients (ingredient_ID, recipe_ID, ingredient) VALUES 
            (NULL, '$recipe_ID', '$ingredient')";
            $stmt = $pdo->query($sql);
        }  
        
        foreach ($steps as $step){
            $sql = "INSERT INTO Stepsr (step_ID, recipe_ID, step) VALUES 
            (NULL, '$recipe_ID', '$step')";
            $stmt = $pdo->query($sql);
        }  
        
        foreach ($notes as $note){
            $sql = "INSERT INTO Notesr (note_ID, recipe_ID, note) VALUES 
            (NULL, '$recipe_ID', '$note')";
            $stmt = $pdo->query($sql);
        }        
    
    }
?>