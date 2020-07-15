# Praxis

iOS Application to allow families to share recipes, traditions, and pictures

App:
- Allows for users to create a family and share their recipes, traditions, and pictures with each other
- Application supports all CRUD operations for recipes, family, traditions, and gallery through the user interface
- User interface written impelementing SwiftUI
- Utilizes POST requests to upload pictures and data to PHP web API for storage in MySQL database

PHP: 
- PHP script accepts forms, files, and text input through POST and uploads input data to the appropriate MySQL table through SQL queries
- Responsible for all database CRUD operations
- Images are stored in a directory rather than the MySQL db, PHP scripts manage CRUD operations for images

MySQL: 
- Database to store all the information for Users, Families, Recipes, and Traditions
- All tables containing elements that have image attributes contain url indentifiers to their images stored in the web directory

Potential Updates:
- More robust user accounts with additional security
- Hosting on a webhost such as Azure or AWS
- More advanced gallery - especially the image views
- Potential android application

