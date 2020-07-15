//
//  GalleryModel.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/22/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct Picture: Identifiable{
    var id = UUID()
    var image: Image
    var url: String
}

