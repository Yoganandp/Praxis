//
//  FamilyView.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/22/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct FamilyView: View {
    @State var family: Family
    
    @State var addNew: Bool = false
    @State var current_recipe: Recipe? = nil
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            HStack{
                VStack{
                    Button(action: {
                        self.leave()
                    }){
                    Text("Leave Family")
                    }.accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                VStack{
                    Button(action: {
                        self.hapticImpact.impactOccurred()
                        self.addNew = true
                    }){
                    Text("Update")
                    }.accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                }
            }.padding(.all, 15)
            HStack{
                Spacer()
                VStack(alignment: .center, spacing: 20){
                    ZStack{
                        if family.image != nil{
                            family.image?
                                .resizable().clipShape(Circle())
                        }else{
                            Circle()
                                .fill(Color(hue: 1.0, saturation: 0.153, brightness: 0.63))
                            Text("No Image")
                                .foregroundColor(.white)
                                .font(.body)
                                .multilineTextAlignment(.center)
                        }
                    }.frame(width: 150, height: 150)
                    Text(family.name + " Family")
                        .font(.system(.title, design: .serif))
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .background(Color(red: 255, green: 255, blue: 255, opacity: 1)).cornerRadius(8)
                }
                Spacer()
            }.padding(.top, 75)
                VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "book.fill")
                            Text("Recipes: ").font(.system(.headline, design: .serif))
                            Text(String(family.recipes.count)).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                            Spacer()
                        }
                        //.offset(x: 20)
                        HStack{
                            Image(systemName: "suit.spade.fill")
                            Text("Traditions: ").font(.system(.headline, design: .serif))
                            Text(String (family.traditions.count)).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                        }
                        //.offset(x: 20)
                        HStack{
                            Image(systemName: "photo.fill.on.rectangle.fill")
                            Text("Photos: ").font(.system(.headline, design: .serif))
                            Text(String (family.gallery)).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                        }
                }.padding(.horizontal, 45)
                ScrollView{
                    VStack(alignment: .leading, spacing: 5){
                        HStack{
                            Image(systemName: "greaterthan.square.fill")
                            Text("Family Members: ").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                        }
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach (family.users, id: \.self){user in // show received results
                                Text(user).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                            }
                        }//.frame(maxWidth: .infinity)  // << important !!                    }
                }
            }.padding(.horizontal, 45)
        }.sheet(isPresented: self.$addNew){
            UpdateFamily(family: self.family, old_name: self.family.name)
        }
    }
    
    func leave(){
        var name: String = UserDefaults.standard.string(forKey: "Name")!
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Delete_Items/leave_family.php")! as URL)
        request.httpMethod = "POST"
        var postingString = "name=\(name)"
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

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyView(family: Family(family_ID: 0, name: "", users: [], recipes: [], traditions: [], gallery: 0))
    }
}
