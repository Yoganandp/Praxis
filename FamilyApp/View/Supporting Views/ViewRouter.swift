//
//  onboarding.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 7/4/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


class ViewRouter: ObservableObject {
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "onboardingView"
        } else {
            currentPage = "homeView"
        }
    }
    
    @Published var currentPage: String
    
}



