//
//  UpdateFamily.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 7/4/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct UpdateFamily: View {
    @State var family: Family = Family(
        family_ID: 0,
        name: "",
        users: [],
        image: nil,
        recipes: [],
        traditions: [],
        gallery: 0
    )
    @State var old_name = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State var holdM: String = ""
    @State var showCreateButton: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50){
            HStack{
                Spacer()
                VStack{
                    if showCreateButton != false{
                        Button(action: {
                            self.save()
                            self.showCreateButton = false
                            
                        }){
                        Text("Update")
                    }.accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    }
                }
                
            }.padding(.all, 15)
            VStack(alignment: .center, spacing: 20){
                ZStack{
                    if family.image != nil{
                        family.image?
                            .resizable().clipShape(Circle())
                    }else{
                        Circle()
                            .fill(Color(hue: 1.0, saturation: 0.153, brightness: 0.63))
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.body)
                            .multilineTextAlignment(.center)
                    }
                }.frame(width: 150, height: 150)
                .onTapGesture {
                    self.showingImagePicker = true
                }
                TextField("Enter Family Name", text: $family.name).textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, alignment: .center)
                .multilineTextAlignment(.center)
                .background(Color(red: 255, green: 255, blue: 255, opacity: 1))
            }.padding(.leading, 50)
            ScrollView{
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "greaterthan.square.fill")
                        Text("Family Members").font(.system(.headline, design: .serif)).multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach (family.users, id: \.self){user in // show received results
                            HStack{
                                Text(user).font(.system(.body, design: .serif)).foregroundColor(Color(hue: 0.148, saturation: 0.1, brightness: 0.376))
                                Spacer()
                                Button(action: {
                                    var index: Int = 0
                                    index = self.family.users.firstIndex(of: user)!
                                    self.family.users.remove(at: index)
                                }){
                                    Image(systemName: "minus.circle.fill")
                                }.accentColor(.gray)
                            }
                        }
                    }//.frame(maxWidth: .infinity)  // << important !!
                    HStack{
                        TextField("Enter New Family Member's Name", text: $holdM).frame(width: 300)
                        Spacer()
                        Button(action: {
                            self.addMember()
                        }){
                            Image(systemName: "plus.circle.fill")
                        }.accentColor(.gray)
                    }
                }
            }.padding(.horizontal, 20)
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }


    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        family.image = Image(uiImage: inputImage)
    }
    
    func save() {
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/Update_Items/update_Family.php")! as URL)
        request.httpMethod = "POST"
        var postingString = "old_name=\(self.old_name)&new_name=\(self.family.name)"
        for i in 0..<self.family.users.count{
            postingString = postingString + "&users[]=\(self.family.users[i])"
        }
        print(postingString)
        let postString = postingString
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
            if self.inputImage != nil{
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
    
    func addMember() -> Void {
        // store result string (must be on main queue)
        self.family.users.append(self.holdM)
        self.holdM = ""
    }
    
    func myImageUploadRequest()
       {
         
        let myUrl = NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Families/updateImage.php");
           
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
           
           let param = [
            "family_ID"  : UserDefaults.standard.string(forKey: "family")!
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
          
                   let filename = "family_pic.jpg"
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
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Families/deleteImage.php")! as URL)
        request.httpMethod = "POST"
            let postString = "family_ID=\(UserDefaults.standard.string(forKey: "family")!)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
            
            
            }
            task.resume()
        //return families
    }
    
}

struct UpdateFamily_Previews: PreviewProvider {
    static var previews: some View {
        UpdateFamily()
    }
}
