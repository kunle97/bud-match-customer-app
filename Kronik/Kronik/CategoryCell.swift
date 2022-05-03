//
//  CategoryCell.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/14/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var productCollection: ProductsCollection!
    var data = [Product]()
    var flower_products = [Product]()
    var vape_products = [Product]()
    var edible_products = [Product]()
    var extract_products = [Product]()
    var preroll_products = [Product]()
    var accessory_products = [Product]()
    var wellness_products = [Product]()
    var other_products = [Product]()
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productCollection.delegate = self
        productCollection.dataSource = self
        print("DATA RECEIVERD \(comp_product_data[0].products)")

    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func seeAllPressed(_ sender: Any) {
    }
}
extension CategoryCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 220.0, height: 220.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  comp_product_data[productCollection.tag].products!  .count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = comp_product_data[productCollection.tag].products![indexPath.row]
        
        print("SXS COLLECTION PRODUCT NAME: \(product.name)")
        print("SXS COLLECTION PRODUCT PRICE: \(product.price)")
        
        cell.productName.text = product.name
        cell.productPrice.text = "$\(product.price)"
        if let image = product.image{
            Helpers.loadImage(cell.productImage, "\(image)")
        }
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 220, height: 220)
        collectionView.collectionViewLayout = layout
     

        return cell
    }
    


}
