<?php
require_once "pdo.php";

    if (isset($_POST['family_ID']) && isset($_POST['title']) && isset($_POST['author'])
        && isset($_POST['rating']) && isset($_POST['serves']) && isset($_POST['time'])
        && isset($_POST['instructions']) && isset($_POST['steps']) && isset($_POST['notes'])){
        
        $family_ID = $_POST['family_ID'];
        $title = $_POST['title'];
        $author = $_POST['author'];
        $rating = $_POST['rating'];
        $serves = $_POST['serves'];
        $time = $_POST['time'];
        $ingredients = $_POST['instructions'];
        $steps = $_POST['steps'];
        $notes = $_POST['notes'];
    
        $sql = "INSERT INTO Recipes (recipe_ID, family_ID, title, author, image, 
        rating, serves, time) VALUES (NULL, '$family_ID', '$title', '$author', NULL, 
        '$rating', '$serves', '$time')";
    
        
        $stmt = $pdo->query($sql);
        
        $sql = "SELECT * FROM Recipes where title = '$title'";
        $stmt = $pdo->query($sql);
        $recipe_ID = $stmt->fetch(PDO::FETCH_ASSOC)['recipe_ID'];
    
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

