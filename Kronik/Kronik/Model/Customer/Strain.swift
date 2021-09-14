//
//  Strain.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/8/21.
//

import Foundation
import SwiftyJSON

class Strain: Codable{
    var id: Int?
    var name: String?
    var race: Int?
    var short_description: String?
    var image: String?
    var price: Float?
    var price_type:Int?
    
    init(json:JSON){
        self.id = json["id"].int
        self.name = json["name"].string
        self.race = json["race"].int
        self.short_description = json["short_description"].string
        self.image = json["image"].string
        self.price = json["price"].float
        self.price_type = json["price_type"].int
    }
}
