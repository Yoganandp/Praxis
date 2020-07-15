<?php
    require_once "pdo.php";
    //error_reporting( ~E_NOTICE ); // avoid notice
    $family_ID = $_POST["family_ID"];
    $sql = "SELECT image from Families WHERE family_ID = '$family_ID'";
    $stmt = $pdo->query($sql);
    $url = $stmt->fetch(PDO::FETCH_ASSOC)['image'];
          
    $input = $url;
    $url = "gallery/" .$family_ID . "/" . $input;
        //error_reporting( ~E_NOTICE ); // avoid notice
    unlink($url);
    
    $target_dir =  "gallery/" . $family_ID;if(!file_exists($target_dir))
    {
    mkdir($target_dir, 0777, true);
    }

    $target_dir = $target_dir . "/" . basename($_FILES["file"]["name"]);
    $image_loc = basename($_FILES["file"]["name"]);
    $sql = "UPDATE Families SET image = '$image_loc' where family_ID = '$family_ID'";
    $stmt = $pdo->query($sql);

    if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_dir)) 
    {
    echo json_encode([
    "Message" => "The file ". $target_dir. " has been uploaded.",
    "Status" => "OK",
    "family_ID" => $_REQUEST["family_ID"]
    ]);
    
    } else {

    echo json_encode([
    "Message" => "Sorry, there was an error uploading your file.",
    "Status" => "Error",
    "userId" => $_REQUEST["family_ID"]
    ]);

}
?>
