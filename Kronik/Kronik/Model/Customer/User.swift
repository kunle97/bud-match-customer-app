//
//  User.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/30/21.
//

import Foundation
import SwiftyJSON
class User{
    var firstName:String?
    var lastName:String?
    var name: String?
    var email: String?
    var phone: String?
    var addresses: [String:Any]?
    var pictureURL: String?
    var accessToken: String?
    
    static var currentUser = User(firstName: "", lastName: "", name: "", email: "", phone: "", addresses: ["":""], pictureURL: "", accessToken: "")
    
    init(firstName:String, lastName:String, name:String, email:String, phone:String, addresses: [String:Any]?, pictureURL:String, accessToken:String)  {
        self.firstName = firstName
        self.lastName = lastName
        self.name = "\(firstName) \(lastName)"
        self.email = email
        self.phone = phone
        self.addresses = ["":""]
        self.pictureURL = pictureURL
        self.accessToken = accessToken
    }
    
    
    func setInfo(json:JSON){
        self.name = json["name"].string
        self.email = json["email"].string
        
        let image = json["picture"].dictionary
        let imageData = image?["data"]?.dictionary
        self.pictureURL = imageData?["url"]?.string
        
    }
    
    func resetInfo(){
        self.name = nil
        self.email = nil
        self.pictureURL = nil
        self.accessToken = nil
    }
    
    func setName(_ firstName: String,_ lastName:String){
        self.name = "\(firstName) \(lastName)"
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func setPhone(_ phone:String){
        self.phone = phone
    }
    
    func setEmail(email: String){
        self.email = email
    }
    
    func setAccessToken(token: String){
        self.accessToken = token
    }
    
}
