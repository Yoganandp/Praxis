<?php
require_once "pdo.php";

    if (isset($_POST['old_name']) && isset($_POST['new_name']) && isset($_POST['family_name'])){
        $old_name = $_POST['old_name'];
        $new_name = $_POST['new_name'];
        $family_name = $_POST['family_name'];
        
        $sql = "SELECT * FROM Families where name = '$family_name'";
        $stmt = $pdo->query($sql);
        $family_ID = $stmt->fetch(PDO::FETCH_ASSOC)['family_ID'];
        
        $sql = "UPDATE Users SET family_ID = '$family_ID', name = '$new_name' WHERE name = '$old_name'";
        $stmt = $pdo->query($sql);
    
    }
?>

<p>Add A New Family</p>
<form method="post">
<p>Current Name:
<input type="text" name="old_name"></p>
<p>New Name:
<input name="new_name" type="text"></p>
<p>New Family Name:
<input name="family_name" type="text"></p>
<p><input type="submit" value="Add New"/>
<a href="index.php">Cancel</a></p>
</form>