//
//  HomeView.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/14/21.
//

import UIKit

class HomeView: UIViewController {
    
    
    var dispensaryID = 6
    
    var products = [String:[Any]]()
    
    var categories = [
        "",
        "Flowers",
        "Vapes",
        "Edibles",
        "Extracts",
        "Prerolls",
        "Accessories",
        "Wellness"
    ]
    
    var strains = [Strain]()
    var accesoroes = [Accessory]()
    var vapes = [Vape]()
    var edible = [Edible]()
    var extracts = [Extract]()
    var wellness = [Wellness]()
    var prerolls = [Preroll]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strains = []
        // Do any additional setup after loading the view.
        loadProducts()
        print("SXS STRAINS ARRAY: \(strains)")
        print("SXS PRODUCTS ARRAY: \(products)")
    }
    
    func loadProducts(){
//        Helpers.showActivityIndicator(activityIndicator,self.view)
//        if let dispensaryId = dispensaryID{
        APIManager.shared.getFlowers(dispensaryId: dispensaryID)
//            APIManager.shared.getStrains(dispensaryId: dispensaryID) { (json) in
//                print("SXS: JSON nil CHECK")
//
//                if json != nil{
//                    print("SXS: JSON IS NOT NIL")
//                    self.strains = []
//                    
//                    let tempStrains = json["strains"].array
//                    print("SXS: FOR LOOP STARTS")
//                    for (index,item) in tempStrains!.enumerated(){
//                        let strain = Strain(json: item)
//                        self.strains.append(strain)
//                        self.strains[index] = strain
//                        print("SXS STRAIN 'ADDED': \(strain)")
////                            self.tableView.reloadData()
////                            Helpers.hideActivityIndicator(self.activityIndicator)
//                    }
//                    
//                }else{
//                    print("JSON IS NIL. ERROR: \(json.error)")
//                }
//                
//            }
        
        
        
        
//        }
        products["Flowers"] = strains
        
        
    }
    
    
    
    
    
    
}
