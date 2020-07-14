<?php
require_once "pdo.php";

    if (isset($_POST['family_ID']) && isset($_POST['title']) && isset($_POST['author'])
        && isset($_POST['importance']) && isset($_POST['date']) && isset($_POST['duration'])
        && isset($_POST['description']) && isset($_POST['items']) && isset($_POST['steps']) 
        && isset($_POST['notes']) && isset($_POST['additional'])){
        
        $family_ID = $_POST['family_ID'];
        $title = $_POST['title'];
        $author = $_POST['author'];
        $importance = $_POST['importance'];
        $date = $_POST['date'];
        $duration = $_POST['duration'];
        $description = $_POST['description'];
        $items = $_POST['instructions'];
        $steps = $_POST['steps'];
        $notes = $_POST['notes'];
        $additional = $_POST['additional'];
    
        $sql = "INSERT INTO Traditions (tradition_ID, family_ID, title, author, image, 
        importance, date, duration, description, additional) VALUES (NULL, '$family_ID',
        '$title', '$author', NULL, '$importance', '$date', '$duration', '$description', 
        '$additional')";
        
        $stmt = $pdo->query($sql);
        
        $sql = "SELECT * FROM Traditions where title = '$title'";
        $stmt = $pdo->query($sql);
        $tradition_ID = $stmt->fetch(PDO::FETCH_ASSOC)['tradition_ID'];
    
        foreach ($items as $item){
            $sql = "INSERT INTO Items (item_ID, tradition_ID, item) VALUES 
            (NULL, '$tradition_ID', '$item')";
            $stmt = $pdo->query($sql);
        }  
        
        foreach ($steps as $step){
            $sql = "INSERT INTO Stepst (step_ID, tradition_ID, step) VALUES 
            (NULL, '$tradition_ID', '$step')";
            $stmt = $pdo->query($sql);
        }  
        
        foreach ($notes as $note){
            $sql = "INSERT INTO Notest (note_ID, tradition_ID, note) VALUES 
            (NULL, '$tradition_ID', '$note')";
            $stmt = $pdo->query($sql);
        }        
    
    }
?>