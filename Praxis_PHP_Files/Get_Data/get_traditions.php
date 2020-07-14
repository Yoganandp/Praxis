<?php
require_once "pdo.php";

    if (isset($_POST['name'])) {
        //Return array
        $data = array();
    
        //Identify User:
        $name = //"Shiwani";
        $_POST['name'] ;
        $sql = "SELECT * FROM Users WHERE name = '$name'";
        $stmt = $pdo->query($sql);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        //Identify Family:
        $family_ID = $user['family_ID'];
        $sql = "SELECT * FROM Families WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
        $family = $stmt->fetch(PDO::FETCH_ASSOC);
        
        //Find all Traditions:
        $traditions_data = array();
        $sql = "SELECT * FROM Traditions WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
        $traditions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $counter = 0;
        
        foreach ($traditions as $tradition ) {
            $tradition_holder = array();
            $tradition_holder['info'] = $tradition;
            $tradition_ID = $tradition['tradition_ID'];
            
            //Items:
            $sql = "SELECT * FROM Items WHERE tradition_ID = '$tradition_ID'";
            $stmt = $pdo->query($sql);
            $items = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $tradition_holder['items'] = $items;
            
            //Steps:
            $sql = "SELECT * FROM Stepst WHERE tradition_ID = '$tradition_ID'";
            $stmt = $pdo->query($sql);
            $steps = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $tradition_holder['steps'] = $steps;
            
            //Notes:
            $sql = "SELECT * FROM Notest WHERE tradition_ID = '$tradition_ID'";
            $stmt = $pdo->query($sql);
            $notes = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $tradition_holder['notes'] = $notes;
            
            //Add to recipes array
            $traditions_data[$counter] = $tradition_holder;
            $counter = $counter + 1;
        }

        $data['Traditions'] = $traditions_data;
        
        //Test
        $test = array();
        $test['first'] = "Lit";
        $test['second'] = "Litt";
        
        //Return Final JSON Object
        echo json_encode($data);
        //echo json_encode($test);
    }
?>