//
//  UpdateTradition.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 7/4/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct UpdateTradition: View {
    @State var tradition: Tradition
    @State var old_title: String
    @State var holdS: String = ""
    @State var holdI: String = ""
    @State var holdN: String = ""
    @State var counter1 = 0
    @State var counter2 = 0
    @State var counter3 = 0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    
    
    var body: some View {
        VStack{
            ZStack{
                if tradition.image != nil{
                    tradition.image?
                        .resizable()
                }else{
                    Rectangle()
                        .fill(Color.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .frame(height: 300)
            .onTapGesture {
                self.showingImagePicker = true
            }
            VStack{
                TextField("Enter Traditon Name", text: $tradition.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                    .background(Color(red: 255, green: 255, blue: 255, opacity: 1))
                RatingView(rating: $tradition.importance)
            }.offset(y: -20)
            ScrollView{
                HStack{
                    Image(systemName: "book.fill")
                    Text("Author: ").font(.system(.headline, design: .serif))
                    TextField("Enter the author's name", text: $tradition.author)
                }
                .padding(.horizontal, 20)
                HStack{
                    Image(systemName: "calendar")
                    Text("Date: ").font(.system(.headline, design: .serif))
                    TextField("Enter any relevant date/s", text: $tradition.date)
                }
                .padding(.horizontal, 20)
                HStack{
                    Image(systemName: "clock.fill")
                    Text("Duration: ").font(.system(.headline, design: .serif))
                    TextField("Enter the duration of tradition", text: $tradition.duration)
                }
                .padding(.horizontal, 20)
                HStack{
                    Image(systemName: "greaterthan.square.fill")
                    Text("Description:").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.horizontal, 20)
                HStack{
                    TextField("Please enter a description of the tradition", text: $tradition.description)
                    Spacer()
                }.padding(.horizontal, 20)
                VStack(spacing: 20){
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Items Needed").font(.system(.headline, design: .serif))
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach (tradition.items, id: \.self){item in // show received results
                            HStack{
                                Text(String(self.tradition.items.firstIndex(of: item)! + 1) + ": " + item).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.tradition.items.firstIndex(of: item)!
                                    self.tradition.items.remove(at: index)
                                }){
                                    Image(systemName: "minus.circle.fill")
                                }.accentColor(.gray)
                            }
                        }
                    }//.frame(maxWidth: .infinity)  // << important !!
                    HStack{
                        TextField("Enter any item needed", text: $holdI).frame(width: 300)
                        Button(action: {
                            self.addItem()
                        }){
                            Image(systemName: "plus.circle.fill")
                            }.accentColor(.gray)
                    }
                }.frame(maxWidth: 325)
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Procedure/Steps").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach (tradition.steps, id: \.self){step in // show received results
                            HStack{
                                Text(String(self.tradition.steps.firstIndex(of: step)! + 1) + ": " + step).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.tradition.steps.firstIndex(of: step)!
                                    self.tradition.steps.remove(at: index)
                                }){
                                    Image(systemName: "minus.circle.fill")
                                }.accentColor(.gray)
                            }
                        }
                    }//.frame(maxWidth: .infinity)  // << important !!
                    HStack{
                        TextField("Enter a Step or Procedure to Follow", text: $holdS).frame(width: 300)
                        Button(action: {
                            self.addStep()
                        }){
                            Image(systemName: "plus.circle.fill")
                            }.accentColor(.gray)
                    }
                }.frame(maxWidth: 325)
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Notes").font(.system(.headline, design: .serif))
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach (tradition.notes, id: \.self){note in // show received results
                            HStack{
                                Text(String(self.tradition.notes.firstIndex(of: note)! + 1) + ": " + note).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.tradition.notes.firstIndex(of: note)!
                                    self.tradition.notes.remove(at: index)
                                }){
                                    Image(systemName: "minus.circle.fill")
                                }.accentColor(.gray)
                            }
                        }
                    }//.frame(maxWidth: .infinity)  // << important !!
                    HStack{
                        TextField("Enter Additional Notes", text: $holdN).frame(width: 300)
                        Button(action: {
                            self.addNotes()
                        }){
                            Image(systemName: "plus.circle.fill")
                            }.accentColor(.gray)
                    }
                }.frame(maxWidth: 325)
                }.offset(x: -25, y: 10)
                VStack{
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Additional Information:").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                        Spacer()
                    }.padding(.horizontal, 20)
                    HStack{
                        TextField("Add any aditional information", text: $tradition.additional)
                        Spacer()
                    }.padding(.horizontal, 20)
                }.offset(y: 20)
            }
            Button("Save", action: {
                self.save()
            }).accentColor(.black)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        tradition.image = Image(uiImage: inputImage)
    }
    
    func addStep() -> Void {
        // store result string (must be on main queue)
        self.counter1 += 1
        self.tradition.steps.append(self.holdS)
        self.holdS = ""
    }
    
    func addItem(){
        // store result string (must be on main queue)
        self.counter2 += 1
        self.tradition.items.append(self.holdI)
        self.holdI = ""
    }
    
    func addNotes(){
        // store result string (must be on main queue)
        self.counter3 += 1
        self.tradition.notes.append(self.holdN)
        self.holdN = ""
    }
    
    func save(){
        if (Int(UserDefaults.standard.string(forKey: "family")!) != 1){
         var family_ID: String = UserDefaults.standard.string(forKey: "family")!
               var values: NSDictionary = [:]
               let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Update_Items/update_Tradition.php")! as URL)
               request.httpMethod = "POST"
        var postingString = "family_ID=\(family_ID)&old_title=\(self.old_title)&new_title=\(self.tradition.title)&author=\(self.tradition.author)&importance=\(self.tradition.importance)&date=\(self.tradition.date)&duration=\(self.tradition.duration)&description=\(self.tradition.description)"
        for i in 0..<self.tradition.items.count{
            postingString = postingString + "&items[]=\(self.tradition.items[i])"
               }
        for i in 0..<self.tradition.steps.count{
                   postingString = postingString + "&steps[]=\(self.tradition.steps[i])"
               }
        for i in 0..<self.tradition.notes.count{
                postingString = postingString + "&notes[]=\(self.tradition.notes[i])"
        }
        
        postingString = postingString + "&additional=\(self.tradition.additional)"
        
               print(postingString)
               let postString = postingString
               request.httpBody = postString.data(using: String.Encoding.utf8)
                   
               let task = URLSession.shared.dataTask(with: request as URLRequest){
                       data, response, error in
                       
                if self.inputImage != nil {
                       self.myImageUploadRequest()
                   }
                   else{
                       self.delete()
                   }
                   
                
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
    
    func myImageUploadRequest()
       {
         
        let myUrl = NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Traditions/updateImage.php");
           
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
           
           let param = [
            "family_ID"  : UserDefaults.standard.string(forKey: "family")!,
            "tradition_Name"    : self.tradition.title
           ]
           
           let boundary = generateBoundaryString()
           
           request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
           
    
        let imageData = self.inputImage!.jpegData(compressionQuality: 1)
           
           if(imageData==nil)  { return; }
           
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
           
           
           //myActivityIndicator.startAnimating();
           
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
               data, response, error in
               
               if error != nil {
                   print("error=\(error)")
                   return
               }
               
               // You can print out response object
               print("******* response = \(response)")
               
               // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
               print("****** response data = \(responseString!)")
               
               do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                   
                   print(json)
                   
                   /*dispatch_async(dispatch_get_main_queue(),{
                       self.myActivityIndicator.stopAnimating()
                       self.myImageView.image = nil;
                   });*/
                   
               }catch
               {
                   print(error)
               }
               
           }
           
           task.resume()
       }
       
       
       func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
           let body = NSMutableData();
           
           if parameters != nil {
               for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
               }
           }
          
        let filename = self.tradition.title + ".jpg"
                   let mimetype = "image/jpg"
                   
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
           
       
           
        body.appendString(string: "--\(boundary)--\r\n")
           
           return body
       }
       
       
       
       func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
       }
    
    func delete(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Recipes/deleteImage.php")! as URL)
        request.httpMethod = "POST"
        let postString = "family_ID=\(UserDefaults.standard.string(forKey: "family")!)&tradition_Name=\(self.tradition.title)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
            
            
            }
            task.resume()
        //return families
    }
}

struct UpdateTradition_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTradition(tradition: Tradition(
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
        ), old_title: "")
    }
}
