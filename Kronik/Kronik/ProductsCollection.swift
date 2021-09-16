//
//  ProductsCollection.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/14/21.
//

import UIKit

class ProductsCollection: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //1. Retrieve all products from data base
    //2. Store in array "categories"
    //3.
    var products = [Strain]()
    
    let activityIndicator = UIActivityIndicatorView()
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 220, height: 220)
        self.collectionViewLayout = layout
       
    }
    
    
    func loadStrains(){
        Helpers.showActivityIndicator(activityIndicator,self.superview!)
        let dispensaryId = 4
        APIManager.shared.getStrains(dispensaryId: dispensaryId) { [self] (json) in
            if json != nil{
                self.products = []
                if let tempStrains = json["strains"].array{
                    for item in tempStrains{
                        let strain = Strain(json: item)
                        self.products.append(strain)
                        self.reloadData()
                        Helpers.hideActivityIndicator(self.activityIndicator)
                    }
                }
            }
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return products.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
//        cell.productName.text = products[indexPath.row].name
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

