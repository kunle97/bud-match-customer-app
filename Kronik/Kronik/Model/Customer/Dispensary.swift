//
//  Dispensary.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/4/21.
//

import Foundation
import SwiftyJSON

class Dispensary: Codable{
    var id: Int?
    var name: String?
    var address: String?
    var logo: String?
    var url: String?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.address = json["address"].string
        self.logo = json["logo"].string
        self.url = json["url"].string
    }
}
