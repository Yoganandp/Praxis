<?php
require_once "pdo.php";
    
    if(isset($_POST["url"]) && isset($_POST["family_ID"])){
    
        $input = rawurlencode($_POST["url"]);
        $family_ID = $_POST["family_ID"];
        
        $url = "http://localhost:8888/Family_App/imageOperations/Recipes/gallery/" .$family_ID . "/" . $input;
        //error_reporting( ~E_NOTICE ); // avoid notice
        $a = file_get_contents($url);
        echo $a;
        
    }
?>