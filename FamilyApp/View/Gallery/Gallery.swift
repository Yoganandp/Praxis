//
//  Gallery.swift
//  FamilyApp
//
//  Created by Yoganand Pathak on 6/13/20.
//  Copyright © 2020 Yoganand Pathak. All rights reserved.
//

import SwiftUI

struct Gallery: View {
    @State var pictures: [Picture] = []
    @State var pictures1: [Picture] = []
    @State var pictures2: [Picture] = []
    @State var pictures3: [Picture] = []
    @State var urls1: [String] = []
    @State var urls2: [String] = []
    @State var urls3: [String] = []
    @State var counter: Int = 0
    @State var counter1: Int =  0
    @State var urls: [String] = []
    @State var refresh: Bool = false
    
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State private var showModal: Bool = false
    @State private var currentPicture: Picture = Picture(
        image: Image("LaunchImage"),
        url: ""
    )
    
    @State var showImage: Bool = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var showAddButton: Bool = false
    
    
    

    var body: some View {
        ZStack{
            VStack{
                HStack{
                    if self.showImage != true{
                        Button(action: {
                            if self.refresh != false{
                                self.pictures1 = []
                                self.pictures2 = []
                                self.pictures3 = []
                                self.counter = 0
                                self.getUrls()
                                self.refresh = false
                            }
                        }){
                            Image(systemName: "arrow.clockwise")
                        }
                        .padding(.horizontal, 20)
                    }
                    Spacer()
                    Text("Family Gallery")
                    Spacer()
                    if self.showImage != true{
                        if self.showAddButton != false{
                            Button(action: {
                                self.showingImagePicker = true
                            }){
                                Image(systemName: "plus")
                            }.padding(.horizontal, 30)
                        }
                        else{
                           Button("    ", action: {}).padding(.horizontal, 30)
                        }
                    }
                }.padding(.vertical, 10)
                ScrollView{
                    HStack{
                            VStack{
                                ForEach(pictures1){picture in
                                    picture.image.resizable()
                                    .frame(width: 125, height: 125)
                                        .onTapGesture{
                                            self.currentPicture = picture
                                            withAnimation {
                                                self.showImage.toggle()
                                            }
                                            
                                    }
                                }
                                Spacer()
                            }.frame(width: 125)
                            
                            VStack{
                                ForEach(pictures2){picture in
                                    picture.image.resizable()
                                    .frame(width: 125, height: 125).onTapGesture{
                                            self.currentPicture = picture
                                            withAnimation {
                                                self.showImage.toggle()
                                            }
                                    }
                                }
                                Spacer()
                            }.frame(width: 125)
                            
                            VStack{
                                ForEach(pictures3){picture in
                                    picture.image.resizable()
                                    .frame(width: 125, height: 125).onTapGesture{
                                            self.currentPicture = picture
                                            withAnimation {
                                                self.showImage.toggle()
                                            }
                                    }

                                }
                                Spacer()
                            }.frame(width: 125)
                      }
                }
            }
                if self.showImage != false{
                    GeometryReader{_ in
                    VStack{
                        Spacer()
                        ZStack{
                            VStack{
                                HStack{
                                    Button(action: {
                                        withAnimation {
                                            self.showImage.toggle()
                                        }
                                    }){
                                        Image(systemName: "arrow.left.circle").resizable().frame(width: 25, height: 25)
                                    }.accentColor(.black).padding(.horizontal, 15)
                                    Spacer()
                                    Button(action: {
                                        self.delete()
                                        self.refresh = true
                                        withAnimation {
                                            self.showImage.toggle()
                                        }
                                    }){
                                        Image(systemName:
                                            "trash.circle")
                                        .resizable().frame(width: 25, height: 25)
                                    }.accentColor(.black).padding(.horizontal, 15)
                                }
                                Spacer()
                            }.edgesIgnoringSafeArea(.all)
                            self.currentPicture.image.resizable().frame(height: 300).padding(.horizontal, 10)
                        }
                        Spacer()
                    }
                    }.background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
                }
            
        }.onAppear{
            self.pictures1 = []
            self.pictures2 = []
            self.pictures3 = []
            self.counter = 0
            self.getUrls()
            
            if(UserDefaults.standard.string(forKey: "family")! != "1"){
                self.showAddButton = true
            }
            }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let temporary: Picture = Picture(image: Image(uiImage: inputImage), url: "")
        
        self.myImageUploadRequest()
        
        //self.uploadImage(image: inputImage)
        
        self.pictures.append(temporary)
        
        if (counter%3) == 0 {
            self.pictures1.append(temporary)
        }
        
        else if (counter%3) == 1 {
            self.pictures2.append(temporary)
        }
        
        else {
            self.pictures3.append(temporary)
        }
        
        self.counter += 1
    
    }
    
    func myImageUploadRequest()
       {
         
           let myUrl = NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Galleries/addingImages.php");
           
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
           
           let param = [
            "family_ID"  : UserDefaults.standard.string(forKey: "family")!,
               "user_Name"    : UserDefaults.standard.string(forKey: "Name")!
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
          
                   let filename = UserDefaults.standard.string(forKey: "Name")! + ".jpg"
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
    
    func getUrls(){
        if (Int(UserDefaults.standard.string(forKey: "family")!) != 17){
        //var families: [Family] = []
            var values: NSArray = []
            let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Galleries/getUrls.php")! as URL)
            request.httpMethod = "POST"
            let postString = "family_ID=\(UserDefaults.standard.string(forKey: "family")!)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
                
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    
                values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                   
                self.urls = []
                for value in values{
                    var temp: NSDictionary = value as! NSDictionary
                    self.urls.append(temp["image"] as! String)
                }
                print (values)
                
                for i in 0..<self.urls.count{
                    self.getImages(url: self.urls[i], counter: i)
                    self.counter += 1
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
    }
    func getImages(url: String, counter: Int){
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Galleries/getImage.php")! as URL)
        request.httpMethod = "POST"
            let postString = "url=\(url)&family_ID=\(UserDefaults.standard.string(forKey: "family")!)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
            
            print(data)
            
            
            var img: UIImage
            
            img = UIImage(data: data!,scale:1.0)!
            
            var gal: Picture = Picture(
                image: Image(uiImage: img),
                url: url
            )
            if (counter%3) == 0 {
                self.pictures1.append(gal)
            }
            
            else if (counter%3) == 1 {
                self.pictures2.append(gal)
            }
            
            else {
                self.pictures3.append(gal)
            }
            
                
            print(data)
            print(img)
            
            }
            task.resume()
        //return families
        
    }
    
    func delete(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://praxisfamily.000webhostapp.com/Family_App/imageOperations/Galleries/deleteImage.php")! as URL)
        request.httpMethod = "POST"
        let postString = "url=\(self.currentPicture.url)&family_ID=\(UserDefaults.standard.string(forKey: "family")!)"
        print (postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
            
            }
            task.resume()
        //return families
    }

}

extension NSMutableData {
   
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}


struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery()
    }
}
