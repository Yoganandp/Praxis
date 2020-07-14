//
//  UpdateRecipe.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 7/4/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI


struct RecipeUpdate: View {
    @State var recipe: Recipe
    @State var old_title: String
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var holdI: String = ""
    @State var holdS: String = ""
    @State var holdN: String = ""
    @State var counter1 = 0
    @State var counter2 = 0
    @State var counter3 = 0
    @State var rating: Int = 4
    
    @State var temporary: Recipe = Recipe(recipe_ID: 0, title: "", author: "", rating: 0, serves: "", time: "", steps: [], ingredients: [], notes: [])
    
    var body: some View {
        VStack{
            ZStack{
                if recipe.image != nil{
                    recipe.image?
                        .resizable()
                }else{
                    Rectangle()
                        .fill(Color.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .frame(height: 300)
            .onTapGesture {
                self.showingImagePicker = true
            }
            VStack{
                TextField("Enter Recipe Name", text: $recipe.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                    .background(Color(red: 255, green: 255, blue: 255, opacity: 1))
                RatingView(rating: $recipe.rating)
            }.offset(y: -20)
            ScrollView{
                HStack{
                    Image(systemName: "book.fill")
                    Text("Author: ").font(.system(.headline, design: .serif))
                    TextField("Enter the author's name", text: $recipe.author)
                }
                .padding(.horizontal, 20)
                HStack{
                    Image(systemName: "clock.fill")
                    Text("Time: ").font(.system(.headline, design: .serif))
                    TextField("Enter estimated time for recipe", text: $recipe.time)
                }
                .padding(.horizontal, 20)
                HStack{
                    Image(systemName: "person.fill")
                    Text("Serves: ").font(.system(.headline, design: .serif))
                    TextField("Enter # that recipe serves", text: $recipe.serves)
                }
                .padding(.horizontal, 20)
                VStack(spacing: 20){
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Ingredients").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach (recipe.ingredients, id: \.self){ingredient in // show received results
                            HStack{
                                Text(String(self.recipe.ingredients.firstIndex(of: ingredient)! + 1) + ": " + ingredient).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.recipe.ingredients.firstIndex(of: ingredient)!
                                    self.recipe.ingredients.remove(at: index)
                                }){
                                    Image(systemName: "minus.circle.fill")
                                }.accentColor(.gray)
                            }
                        }
                    }//.frame(maxWidth: .infinity)  // << important !!
                    HStack{
                        TextField("Ingredient - Quantity", text: $holdI)
                        Spacer()
                        Button(action: {
                            self.addIngredient()
                        }){
                            Image(systemName: "plus.circle.fill")
                        }.accentColor(.gray)
                    }
                }.frame(maxWidth: 325)
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Steps").font(.system(.headline, design: .serif))
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach (recipe.steps, id: \.self){step in // show received results
                            HStack{
                                Text(String(self.recipe.steps.firstIndex(of: step)! + 1) + ": " + step).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.recipe.steps.firstIndex(of: step)!
                                    self.recipe.steps.remove(at: index)
                                    print(index)
                                }){
                                    Image(systemName: "minus.circle.fill")
                                }.accentColor(.gray)
                            }
                        }
                    }//.frame(maxWidth: .infinity)  // << important !!
                    HStack{
                        TextField("Enter the Steps of the Recipe", text: $holdS)
                        Spacer()
                        Button(action: {
                            self.addStep()
                        }){
                            Image(systemName: "plus.circle.fill")
                        }.accentColor(.gray)
                    }
                }.frame(maxWidth: 325)
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Notes").font(.system(.headline, design: .serif))
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach (recipe.notes, id: \.self){note in // show received results
                            HStack{
                                Text(String(self.recipe.notes.firstIndex(of: note)! + 1) + ": " + note).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.recipe.notes.firstIndex(of: note)!
                                    self.recipe.notes.remove(at: index)
                                }){
                                    Image(systemName: "minus.circle.fill")
                                }.accentColor(.gray)
                            }
                        }
                    }//.frame(maxWidth: .infinity)  // << important !!
                    HStack{
                        TextField("Enter Additional Notes", text: $holdN)
                        Spacer()
                        Button(action: {
                            self.addNote()
                        }){
                            Image(systemName: "plus.circle.fill")
                        }.accentColor(.gray)
                    }
                }.frame(maxWidth: 325)
                }.offset(x: -25, y: 10)
            }
            Button("Save", action: {
                self.save()
            }).accentColor(.black)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        recipe.image = Image(uiImage: inputImage)
    }
    
    func addIngredient() -> Void {
        // store result string (must be on main queue)
        self.counter1 += 1
        self.recipe.ingredients.append(self.holdI)
        self.holdI = ""
    }
    
    func addStep(){
        // store result string (must be on main queue)
        self.counter2 += 1
        self.recipe.steps.append(self.holdS)
        self.holdS = ""
    }
    
    func addNote(){
        // store result string (must be on main queue)
        self.counter3 += 1
        self.recipe.notes.append(self.holdN)
        self.holdN = ""
    }
    
    func save(){
        if (Int(UserDefaults.standard.string(forKey: "family")!) != 1){
        var family_ID: String = UserDefaults.standard.string(forKey: "family")!
        var values: NSDictionary = [:]
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Update_Items/update_Recipe.php")! as URL)
        request.httpMethod = "POST"
        var postingString = "family_ID=\(family_ID)&old_title=\(self.old_title)&new_title=\(self.recipe.title)&author=\(self.recipe.author)&rating=\(self.recipe.rating)&serves=\(self.recipe.serves)&time=\(self.recipe.time)"
        for i in 0..<self.recipe.ingredients.count{
            postingString = postingString + "&ingredients[]=\(self.recipe.ingredients[i])"
        }
        for i in 0..<self.recipe.steps.count{
            postingString = postingString + "&steps[]=\(self.recipe.steps[i])"
        }
        for i in 0..<self.recipe.notes.count{
            postingString = postingString + "&notes[]=\(self.recipe.notes[i])"
        }
        print(postingString)
        let postString = postingString
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
            if self.inputImage != nil {
                self.myImageUploadRequest()
            }
            else{
                self.delete()
            }
            
            if error != nil {
                print("error:\(error)")
                return
            }
                
                print ("response = \(response)")
            
            }
            task.resume()
        //return families
        }
    }
    
    func myImageUploadRequest()
       {
         
        let myUrl = NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Recipes/updateImage.php");
           
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
           
           let param = [
            "family_ID"  : UserDefaults.standard.string(forKey: "family")!,
            "recipe_Name"    : self.recipe.title
           ]
           
           let boundary = generateBoundaryString()
           
           request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
           
    
        let imageData = self.inputImage!.jpegData(compressionQuality: 1)
           
           if(imageData==nil)  { return; }
           
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
           
           
           //myActivityIndicator.startAnimating();
           
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
               data, response, error in
               
               if error != nil {
                   print("error=\(error)")
                   return
               }
               
               // You can print out response object
               print("******* response = \(response)")
               
               // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
               print("****** response data = \(responseString!)")
               
               do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                   
                   print(json)
                   
                   /*dispatch_async(dispatch_get_main_queue(),{
                       self.myActivityIndicator.stopAnimating()
                       self.myImageView.image = nil;
                   });*/
                   
               }catch
               {
                   print(error)
               }
               
           }
           
           task.resume()
       }
       
       
       func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
           let body = NSMutableData();
           
           if parameters != nil {
               for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
               }
           }
          
        let filename = self.recipe.title + ".jpg"
                   let mimetype = "image/jpg"
                   
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
           
       
           
        body.appendString(string: "--\(boundary)--\r\n")
           
           return body
       }
       
       
       
       func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
       }
    
    func delete(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Recipes/deleteImage.php")! as URL)
        request.httpMethod = "POST"
        let postString = "family_ID=\(UserDefaults.standard.string(forKey: "family")!)&recipe_Name=\(self.recipe.title)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
            
            
            }
            task.resume()
        //return families
    }
}

struct RecipeUpdate_Previews: PreviewProvider {
    static var previews: some View {
        RecipeUpdate(recipe: Recipe(recipe_ID: 0, title: "my squads lit", author: "", rating: 3, serves: "", time: "", steps: [], ingredients: [], notes: []), old_title: "")
    }
}
