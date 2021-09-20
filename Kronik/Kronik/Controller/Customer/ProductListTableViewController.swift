//
//  StrainListTableViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/27/21.
//

import UIKit

class ProductListTableViewController: UITableViewController {

    var dispensary: Dispensary?
    var products = [Product]()
    var dispensaryURL:String?
    @IBOutlet weak var webViewButton: UIBarButtonItem!
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dispensaryName = dispensary?.name{
            self.navigationItem.title = dispensaryName
        }
        dispensaryURL = dispensary?.url
        loadProducts()
        print("STRAINS GOD DAMMIT \(products)")
    }
    
    func loadProducts() {
        self.products = []
       
        Helpers.showActivityIndicator(activityIndicator,self.view)
        if let dispensaryId = dispensary?.id{
        APIManager.shared.getProducts(dispensaryId: dispensaryId) { (json) in
                if json != nil{
                    
                    if let tempStrains = json["products"].array{
                        for item in tempStrains{
                            let product = Product(json: item)
                            self.products.append(product)
                            
                            self.tableView.reloadData()
                            Helpers.hideActivityIndicator(self.activityIndicator)
                        }
                    }
                }
            }
        
        }
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductDetails"{
            let controller = segue.destination as! ProductDetailsViewController
            controller.product = products[(tableView.indexPathForSelectedRow?.row) as! Int]
            controller.dispensary = dispensary
        }
    }
    @IBAction func dispensaryWebViewPressed(_ sender: Any) {
        guard let url = URL(string:  (dispensary?.url)!) else{
            return
        }
        let vc  = DispensaryWebViewController(url:url, title: (dispensary?.name)!)
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC,animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "StrainCell", for: indexPath) as! StrainViewCell
        let product = products[indexPath.row]
        
        cell.strainNameLabel.text = product.name
        cell.shortDescriptionlabel.text = product.description
        
        if let price = product.price{
            cell.priceLabel.text = "$\(price)"
        }
//        switch product.price_type {
//        case 1://Quarter

//            break
//        case 2:// Half
//            if let price = product.price{
//                cell.priceLabel.text = "$\(price) per 1/2 Oz"
//            }
//            break
//        case 3://Eighth
//            if let price = product.price{
//                cell.priceLabel.text = "$\(price) per 1/8 Oz"
//            }
//            break
//        case 4://Gram
//            if let price = product.price{
//                cell.priceLabel.text = "$\(price) per gram"
//            }
//            break
//        default:
//            print("")
//        }
        
        if let image = product.image{
            Helpers.loadImage(cell.strainImage, "\(image)")
        }
        
        return cell
    }

}
