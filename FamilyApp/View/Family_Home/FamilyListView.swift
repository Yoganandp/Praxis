//
//  FamilyListView.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/22/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct FamilyListView: View {
    @State var family: Family
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State private var showModal: Bool = false
    
    var body: some View {
        HStack{
            family.image?
            .resizable().clipShape(Circle()).frame(width: 75, height: 75)
            VStack(alignment: .leading){
                Text(family.name + " Family")
                .font(.system(.title, design: .serif))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                Text("Number of Members: " + String(family.users.count))
                    .font(.system(.body, design: .serif))
                .foregroundColor(.gray)
                .italic()
                .lineLimit(1)
            }
            Spacer()
        }.onTapGesture {
                self.hapticImpact.impactOccurred()
                self.showModal = true
        }
        .sheet(isPresented: self.$showModal){
            FamilyView(family: self.family)
        }
    }
}

struct FamilyListView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyListView(family: FamilyData[0])
            .previewLayout(.sizeThatFits)
    }
}
