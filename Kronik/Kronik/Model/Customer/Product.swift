//
//  Product.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/8/21.
//

import Foundation
import SwiftyJSON

class Product: Codable{
    var id: Int?
    var name: String?
    var product_type:String?
    var description: String?
    var effects: String?
    var cbd: Float?
    var thc: Float?
    var race: Int?
    var image: String?
    var price: Float?
    var url: String?
    
    init(json:JSON){
        self.id = json["id"].int
        self.name = json["name"].string
        self.product_type = json["product_type"].string
        self.description = json["description"].string
        self.effects = json["effects"].string
        self.cbd = json["cbd"].float
        self.thc = json["thc"].float
        self.race = json["race"].int
        self.image = json["image"].string
        self.price = json["price"].float
        self.url = json["url"].string
    }
}
