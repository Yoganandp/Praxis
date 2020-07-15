<?php
    require_once "pdo.php";
    
    if(isset($_POST["user_Name"])){
        $user_Name = $_POST["user_Name"];
        $sql = "SELECT family_ID FROM Users WHERE name = '$user_Name'";
        $stmt = $pdo->query($sql);
        $family_ID = $stmt->fetch(PDO::FETCH_ASSOC)['family_ID'];
        
        $sql = "SELECT image FROM Families WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
        $url = $stmt->fetch(PDO::FETCH_ASSOC)['image'];
          
        $input = rawurlencode($url);
        $url = "http://localhost:8888/Family_App/imageOperations/Families/gallery/" . $family_ID . "/" . $input;
        //error_reporting( ~E_NOTICE ); // avoid notice
        
        $a = file_get_contents($url);
        echo $a;
        
        /*echo json_encode([
        "Message" => "The file ". $target_dir. " has been uploaded.",
        "Status" => $url,
        "family_ID" => $family_ID
    ]);
    */
        
    }
    
?>