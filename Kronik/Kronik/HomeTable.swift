//
//  HomeTable.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/14/21.
//

import UIKit

class HomeTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    //TODO:
    
    var dispensaryID:Int? = 6
    var dispensary: Dispensary?
    let activityIndicator = UIActivityIndicatorView()

    
//    var products = [String:[Any]]()
    var strains = [Strain]()
    var flower_products = [Product]()
    var vape_products = [Product]()
    var edible_products = [Product]()
    var extract_products = [Product]()
    var preroll_products = [Product]()
    var accessory_products = [Product]()
    var wellness_products = [Product]()
    var other_products = [Product]()
    
    var categories = [
        [
        "category":"Category",
         "data": [Product]()
        ]
    ]
    override func awakeFromNib() {
  
        
        loadProducts()
    }
    
    func sortProduct(product: Product){
        if product.product_type == 1{
            self.flower_products.append(product)
        }else if product.product_type == 2{
            self.vape_products.append(product)
        }else if product.product_type == 3{
            self.edible_products.append(product)
        }else if product.product_type == 4{
            self.extract_products.append(product)
        }else if product.product_type == 5{
            self.preroll_products.append(product)
        }else if product.product_type == 6{
            self.accessory_products.append(product)
        }else if product.product_type == 7{
            self.wellness_products.append(product)
        }else if product.product_type == 8{
            self.other_products.append(product)
        }
        
        
    }
    
    func loadProducts() {
       
        Helpers.showActivityIndicator(activityIndicator,self)
        if let dispensaryId = dispensaryID{
        APIManager.shared.getProducts(dispensaryId: dispensaryId) { (json) in
                if json != nil{
                    
                    if let tempStrains = json["products"].array{
                        for item in tempStrains{
                            let product = Product(json: item)
//                            print("SXS PRODUCT DATA: name: \(product.name!) -  price: \(product.price!)" )
                            self.sortProduct(product: product)
                            self.reloadData()
                            Helpers.hideActivityIndicator(self.activityIndicator)
                        }
                        self.categories = [
                            
                        ]
                        
                    }
                }
            }
        
        }

    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  categories.count
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
        var product_category = categories[row]["category"] as! String
        cell.categoryTitle.text = product_category
        cell.productCollection.categoryName = product_category
        cell.productCollection.tag = indexPath.section
        cell.productCollection.reloadData()
//        cell.productCollection.delegate = self
//        cell.productCollection.dataSource = categories[row]["data"]
            
        return cell
            
        }
    }
    


}






extension HomeTable: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return products.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
//        cell.productName.text = cat[indexPath.row].name
//        cell.productPrice.text = "$\(products[indexPath.row].price)"
//        if let image = products[indexPath.row].image{
//            Helpers.loadImage(cell.productImage, "\(image)")
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 220.0, height: 220.0)
    }

}
