//
//  HomeView.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/14/21.
//

import UIKit


var comp_product_data = [
    Category(name: "Flowers", products: [Product]()),
    Category(name: "Vapes", products: [Product]()),
    Category(name: "Edible", products: [Product]()),
    Category(name: "Extract", products: [Product]()),
    Category(name: "Preroll", products: [Product]()),
    Category(name: "Accessory", products: [Product]()),
    Category(name: "Wellness", products: [Product]()),
    Category(name: "Other", products: [Product]()),
    
]

class HomeView: UIViewController {

    @IBOutlet weak var productListTableView: HomeTable!
    var dispensaryID:Int? = 6

    
    
    var flower_products = [Product]()
    var vape_products = [Product]()
    var edible_products = [Product]()
    var extract_products = [Product]()
    var preroll_products = [Product]()
    var accessory_products = [Product]()
    var wellness_products = [Product]()
    var other_products = [Product]()
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        productListTableView.delegate = self
        productListTableView.dataSource = self
        // Do any additional setup after loading the view.
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
        comp_product_data[0].products = flower_products
        comp_product_data[1].products = vape_products
        comp_product_data[2].products = edible_products
        comp_product_data[3].products = extract_products
        comp_product_data[4].products = preroll_products
        comp_product_data[5].products = accessory_products
        comp_product_data[6].products = wellness_products
        comp_product_data[7].products = other_products
        
    }
    
    func loadProducts() {
       
//        Helpers.showActivityIndicator(activityIndicator,self.view)
        if let dispensaryId = dispensaryID{
        APIManager.shared.getProducts(dispensaryId: dispensaryId) { (json) in
                if json != nil{
                    
                    if let tempStrains = json["products"].array{
                        for item in tempStrains{
                            let product = Product(json: item)
                            self.sortProduct(product: product)
                            self.productListTableView.reloadData()
//                            Helpers.hideActivityIndicator(self.activityIndicator)
                        }
                    }
                }
            }
        
        }
    
    }
    
    
    
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return comp_product_data.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return comp_product_data[section].name
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = productListTableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.categoryTitle.text = comp_product_data[indexPath.row].name
        cell.productCollection.tag = indexPath.section
        cell.data = comp_product_data[indexPath.row].products!
        let layout = cell.productCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 220, height: 220)
        cell.productCollection.collectionViewLayout = layout
        
        cell.productCollection.reloadData()
        
        print("COMP PRODUCT DATA COUNT: \(comp_product_data[1].products!.count)")
        print("DATA TRANSFER \(cell.data)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
//        view.textColor = UIColor.init(displayP3Red: 82/255, green: 157/255, blue: 133/255, alpha: 1)
    }
    
}



