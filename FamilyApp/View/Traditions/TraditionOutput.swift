//
//  TraditionOutput.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/18/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct TraditionOutput: View {
    @State var tradition: Tradition = Tradition(
            tradition_ID: 0,
            title: "",
            author: "",
            image: nil,
            importance: 5,
            date: "",
            duration: "",
            description: "",
            steps: [],
            items: [],
            notes: [],
            additional: ""
    )
    
    @State var addNew: Bool = false
    @State var current_tradition: Tradition? = nil
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        VStack(alignment: .leading){
                ZStack{
                    if tradition.image != nil{
                        tradition.image?
                            .resizable()
                    }else{
                        Rectangle()
                            .fill(Color.secondary)
                        Text("No picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    HStack{
                        VStack{
                            Button("Delete", action: {
                                self.delete()
                            })
                            .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        Spacer()
                        VStack{
                            Button("Edit", action: {
                                self.hapticImpact.impactOccurred()
                                self.addNew = true
                            })
                            .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        
                    }.padding(.vertical, 65).padding(.horizontal, 15)
                }
                .offset(y: -45)
                .frame(height: 300)
                HStack{
                    Spacer()
                    VStack{
                        Text(tradition.title)
                            .font(.system(.title, design: .serif))
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .background(Color(red: 255, green: 255, blue: 255, opacity: 1)).cornerRadius(8)
                        HStack{
                            ForEach(0..<tradition.importance){_ in
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                            }
                            ForEach(tradition.importance..<5){_ in
                                Image(systemName: "star.fill").foregroundColor(.gray)
                            }
                        }
                    }.offset(y: -50)
                    Spacer()
                }
                ScrollView (showsIndicators: false){
                    VStack(alignment: .leading, spacing: 20){
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "book.fill")
                                Text("Author: ").font(.system(.headline, design: .serif))
                                Text(tradition.author).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                            }
                            //.offset(x: 20)
                            HStack{
                                Image(systemName: "calendar")
                                Text("Date: ").font(.system(.headline, design: .serif))
                                Text(tradition.date).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                            }
                            //.offset(x: 20)
                            HStack{
                                Image(systemName: "clock.fill")
                                Text("Duration: ").font(.system(.headline, design: .serif))
                                Text(tradition.duration).font(.system(.headline, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376)).lineLimit(1)
                            }
                            //.offset(x: 20)
                            HStack{
                                Image(systemName: "greaterthan.square.fill")
                                Text("Description:").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack{
                                Text(tradition.description).lineLimit(nil).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                            }
                        }
                        VStack(alignment: .leading, spacing: 20){
                            VStack(alignment: .leading, spacing: 5){
                                HStack{
                                    Image(systemName: "greaterthan.square.fill")
                                    Text("Procedure").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                                }
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach (tradition.steps, id: \.self){step in // show received results
                                        Text(step).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                    }
                                }//.frame(maxWidth: .infinity)  // << important !!
                            }//.frame(maxWidth: 325)
                            VStack(alignment: .leading, spacing: 5){
                                HStack{
                                    Image(systemName: "greaterthan.square.fill")
                                    Text("Items Needed").font(.system(.headline, design: .serif))
                                }
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach (tradition.items, id: \.self){item in // show received results
                                        Text(item).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                    }
                                }//.frame(maxWidth: .infinity)  // << important !!
                            }//.frame(maxWidth: 325)
                            VStack(alignment: .leading, spacing: 5){
                                HStack{
                                    Image(systemName: "greaterthan.square.fill")
                                    Text("Notes").font(.system(.headline, design: .serif))
                                }
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach (tradition.notes, id: \.self){note in // show received results
                                        Text(note).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                    }
                                }//.frame(maxWidth: .infinity)  // << important !!
                            }//.frame(maxWidth: 325)
                        }//.offset(x: -25, y: 10)
                        VStack(alignment: .leading, spacing: 5){
                            HStack{
                                Image(systemName: "greaterthan.square.fill")
                                Text("Additional Information:").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack{
                                Text(tradition.additional).lineLimit(nil).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                            }
                        }
                    }
                }.offset(y: -25).padding(.horizontal, 20)
        }.sheet(isPresented: self.$addNew){
            UpdateTradition(tradition: self.tradition, old_title: self.tradition.title)
        }
    }
    
    func delete(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Delete_Items/delete_Tradition.php")! as URL)
        request.httpMethod = "POST"
        var postingString = "title=\(self.tradition.title)"
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

struct TraditionOutput_Previews: PreviewProvider {
    static var previews: some View {
        TraditionOutput()
    }
}
