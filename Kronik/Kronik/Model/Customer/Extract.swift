//
//  Extract.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/14/21.
//

import Foundation
import SwiftyJSON

class Extract: Codable{
    var id: Int?
    var name: String?
    var race: Int?
    var description: String?
    var image: String?
    var price: Float?
    var url: String?
    
    init(json:JSON){
        self.id = json["id"].int
        self.name = json["name"].string
        self.race = json["race"].int
        self.description = json["description"].string
        self.image = json["image"].string
        self.price = json["price"].float
        self.url = json["url"].string
    }
}
