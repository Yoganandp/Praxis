//
//  RecipeCardView.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/10/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: Recipe
    
    @State var addNew: Bool = false
    @State var current_recipe: Recipe? = nil
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        VStack(alignment: .leading){
                ZStack{
                    if recipe.image != nil{
                        recipe.image?
                            .resizable()
                    }else{
                        Rectangle()
                            .fill(Color.secondary)
                        Text("No picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    HStack{
                        VStack{
                            Button("Delete", action: {
                                self.delete()
                            })
                            .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        Spacer()
                        VStack{
                            Button("Edit", action: {
                                self.hapticImpact.impactOccurred()
                                self.addNew = true
                            })
                            .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        
                    }.padding(.vertical, 65).padding(.horizontal, 15)
                }
                .offset(y: -45)
                .frame(height: 300)
                HStack{
                    Spacer()
                    VStack{
                        Text(recipe.title)
                            .font(.system(.title, design: .serif))
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .background(Color(red: 255, green: 255, blue: 255, opacity: 1)).cornerRadius(8)
                        HStack{
                            ForEach(0..<recipe.rating){_ in
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                            }
                            ForEach(recipe.rating..<5){_ in
                                Image(systemName: "star.fill").foregroundColor(.gray)
                            }
                        }
                    }.offset(y: -50)
                    Spacer()
                }
                ScrollView (showsIndicators: false){
                    VStack(alignment: .leading, spacing: 20){
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "book.fill")
                                Text("Author: ").font(.system(.headline, design: .serif))
                                Text(recipe.author).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                            }
                            //.offset(x: 20)
                            HStack{
                                Image(systemName: "clock.fill")
                                Text("Time: ").font(.system(.headline, design: .serif))
                                Text(recipe.time).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                            }
                            //.offset(x: 20)
                            HStack{
                                Image(systemName: "person.fill")
                                Text("Serves: ").font(.system(.headline, design: .serif))
                                Text(recipe.serves).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                            }
                            //.offset(x: 20)
                        }
                        VStack(alignment: .leading, spacing: 20){
                            VStack(alignment: .leading, spacing: 5){
                                HStack{
                                    Image(systemName: "greaterthan.square.fill")
                                    Text("Ingredients").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                                }
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach (recipe.ingredients, id: \.self){ingredient in // show received results
                                        Text(ingredient).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                    }
                                }//.frame(maxWidth: .infinity)  // << important !!
                            }//.frame(maxWidth: 325)
                            VStack(alignment: .leading, spacing: 5){
                                HStack{
                                    Image(systemName: "greaterthan.square.fill")
                                    Text("Steps").font(.system(.headline, design: .serif))
                                }
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach (recipe.steps, id: \.self){step in // show received results
                                        Text(step).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                    }
                                }//.frame(maxWidth: .infinity)  // << important !!
                            }//.frame(maxWidth: 325)
                            VStack(alignment: .leading, spacing: 5){
                                HStack{
                                    Image(systemName: "greaterthan.square.fill")
                                    Text("Notes").font(.system(.headline, design: .serif))
                                }
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach (recipe.notes, id: \.self){note in // show received results
                                        Text(note).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                    }
                                }//.frame(maxWidth: .infinity)  // << important !!
                            }//.frame(maxWidth: 325)
                        }//.offset(x: -25, y: 10)
                    }
                }.offset(y: -25).padding(.horizontal, 20)
        }.sheet(isPresented: self.$addNew){
            RecipeUpdate(recipe: self.recipe, old_title: self.recipe.title)
        }
    }
    
    func delete(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Delete_Items/delete_Recipe.php")! as URL)
        request.httpMethod = "POST"
        var postingString = "title=\(self.recipe.title)"
        print(postingString)
        let postString = postingString
        request.httpBody = postString.data(using: String.Encoding.utf8)
         let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
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


struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: Recipe(recipe_ID: 0, title: "", author: "", rating: 3, serves: "", time: "", steps: [], ingredients: [], notes: []))
    }
}
