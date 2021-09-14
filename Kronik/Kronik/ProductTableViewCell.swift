//
//  ProductTableViewCell.swift
//  Kronik
//
//  Created by Kunle Ademefun on 8/31/21.
//

import UIKit
class ProductsTableViewCell: UITableViewCell{

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    

    var products: Product?{
        didSet {
            categoryName.text = products?.categoryName
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func seeAllPressed(_ sender: Any) {
    }
    
    
    
    
}
extension ProductsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.productName.text = products?.products?[indexPath.row].name
//        cell.productImg.image = UIImage(named: products?.products?[indexPath.row].imageName ?? "")
        return cell
    }
}
