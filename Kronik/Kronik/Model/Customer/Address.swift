//
//  Address.swift
//  Kronik
//
//  Created by Kunle Ademefun on 7/9/21.
//

import Foundation
import SwiftyJSON
class Address: Codable{
    var addressID: Int?
    var street: String?
    var apt: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var country: String?
    var isDefaultAddress:Bool?
    
    
    init(json: JSON) {
        self.addressID = json["id"].int
        self.street = json["street"].string
//        self.apt = json["apt"].string
        self.city = json["city"].string
        self.state = json["state"].string
        self.zipcode = json["zipcode"].string
        self.country = json["country"].string
        self.isDefaultAddress = json["default"].bool
    }
    
    func toString() -> String{//Returns the concatenated string of the full address
        if self.apt == nil{
            let fullAddress = "\(street!), \(city!), \(state!) \(zipcode!) \(country!)"
            print("Address toString() without APT \(fullAddress)")
            return fullAddress
            
        }else{
            let fullAddress = "\(street!) \(apt!), \(city!) \(state!) \(zipcode!) \(country!)"
            print("Address toString() With APT \(fullAddress)")
            return fullAddress
        }
        
        
    }
    
}
