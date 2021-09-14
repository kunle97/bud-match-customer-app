//
//  Seller.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/2/20.
//

import UIKit
class Seller{
    var id:Int?
    var title:String?
    var tags:[String]?
    var img:UIImage?
    var longitude:Double?
    var latitude:Double?
    init(title:String, tags:[String]) {
        self.title = title
        self.tags = tags
    }
    init(title:String, tags:[String], image: UIImage) {
        self.title = title
        self.tags = tags
        self.img = image
    }
    init(title:String, tags:[String], image: UIImage, longitude:Double, latitude:Double) {
        self.title = title
        self.tags = tags
        self.img = image
        self.longitude = longitude
        self.latitude = latitude
    }

}
