//
//  LoginPage.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 7/4/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
    @State var name: String = ""
    @ObservedObject var viewRouter: ViewRouters
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                Text("Welcome to Praxis!")
                    .font(.largeTitle)
                    .foregroundColor(Color(hue: 0.146, saturation: 0.984, brightness: 0.803))
                    .lineLimit(1)
                .multilineTextAlignment(.center)
                Text("This is an application where you can share family recipes, traditions, and photos with your close ones").font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray).multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            }.padding(.horizontal, 20)
            Spacer()
            VStack{
                Text("Enter your name to begin: ").font(.headline)
                    .foregroundColor(Color(hue: 0.146, saturation: 0.984, brightness: 0.803))
                    .lineLimit(1)
                .multilineTextAlignment(.center)
                TextField("Ex: Yoganand Pathak", text: $name)
                .font(.headline)
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                Button(action: {
                    UserDefaults.standard.set(self.name, forKey: "Name")
                    self.addUser()
                    self.viewRouter.currentPage = "FamilyMain"
                }){
                    Text("Sign Up").font(.body)
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    .multilineTextAlignment(.center)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 50)
                }.border(Color(hue: 0.146, saturation: 0.984, brightness: 0.803), width: 1.0)
                    .background(Color(hue: 0.146, saturation: 0.3, brightness: 0.803)).cornerRadius(20)
                
            }.padding(.bottom, 100)
            .padding(.horizontal, 20)
            Spacer()
            Text("Note: If your family already uses this application, ensure that the name you enter is the same name as the one they entered when adding you as a family member").font(.caption)
                .foregroundColor(Color.gray)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 50)
            .padding(.horizontal, 50)
        }
    }
    
    func addUser(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Add_Items/add_User.php")! as URL)
        request.httpMethod = "POST"
        var postingString = "name=\(self.name)"
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

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(viewRouter: ViewRouters())
    }
}
