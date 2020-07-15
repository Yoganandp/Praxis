<?php
    require_once "pdo.php";
    
    if(isset($_POST['family_ID'])){
    $family_ID = $_POST['family_ID'];
    //$family_ID = '2';
    
    $sql = "SELECT image FROM Recipes where family_ID = '$family_ID'";
    $stmt = $pdo->query($sql);
    $row = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode($row);

    }
    
?>