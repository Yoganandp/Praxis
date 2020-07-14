Create Table Families (
    family_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    image BLOB, 
    PRIMARY KEY (family_ID)
);

Create Table Users (
    user_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255),
    family_ID INTEGER UNSIGNED NOT NULL, 
    PRIMARY KEY (user_ID), 
    
    CONSTRAINT FOREIGN KEY (family_ID) REFERENCES Families (family_ID)
        ON DELETE CASCADE ON UPDATE CASCADE 
);

Create Table Recipes (
    recipe_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    family_ID INTEGER UNSIGNED NOT NULL,
    title VARCHAR(255),
    author VARCHAR(255),
    image BLOB, 
    rating int,
    serves VARCHAR(255),
    time VARCHAR(255),
    PRIMARY KEY (recipe_ID),
    
    CONSTRAINT FOREIGN KEY (family_ID) REFERENCES Families (family_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Traditions (
    tradition_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    family_ID INTEGER UNSIGNED NOT NULL,
    title VARCHAR(255),
    author VARCHAR(255),
    image BLOB, 
    importance int,
    date VARCHAR(255),
    duration VARCHAR(255),
    description VARCHAR(255),
    additional VARCHAR(255),
    PRIMARY KEY (tradition_ID),
    
    CONSTRAINT FOREIGN KEY (family_ID) REFERENCES Families (family_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Galleries (
    gallery_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    family_ID INTEGER UNSIGNED NOT NULL,
    image BLOB,
    PRIMARY KEY (gallery_ID),
    
    CONSTRAINT FOREIGN KEY (family_ID) REFERENCES Families (family_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Ingredients (
    ingredient_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    recipe_ID INTEGER UNSIGNED NOT NULL, 
    ingredient text,
    PRIMARY KEY (ingredient_ID),
    
    CONSTRAINT FOREIGN KEY (recipe_ID) REFERENCES Recipes (recipe_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Stepsr (
    step_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    recipe_ID INTEGER UNSIGNED NOT NULL, 
    step text,
    PRIMARY KEY (step_ID),
    
    CONSTRAINT FOREIGN KEY (recipe_ID) REFERENCES Recipes (recipe_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Stepst (
    step_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    tradition_ID INTEGER UNSIGNED NOT NULL, 
    step text,
    PRIMARY KEY (step_ID),
    
    CONSTRAINT FOREIGN KEY (tradition_ID) REFERENCES Traditions (tradition_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Notesr (
    note_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    recipe_ID INTEGER UNSIGNED NOT NULL, 
    note text,
    PRIMARY KEY (note_ID),
    
    CONSTRAINT FOREIGN KEY (recipe_ID) REFERENCES Recipes (recipe_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Notest (
    note_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    tradition_ID INTEGER UNSIGNED NOT NULL,
    note text,
    PRIMARY KEY (note_ID),
    
    CONSTRAINT FOREIGN KEY (tradition_ID) REFERENCES Traditions (tradition_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Items (
    item_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    tradition_ID INTEGER UNSIGNED NOT NULL,
    item text,
    PRIMARY KEY (item_ID),
    
    CONSTRAINT FOREIGN KEY (tradition_ID) REFERENCES Traditions (tradition_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);



