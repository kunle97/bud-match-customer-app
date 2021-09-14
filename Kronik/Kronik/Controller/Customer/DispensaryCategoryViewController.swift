//
//  DispensaryCategoryViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 8/26/21.
//

import UIKit

class DispensaryCategoryViewController: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let categories = [
        [
            "name":"Flowers",
            "image":"leaf1-green-ui"
        ],
        [
        "name":"Edibles",
        "image":"leaf1-green-ui"
        ],
        [
         "name":"Extracts",
         "image":"leaf1-green-ui"
        ],
        [
            "name":"Vapes",
            "image":"leaf1-green-ui"
        ],
        [
        "name":"Prerolls",
        "image":"leaf1-green-ui"
        ],
        [
        "name":"Wellness",
        "image":"leaf1-green-ui"
        ],
        [
        "name":"Accessories",
        "image":"leaf1-green-ui"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension DispensaryCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category_cell", for: indexPath) as! CategoryCollectionViewCell
//        cell.categoryImage.image = UIImage(named: categories[indexPath.row]["image"]!)
        cell.categoryLabel.text = categories[indexPath.row]["name"]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
        
    }
}
