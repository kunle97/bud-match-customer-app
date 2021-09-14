//
//  DriverOrder.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/12/21.
//

import Foundation
import SwiftyJSON

class DriverOrder{
    var id: Int?
    var customerName: String?
    var customerAddress: String?
    var customerAvatar: String?
    var dispensaryName: String?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.customerName = json["customer"]["name"].string
        self.customerAddress = json["address"].string
        self.customerAvatar = json["customer"]["avatar"].string
        self.dispensaryName = json["dispensary"]["name"].string
    }
    
}
