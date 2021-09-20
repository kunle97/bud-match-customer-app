//
//  JarItem.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/8/21.
//

import Foundation

//Object for a cart item
class JarItem: Codable{
    var product: Product
    var qty: Int
    
    init(product: Product, qty: Int){
        self.product = product
        self.qty = qty
        
    }
}

//Jar is Like a shopping cart
class Jar:Codable {
    static let currentJar = Jar()
    var dispensary: Dispensary?
    var items = [JarItem]()
    var address: String?
    var addressDidChange = false
    
    func getTotal() -> Float{
        var total: Float = 0
        for item in self.items{
            total = total + Float(item.qty) * item.product.price!
         }
        return total
    }
    
    
    func reset(){
        self.dispensary = nil
        self.items = []
        self.address = nil
    }
    
}
