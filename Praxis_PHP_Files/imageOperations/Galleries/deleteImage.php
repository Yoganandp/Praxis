<?php
    require_once "pdo.php";
    //error_reporting( ~E_NOTICE ); // avoid notice
    if(isset($_POST["url"]) && isset($_POST["family_ID"])){
        
        $image = $_POST["url"];
        $input = rawurlencode($_POST["url"]);
        $family_ID = $_POST["family_ID"];
        $url = "gallery/" .$family_ID . "/" . $image;
        //error_reporting( ~E_NOTICE ); // avoid notice
        unlink($url);
        
        
        
        $sql = "DELETE FROM Galleries WHERE image = '$image'";
        $stmt = $pdo->query($sql);
        
        
        
    }
    
    
?>