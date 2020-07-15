<?php
require_once "pdo.php";

    if ( isset($_POST['name'])){
        $name = $_POST['name'];
    
        $sql = "DELETE FROM Users WHERE name = '$name'";
        
        echo "$sql";
        $stmt = $pdo->query($sql);
        
    
    }
?>

<p>Add A New User</p>
<form method="post">
<p>Name:
<input type="text" name="name"></p>
<p><input type="submit" value="Add New"/>
<a href="index.php">Cancel</a></p>
</form>

