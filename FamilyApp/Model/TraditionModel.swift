//
//  File.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/16/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

//MARK: - TRADITION MODEL

struct Tradition: Identifiable {
    var id = UUID()
    var tradition_ID: Int
    var title: String
    var author: String
    var image: Image?
    var importance: Int
    var date: String
    var duration: String
    var description: String
    var steps: [String]
    var items: [String]
    var notes: [String]
    var additional: String
}

