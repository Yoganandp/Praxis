<?php
    require_once "pdo.php";
    //error_reporting( ~E_NOTICE ); // avoid notice
    $family_ID = $_POST["family_ID"];
    $sql = "SELECT image FROM Families WHERE family_ID = '$family_ID'";
    $stmt = $pdo->query($sql);
    $url = $stmt->fetch(PDO::FETCH_ASSOC)['image'];
          
    $input = rawurlencode($url);
    $url = "gallery/" .$family_ID . "/" . $input;
    //error_reporting( ~E_NOTICE ); // avoid notice
    unlink($url);
    
?>