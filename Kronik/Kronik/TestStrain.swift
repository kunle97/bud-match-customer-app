//
//  TestStrain.swift
//  Kronik
//
//  Created by Kunle Ademefun on 8/30/21.
//

import Foundation

struct StrainModel:Codable{
    var response: [TestStrain]?
}
struct TestStrain:Codable{
    var Strain: String?
    var Race: String?
    var Rating: String?
    var Effects: String?
    var Flavor: String?
    var Description: String?
}
