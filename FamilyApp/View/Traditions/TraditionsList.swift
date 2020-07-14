//
//  TraditionsList.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/13/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct TraditionsList: View {
    @State var traditions: [Tradition] = TraditionData
    @State var willMoveToNextScreen = false
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State var addNew: Bool = false
    @State var addButton: Bool = false
    @State var current_tradition: Tradition? = nil
    @State var urls: [String] = []
    @State var images: [Image?] = []
    @State var counterr: Int = 0
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.traditions = []
                    self.getUrls()
                }){
                    Image(systemName: "arrow.clockwise")
                }
                .padding(.horizontal, 30)
                Spacer()
                Text("Traditions")
                Spacer()
                if addButton != false{
                    Button(action: {
                        self.hapticImpact.impactOccurred()
                        self.addNew = true
                    }){
                        Image(systemName: "plus")
                    }.padding(.horizontal, 30)
                }
                else{
                    Button("    ", action: {
                    }).padding(.horizontal, 30)
                }
            }.padding(.vertical, 10)
            ScrollView{
                //MARK: RECIPE CARDS
                VStack(alignment: .center, spacing: 20){
                    ForEach(traditions){tradition in
                        TraditionListView(tradition: tradition)
                    }
                }
                .frame(maxWidth: 640)
                .padding(.horizontal)
            }
        }.onAppear{
            self.getUrls()
            if(UserDefaults.standard.string(forKey: "family")! != "1"){
                self.addButton = true
            }
        }.sheet(isPresented: self.$addNew){
            TraditionInput()
        }
    }
    
    func tapgest(tradition: Tradition){
        self.willMoveToNextScreen = true
        self.current_tradition = tradition
    }
    
    func getData(){
        //var families: [Family] = []
        if (Int(UserDefaults.standard.string(forKey: "family")!) != 1){
        var name: String = UserDefaults.standard.string(forKey: "Name")!
        var values: NSDictionary = [:]
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Get_Data/get_traditions.php")! as URL)
        request.httpMethod = "POST"
        let postString = "name=\(name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
            values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
            self.createTraditionData(values: values)
            //print (values)
                
            if error != nil {
                print("error:\(error)")
                return
            }
                
                print ("response = \(response)")
            
            }
            task.resume()
        //return families
        }
        else{
            self.addButton = false
        }
    }

    func createTraditionData(values: NSDictionary){
        var traditions:NSArray = values["Traditions"] as! NSArray
        var inputingTraditions: [Tradition] = []
        for i in 0..<traditions.count {
            var tradition:NSDictionary = traditions[i] as! NSDictionary
            var tradit: Tradition = Tradition(tradition_ID: 0, title: "", author: "", importance: 0, date: "", duration: "", description: "", steps: [], items: [], notes: [], additional: "")
            var info:NSDictionary = tradition["info"] as! NSDictionary
            tradit.tradition_ID = Int((info["tradition_ID"] as! NSString).doubleValue)
            tradit.title = info["title"] as! String
            tradit.author = info["author"] as! String
            tradit.image = self.images[i]
            tradit.importance = Int((info["importance"] as! NSString).doubleValue)
            tradit.date = info["date"] as! String
            tradit.duration = info["duration"] as! String
            tradit.description = info["description"] as! String
            tradit.additional = info["additional"] as! String
            
            var items:NSArray = tradition["items"] as! NSArray
            for j in 0..<items.count {
                var item:NSDictionary = items[j] as! NSDictionary
                var ite:String = item["item"] as! String
                tradit.items.append(ite)
            }
            
            var steps:NSArray = tradition["steps"] as! NSArray
            for j in 0..<steps.count {
                var step:NSDictionary = steps[j] as! NSDictionary
                var ste:String = step["step"] as! String
                tradit.steps.append(ste)
            }
            
            var notes:NSArray = tradition["notes"] as! NSArray
            for j in 0..<notes.count {
                var note:NSDictionary = notes[j] as! NSDictionary
                var not:String = note["note"] as! String
                tradit.notes.append(not)
            }
            
            inputingTraditions.append(tradit)
        }
        
        TraditionData = inputingTraditions
        self.traditions = inputingTraditions
    }
    
    func getUrls(){
        //var families: [Family] = []
        var values: NSArray = []
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Traditions/getTraditionUrls.php")! as URL)
        request.httpMethod = "POST"
        let postString = "family_ID=\(UserDefaults.standard.string(forKey: "family")!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
            values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
               
            self.urls = []
            print (values)
            for value in values{
                var temp: NSDictionary = value as! NSDictionary
                if let featured = temp["image"] as? String {
                    self.urls.append(featured)
                }
                else {
                    self.urls.append("")
                }
            }
            print (values)
            
            
            self.images = []
            for i in 0..<self.urls.count{
                self.images.append(nil)
            }
            
            self.counterr = 0
            for i in 0..<self.urls.count{
                
                self.getImages(url: self.urls[i], count: i)
            }
            
                
            
            //self.show = true
                    
            if error != nil {
                print("error:\(error)")
                return
            }
                
                print ("response = \(response)")
            
            }
            task.resume()
        //return families
    }
    func getImages(url: String, count: Int){
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Traditions/getTraditionImages.php")! as URL)
        request.httpMethod = "POST"
            let postString = "url=\(url)&family_ID=\(UserDefaults.standard.string(forKey: "family")!)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
          
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
            
            
            print(data)
            
            
            var img: UIImage?
            
            img = UIImage(data: data!,scale:1.0)
            
            if img != nil {
                self.images[count] = Image(uiImage: img!)
            }
            else{
            }
            self.counterr += 1
            if self.counterr == self.urls.count{
                self.getData()
            }
            
            }
            task.resume()
        //return families
        
    }
}

struct TraditionsList_Previews: PreviewProvider {
    static var previews: some View {
        TraditionsList()
    }
}
