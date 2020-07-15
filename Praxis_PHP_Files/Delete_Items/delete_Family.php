<?php
require_once "pdo.php";

    if (isset($_POST['name'])){
        $name = $_POST['name'];
    
        $sql = "SELECT * FROM Families WHERE name = '$name'";
        
        $stmt = $pdo->query($sql);
        $family_ID = $stmt->fetch(PDO::FETCH_ASSOC)['family_ID'];
        
        //Recipes:
        $sql = "SELECT * FROM Recipes WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
        $recipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($recipes as $recipe ){
            $recipe_ID = $recipe['recipe_ID'];
            $sql = "DELETE FROM Ingredients WHERE recipe_ID = '$recipe_ID'";
            $stmt = $pdo->query($sql);
            $sql = "DELETE FROM Stepsr WHERE recipe_ID = '$recipe_ID'";
            $stmt = $pdo->query($sql);
            $sql = "DELETE FROM Notesr WHERE recipe_ID = '$recipe_ID'";
            $stmt = $pdo->query($sql);
        }
        $sql = "DELETE FROM Recipes WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
        
        //Traditions:
        $sql = "SELECT * FROM Traditions WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
        $traditions = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($traditions as $tradition){
            $tradition_ID = $tradition['tradition_ID'];
            $sql = "DELETE FROM Items WHERE tradition_ID = '$tradition_ID'";
            $stmt = $pdo->query($sql);
            $sql = "DELETE FROM Stepst WHERE tradition_ID = '$tradition_ID'";
            $stmt = $pdo->query($sql);
            $sql = "DELETE FROM Notest WHERE tradition_ID = '$tradition_ID'";
            $stmt = $pdo->query($sql);
        }
        $sql = "DELETE FROM Traditions WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
        
        
        //Gallery:
        $sql = "DELETE FROM Galleries WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);
        
        //Update Users Foreign Keys:
        $sql = "UPDATE Users SET family_ID = '17' WHERE family_ID = '$family_ID'";
        $stmt = $pdo->query($sql);  
        
        //Family:
        $sql = "DELETE FROM Families WHERE family_ID = '$family_ID'";
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