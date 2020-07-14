<?php
    require_once "pdo.php";
    //error_reporting( ~E_NOTICE ); // avoid notice
    $family_ID = $_POST["family_ID"];
    $tradition_Name = $_POST["tradition_Name"];
    $rand_num = mt_rand();
    
    $sql = "SELECT image FROM Traditions WHERE family_ID = '$family_ID' AND title = '$tradition_Name'";
    $stmt = $pdo->query($sql);
    $output = $stmt->fetch(PDO::FETCH_ASSOC)['image'];
    
    $url = "gallery/" .$family_ID . "/" . $output;
    unlink($url);
    
?>