//
//  RecipeCardInput.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/10/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI


struct RecipeCardInput: View {
    @State var image: Image? = nil
    @State var recipeName: String = ""
    @State var time: String = ""
    @State var author: String = ""
    @State var serves: String = ""
    @State var ingredient: String = ""
    @State var showSaveButton: Bool = true
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var ingredients: [String] = []
    @State var steps: [String] = []
    @State var notes: [String] = []
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
                if self.image != nil{
                    self.image?
                            .resizable()
                    }else{
                        Rectangle()
                            .fill(Color.secondary)
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                }
            }.frame(height: 300)
            .onTapGesture {
                self.showingImagePicker = true
            }
            VStack{
                TextField("Enter Recipe Name", text: $recipeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                    .background(Color(red: 255, green: 255, blue: 255, opacity: 1))
                RatingView(rating: $rating)
            }.offset(y: -25)
            ScrollView{
                HStack{
                    Image(systemName: "book.fill")
                    Text("Author: ").font(.system(.headline, design: .serif))
                    TextField("Enter the author's name", text: $author)
                }
                .padding(.horizontal, 20)
                HStack{
                    Image(systemName: "clock.fill")
                    Text("Time: ").font(.system(.headline, design: .serif))
                    TextField("Enter estimated time for recipe", text: $time)
                }
                .padding(.horizontal, 20)
                HStack{
                    Image(systemName: "person.fill")
                    Text("Serves: ").font(.system(.headline, design: .serif))
                    TextField("Enter # that recipe serves", text: $serves)
                }
                .padding(.horizontal, 20)
                VStack(spacing: 20){
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Ingredients").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach (ingredients, id: \.self){ingredient in // show received results
                            HStack{
                                Text(String(self.ingredients.firstIndex(of: ingredient)! + 1) + ": " + ingredient).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.ingredients.firstIndex(of: ingredient)!
                                    self.ingredients.remove(at: index)
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
                        ForEach (steps, id: \.self){step in // show received results
                            HStack{
                                Text(String(self.steps.firstIndex(of: step)! + 1) + ": " + step).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.steps.firstIndex(of: step)!
                                    self.steps.remove(at: index)
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
                        ForEach (notes, id: \.self){note in // show received results
                            HStack{
                                Text(String(self.notes.firstIndex(of: note)! + 1) + ": " + note).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.notes.firstIndex(of: note)!
                                    self.notes.remove(at: index)
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
            if showSaveButton != false{
                Button("Save", action: {
                        self.save()
                        self.showSaveButton = false
                }).accentColor(.black)
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func addIngredient() -> Void {
        // store result string (must be on main queue)
        self.counter1 += 1
        self.ingredients.append(self.holdI)
        self.holdI = ""
    }
    
    func addStep(){
        // store result string (must be on main queue)
        self.counter2 += 1
        self.steps.append(self.holdS)
        self.holdS = ""
    }
    
    func addNote(){
        // store result string (must be on main queue)
        self.counter3 += 1
        self.notes.append(self.holdN)
        self.holdN = ""
    }
    
    func save(){
        var family_ID: String = UserDefaults.standard.string(forKey: "family")!
        var values: NSDictionary = [:]
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Add_Items/add_Recipe.php")! as URL)
        request.httpMethod = "POST"
        var postingString = "family_ID=\(family_ID)&title=\(self.recipeName)&author=\(self.author)&rating=\(self.rating)&serves=\(self.serves)&time=\(self.time)"
        for i in 0..<self.ingredients.count{
            postingString = postingString + "&instructions[]=\(self.ingredients[i])"
        }
        for i in 0..<self.steps.count{
            postingString = postingString + "&steps[]=\(self.steps[i])"
        }
        for i in 0..<self.notes.count{
            postingString = postingString + "&notes[]=\(self.notes[i])"
        }
        print(postingString)
        let postString = postingString
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
            if self.image != nil {
                self.myImageUploadRequest()
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
    
    func myImageUploadRequest()
       {
         
        let myUrl = NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Recipes/addRecipeImages.php");
           
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
           
           let param = [
            "family_ID"  : UserDefaults.standard.string(forKey: "family")!,
            "recipe_Name"    : self.recipeName
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
          
        let filename = self.recipeName + ".jpg"
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
    
}

struct RecipeCardInput_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardInput()
    }
}



