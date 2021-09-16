//
//  HomeTable.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/14/21.
//

import UIKit

class HomeTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    //TODO:

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
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.rowHeight = 220
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
