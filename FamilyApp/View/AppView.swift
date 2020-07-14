//
//  AppView.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/13/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView{
            FamilyMain()
            .tabItem({
                Image(systemName: "house.fill")
                Text("Home")
                })
            RecipeList(recipes: RecipeData)
            .tabItem({
                Image(systemName: "book.fill")
                Text("Recipes")
            })
            TraditionsList()
            .tabItem({
                Image(systemName: "suit.spade.fill")
                Text("Traditions")
            })
            Gallery()
            .tabItem({
                Image(systemName: "photo.fill.on.rectangle.fill")
                Text("Gallery")
            })
        }
        //.edgesIgnoringSafeArea(.top)
        .accentColor(.primary)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
