//
//  FamilyModel.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/22/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct Family: Identifiable {
    var id = UUID()
    var family_ID: Int
    var name: String
    var users: [String]
    var image: Image?
    var recipes: [Recipe]
    var traditions: [Tradition]
    var gallery: Int
}
