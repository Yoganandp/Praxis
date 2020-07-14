<?php
//Lets call this script as 'getImage.php'.
//This script should be publicly accessible
//Example format: http://www.yourdomain.com/getImage.php?imageId=2

require_once "pdo.php";

    $sql = "SELECT image FROM Families WHERE family_ID=" . $pdo->quote($_GET['imageId']);
    $stmt = $pdo->query($sql);
    $r = $stmt->fetch(PDO::FETCH_ASSOC);

    //display the image
    $im = imagecreatefromstring($r['image']); 
    echo "lit";
    if ($im !== false) {
        // I assume you use only jpg
        //You may have to modify this block if you use some othe image format
        //visit: http://php.net/manual/en/function.imagejpeg.php
        header('Content-Type: image/jpeg'); 
        imagejpeg($im);
        //echo $im;
        echo "lit";
        imagedestroy($im);
    } else {
        echo 'error.';
    } 

?>