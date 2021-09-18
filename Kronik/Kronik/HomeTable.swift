//
//  HomeTable.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/14/21.
//

import UIKit

class HomeTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    //TODO:
    
    var dispensaryID = 6
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
    
    var products = [String:[Any]]()
    var strains = [Strain]()
    var accesoroes = [Accessory]()
    var vapes = [Vape]()
    var edible = [Edible]()
    var extracts = [Extract]()
    var wellness = [Wellness]()
    var prerolls = [Preroll]()
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.rowHeight = 220
        
        loadProducts()
    }
    
    func loadProducts(){
//        Helpers.showActivityIndicator(activityIndicator,self.view)
//        if let dispensaryId = dispensaryID{
            
            APIManager.shared.getStrains(dispensaryId: dispensaryID) { (json) in
                print("SXS: JSON nil CHECK")

                if json != nil{
                    print("SXS: JSON IS NOT NIL")

                    self.strains = []
                    
                    let tempStrains = json["strains"].array
                    print("SXS: FOR LOOP STARTS")
                    for (index,item) in tempStrains!.enumerated(){
                        let strain = Strain(json: item)
                        self.strains.append(strain)
                        self.strains[index] = strain
                        print("SXS STRAIN 'ADDED': \(strain)")
//                            self.tableView.reloadData()
//                            Helpers.hideActivityIndicator(self.activityIndicator)
                    }
                    
                }else{
                    print("JSON IS NIL. ERROR: \(json.error)")
                }
            }
        
        
        
        
//        }
        products["Flowers"] = strains
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0{
            let cell = dequeueReusableCell(withIdentifier: "FeatureCell", for: indexPath) as! FeatureCell
            return cell
        }else{
        let cell = dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.categoryTitle.text  = categories[indexPath.row]
        
            
        return cell
            
        }
    }
    


}
