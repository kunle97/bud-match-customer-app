//
//  Product.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/8/21.
//

import Foundation
import SwiftyJSON

class Priduct: Codable{
    var id: Int?
    var name: String?
    var short_description: String?
    var image: String?
    var price: Float?
    
    init(json:JSON){
        self.id = json["id"].int
        self.name = json["name"].string
        self.short_description = json["short_description"].string
        self.image = json["image"].string
        self.price = json["price"].float
    }
}
