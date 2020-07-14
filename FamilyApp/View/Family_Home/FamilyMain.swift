//
//  SwiftUIView.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/13/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI
import Combine

struct FamilyMain: View {
    
    @State var families: [Family] = []
    @State var willMoveToNextScreen = false
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State var addNew: Bool = false
    @State var addButton: Bool = true
    @State var current_family: Family? = nil
    @State var image: Image? = nil
    var body: some View {
        VStack{
                HStack{
                    Button(action: {
                        self.getData()
                    }){
                        Image(systemName: "arrow.clockwise")
                    }
                    .padding(.horizontal, 30)
                    Spacer()
                    Text("Families")
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
                        ForEach(families){family in
                            FamilyListView(family: family)
                        }
                    }
                    .frame(maxWidth: 640)
                    .padding(.horizontal, 30)
                }
        }.onAppear{
            self.getData()
            
        }
            .sheet(isPresented: self.$addNew){
                CreateFamily()
            }
    
    }
    
    func getData(){
        //var families: [Family] = []
        var name: String = UserDefaults.standard.string(forKey: "Name")!
        var values: NSDictionary = [:]
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Get_Data/get_data.php")! as URL)
        request.httpMethod = "POST"
        let postString = "name=\(name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
            values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
            
            
            self.getImage(values: values)
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

    func createFamilyData(values: NSDictionary){
        //var families: [Family] = []
        var family:NSDictionary = values["Family"] as! NSDictionary
        var family_ID: Int = Int((family["family_ID"] as! NSString).doubleValue)
        UserDefaults.standard.set(String(family_ID), forKey: "family")
        if (family_ID != 1){
            self.addButton = false
        var name: String = family["name"] as! String
            var numOfPhotos: Int = (values["Photos"]) as! Int
        var users:NSArray = values["Family_Members"] as! NSArray
        var inputingUsers: [String] = []
        print (users.count)
        for i in 0..<users.count{
            var user:NSDictionary = users[i] as! NSDictionary
            inputingUsers.append(user["name"] as! String)
        }
        
        var recipes:NSArray = values["Recipes"] as! NSArray
        var inputingRecipes: [Recipe] = []
        print (recipes.count)
        for i in 0..<recipes.count {
            var recipe:NSDictionary = recipes[i] as! NSDictionary
            var recip: Recipe = Recipe(recipe_ID: 0, title: "", author: "", rating: 0, serves: "", time: "", steps: [], ingredients: [], notes: [])
            var info:NSDictionary = recipe["info"] as! NSDictionary
            recip.recipe_ID = Int((info["recipe_ID"] as! NSString).doubleValue)
            recip.title = info["title"] as! String
            recip.author = info["author"] as! String
            recip.image = nil
            recip.rating = Int((info["rating"] as! NSString).doubleValue)
            recip.serves = info["serves"] as! String
            recip.time = info["time"] as! String
            
            var ingredients:NSArray = recipe["ingredients"] as! NSArray
            print (ingredients.count)
            for j in 0..<ingredients.count {
                var ingredient:NSDictionary = ingredients[j] as! NSDictionary
                var ingred:String = ingredient["ingredient"] as! String
                recip.ingredients.append(ingred)
            }
            
            var steps:NSArray = recipe["steps"] as! NSArray
            print (steps.count)
            for j in 0..<steps.count {
                var step:NSDictionary = steps[j] as! NSDictionary
                var ste:String = step["step"] as! String
                recip.steps.append(ste)
            }
            
            var notes:NSArray = recipe["notes"] as! NSArray
            print (notes.count)
            print ("")
            for j in 0..<notes.count {
                var note:NSDictionary = notes[j] as! NSDictionary
                var not:String = note["note"] as! String
                recip.notes.append(not)
            }
            
            inputingRecipes.append(recip)
        }
        
        RecipeData = inputingRecipes
        
        var traditions:NSArray = values["Traditions"] as! NSArray
        var inputingTraditions: [Tradition] = []
        for i in 0..<traditions.count {
            var tradition:NSDictionary = traditions[i] as! NSDictionary
            var tradit: Tradition = Tradition(tradition_ID: 0, title: "", author: "", importance: 0, date: "", duration: "", description: "", steps: [], items: [], notes: [], additional: "")
            var info:NSDictionary = tradition["info"] as! NSDictionary
            tradit.tradition_ID = Int((info["tradition_ID"] as! NSString).doubleValue)
            tradit.title = info["title"] as! String
            tradit.author = info["author"] as! String
            tradit.image = nil
            tradit.importance = Int((info["importance"] as! NSString).doubleValue)
            tradit.date = info["date"] as! String
            tradit.duration = info["duration"] as! String
            tradit.description = info["description"] as! String
            tradit.additional = info["additional"] as! String
            
            var items:NSArray = tradition["items"] as! NSArray
            for j in 0..<items.count {
                var item:NSDictionary = items[j] as! NSDictionary
                var ite:String = item["item"] as! String
                tradit.items.append(ite)
            }
            
            var steps:NSArray = tradition["steps"] as! NSArray
            for j in 0..<steps.count {
                var step:NSDictionary = steps[j] as! NSDictionary
                var ste:String = step["step"] as! String
                tradit.steps.append(ste)
            }
            
            var notes:NSArray = tradition["notes"] as! NSArray
            for j in 0..<notes.count {
                var note:NSDictionary = notes[j] as! NSDictionary
                var not:String = note["note"] as! String
                tradit.notes.append(not)
            }
            
            inputingTraditions.append(tradit)
        }
        
        RecipeData = inputingRecipes
        TraditionData = inputingTraditions
        var temp: Family = Family(
            family_ID: family_ID,
            name: name,
            users: inputingUsers,
            image: self.image,
            recipes: RecipeData,
            traditions: TraditionData,
            gallery: numOfPhotos
        )
        
        if self.families.count < 1 {
            self.families.append(temp)
        }
        else{
            self.families[0] = temp
        }
        FamilyData = self.families
        print(FamilyData)
    }
    }
    
    func getImage(values: NSDictionary){
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Families/getFamilyImage.php")! as URL)
        request.httpMethod = "POST"
            let postString = "user_Name=\(UserDefaults.standard.string(forKey: "Name")!)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
            
            print(data)
            
            
            var img: UIImage?
            
            img = UIImage(data: data!,scale:1.0)
            
            
            if img != nil {
                self.image = Image(uiImage: img!)
            }
            
            self.createFamilyData(values: values)
            print(data)
            }
            task.resume()
        //return families
        
    }
    
}




struct FamilyMain_Previews: PreviewProvider {
    static var previews: some View {
        FamilyMain()
    }
}
