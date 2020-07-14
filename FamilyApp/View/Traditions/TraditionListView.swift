//
//  TraditionListView.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/18/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct TraditionListView: View {
    //MARK: - PROPERTIES
    var tradition: Tradition
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State private var showModal: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ZStack{
                if tradition.image != nil{
                    tradition.image?
                        .resizable()
                } else{
                    Rectangle()
                        .fill(Color.secondary)
                    Text("No picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }.frame(height: 250)
            VStack(alignment: .leading, spacing: 12){
                Text(tradition.title)
                    .font(.system(.title, design: .serif))
                    .lineLimit(1)
                
                Text(tradition.description)
                    .font(.system(.body, design: .serif))
                    .foregroundColor(.gray)
                    .italic()
                    .lineLimit(1)
                
                HStack(alignment: .center, spacing: 5){
                    ForEach(0..<tradition.importance){_ in
                        Image(systemName: "star.fill").foregroundColor(.yellow)
                    }
                    ForEach(tradition.importance..<5){_ in
                        Image(systemName: "star.fill").foregroundColor(.gray)
                    }
                }
                
                HStack(alignment: .center, spacing: 12){
                    HStack(alignment: .center, spacing: 2){
                        Image(systemName: "calendar")
                        Text("Date: " + tradition.date).lineLimit(1)
                    }
                    Spacer()
                    HStack(alignment: .center, spacing: 2){
                        Image(systemName: "clock")
                        Text("Duration: " + tradition.duration).lineLimit(1)
                    }
                }
            }.padding()
            .padding(.bottom,12)
        }.background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 0)
        .onTapGesture {
                self.hapticImpact.impactOccurred()
                self.showModal = true
        }
        .sheet(isPresented: self.$showModal){
            TraditionOutput(tradition: self.tradition)
        }
    }
}

struct TraditionListView_Previews: PreviewProvider {
    static var previews: some View {
        TraditionListView(tradition: TraditionData[0])
            .previewLayout(.sizeThatFits)
    }
}
