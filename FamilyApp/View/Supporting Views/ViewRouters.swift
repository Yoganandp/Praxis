//
//  ViewRouters.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 7/5/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouters: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouters,Never>()
    
    var currentPage: String = "LoginPage" {
        didSet {
            objectWillChange.send(self)
        }
    }
}
