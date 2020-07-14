<?php
    require_once "pdo.php";
    //error_reporting( ~E_NOTICE ); // avoid notice
    $family_ID = $_POST["family_ID"];
    $recipe_Name = $_POST["recipe_Name"];
    $rand_num = mt_rand();
    
    $sql = "SELECT image FROM Recipes WHERE family_ID = '$family_ID' AND title = '$recipe_Name'";
    $stmt = $pdo->query($sql);
    $output = $stmt->fetch(PDO::FETCH_ASSOC)['image'];
    
    $url = "gallery/" .$family_ID . "/" . $output;
    unlink($url);
    
    $target_dir =  "gallery/" . $family_ID;if(!file_exists($target_dir))
    {
    mkdir($target_dir, 0777, true);
    }

    $target_dir = $target_dir . "/" . $rand_num . basename($_FILES["file"]["name"]);
    $image_loc = $rand_num . basename($_FILES["file"]["name"]);
    $sql = "UPDATE Recipes SET image = '$image_loc' WHERE title = '$recipe_Name' AND family_ID = '$family_ID'";
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
