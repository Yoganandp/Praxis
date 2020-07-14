//
//  MotherView.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 7/4/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct MotherView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var viewRouters: ViewRouters
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "onboardingView" {
                if viewRouters.currentPage == "LoginPage" {
                    LoginPage(viewRouter: viewRouters)
                } else if viewRouters.currentPage == "FamilyMain" {
                    AppView()
                }
            } else if viewRouter.currentPage == "homeView" {
                AppView()
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouters: ViewRouters()).environmentObject(ViewRouter())
    }
}
