//
//  RecipeModel.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/10/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

//MARK: - RECIPE MODEL

struct Recipe: Identifiable {
    var id = UUID()
    var recipe_ID: Int
    var title: String
    var author: String
    var image: Image?
    var rating: Int
    var serves: String
    var time: String
    var steps: [String]
    var ingredients: [String]
    var notes: [String]
    
}

