//
//  RecipeList.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/13/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct RecipeList: View {
    @State var recipes: [Recipe] = []
    @State var willMoveToNextScreen = false
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State var addNew: Bool = false
    @State var addButton: Bool = false
    @State var current_recipe: Recipe? = nil
    @State var urls: [String] = []
    @State var images: [Image?] = []
    @State var counterr: Int = 0
    //RecipeData[0]
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.recipes = []
                    self.getUrls()
                    
                }){
                    Image(systemName: "arrow.clockwise")
                }
                .padding(.horizontal, 30)
                Spacer()
                Text("Recipes")
                Spacer()
                if addButton != false{
                    Button(action: {
                        self.hapticImpact.impactOccurred()
                        self.addNew = true
                    }){
                        Image(systemName: "plus")
                    }.padding(.horizontal, 30)
                }
                else{
                    Button("    ", action: {
                    }).padding(.horizontal, 30)
                }
            }.padding(.vertical, 10)
            ScrollView{
                //MARK: RECIPE CARDS
                VStack(alignment: .center, spacing: 20){
                    ForEach(recipes){recipe in
                        RecipeListView(recipe: recipe)
                    }
                }
                .frame(maxWidth: 640)
                .padding(.horizontal)
            }
        }.onAppear{
            self.getUrls()
            if(UserDefaults.standard.string(forKey: "family")! != "1"){
                self.addButton = true
            }
        }
            .sheet(isPresented: self.$addNew){
            RecipeCardInput()
        }
    }
    
    func tapgest(recipe: Recipe){
        self.willMoveToNextScreen = true
        self.current_recipe = recipe
    }
    
    func getData(){
        //var families: [Family] = []
        if (Int(UserDefaults.standard.string(forKey: "family")!) != 1){
        var name: String = UserDefaults.standard.string(forKey: "Name")!
        var values: NSDictionary = [:]
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Get_Data/get_recipes.php")! as URL)
        request.httpMethod = "POST"
        let postString = "name=\(name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
            values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
            self.createRecipeData(values: values)
            //print (values)
                
            if error != nil {
                print("error:\(error)")
                return
            }
                
                print ("response = \(response)")
            
            }
            task.resume()
        //return families
        }
        else{
            self.addButton = false
        }
    }

    func createRecipeData(values: NSDictionary){
        var recipes:NSArray = values["Recipes"] as! NSArray
        var inputingRecipes: [Recipe] = []
        for i in 0..<recipes.count {
            var recipe:NSDictionary = recipes[i] as! NSDictionary
            var recip: Recipe = Recipe(recipe_ID: 0, title: "", author: "", rating: 0, serves: "", time: "", steps: [], ingredients: [], notes: [])
            var info:NSDictionary = recipe["info"] as! NSDictionary
            recip.recipe_ID = Int((info["recipe_ID"] as! NSString).doubleValue)
            recip.title = info["title"] as! String
            recip.author = info["author"] as! String
            print(self.images.count)
            print(recipes.count)
            recip.image = self.images[i]
            recip.rating = Int((info["rating"] as! NSString).doubleValue)
            recip.serves = info["serves"] as! String
            recip.time = info["time"] as! String
            
            var ingredients:NSArray = recipe["ingredients"] as! NSArray
            for j in 0..<ingredients.count {
                var ingredient:NSDictionary = ingredients[j] as! NSDictionary
                var ingred:String = ingredient["ingredient"] as! String
                recip.ingredients.append(ingred)
            }
            
            var steps:NSArray = recipe["steps"] as! NSArray
            for j in 0..<steps.count {
                var step:NSDictionary = steps[j] as! NSDictionary
                var ste:String = step["step"] as! String
                recip.steps.append(ste)
            }
            
            var notes:NSArray = recipe["notes"] as! NSArray
            for j in 0..<notes.count {
                var note:NSDictionary = notes[j] as! NSDictionary
                var not:String = note["note"] as! String
                recip.notes.append(not)
            }
            
            inputingRecipes.append(recip)
        }
        
        RecipeData = inputingRecipes
        
        print (inputingRecipes)
        self.recipes = inputingRecipes
    }
    
    func getUrls(){
        //var families: [Family] = []
        var values: NSArray = []
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Recipes/getRecipeUrls.php")! as URL)
        request.httpMethod = "POST"
        let postString = "family_ID=\(UserDefaults.standard.string(forKey: "family")!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
            values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
               
            self.urls = []
            print (values)
            for value in values{
                var temp: NSDictionary = value as! NSDictionary
                if let featured = temp["image"] as? String {
                    self.urls.append(featured)
                }
                else {
                    self.urls.append("")
                }
            }
            print (values)
            
            self.images = []
            for i in 0..<self.urls.count{
                self.images.append(nil)
            }
            
            self.counterr = 0
            for i in 0..<self.urls.count{
                
                self.getImages(url: self.urls[i], count: i)
            }
                
            
            //self.show = true
                    
            if error != nil {
                print("error:\(error)")
                return
            }
                
                print ("response = \(response)")
            
            }
            task.resume()
        //return families
    }
    func getImages(url: String, count: Int){
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Recipes/getRecipeImages.php")! as URL)
        request.httpMethod = "POST"
            let postString = "url=\(url)&family_ID=\(UserDefaults.standard.string(forKey: "family")!)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
          
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
            
            
            print(data)
            
            
            
            var img: UIImage?
            
            img = UIImage(data: data!,scale:1.0)
            
            if img != nil {
                self.images[count] = Image(uiImage: img!)
            }
            else{
            }
            self.counterr += 1
            if self.counterr == self.urls.count{
                self.getData()
            }
            
            }
            task.resume()
        //return families
        
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList(recipes: RecipeData)
    }
}
