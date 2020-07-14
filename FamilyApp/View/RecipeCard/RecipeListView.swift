//
//  RecipeListView.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/13/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct RecipeListView: View {
    //MARK: - PROPERTIES
    var recipe: Recipe
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State private var showModal: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ZStack{
                if recipe.image != nil{
                    recipe.image?
                        .resizable()
                } else{
                    Rectangle()
                        .fill(Color.secondary)
                    Text("No picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }.frame(height: 250)
            VStack(alignment: .leading, spacing: 12){
                Text(recipe.title)
                    .font(.system(.title, design: .serif))
                    .lineLimit(1)
                
                Text(recipe.author)
                    .font(.system(.body, design: .serif))
                    .foregroundColor(.gray)
                    .italic()
                    .lineLimit(1)
                
                HStack(alignment: .center, spacing: 5){
                    ForEach(0..<recipe.rating){_ in
                        Image(systemName: "star.fill").foregroundColor(.yellow)
                    }
                    ForEach(recipe.rating..<5){_ in
                        Image(systemName: "star.fill").foregroundColor(.gray)
                    }
                }
                
                HStack(alignment: .center, spacing: 12){
                    HStack(alignment: .center, spacing: 2){
                        Image(systemName: "person.2")
                        Text("Serves: " + recipe.serves).lineLimit(1)
                    }
                    Spacer()
                    HStack(alignment: .center, spacing: 2){
                        Image(systemName: "clock")
                        Text("Time: " + recipe.time).lineLimit(1)
                    }
                }
            }.padding()
            .padding(.bottom,12)
        }.background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 0)
        .onTapGesture {
                self.hapticImpact.impactOccurred()
                self.showModal = true
        }
        .sheet(isPresented: self.$showModal){
            RecipeCardView(recipe: self.recipe)
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(recipe: Recipe(recipe_ID: 0, title: "", author: "", rating: 3, serves: "", time: "", steps: [], ingredients: [], notes: []))
            .previewLayout(.sizeThatFits)
    }
}
