//
//  NearMeSlider.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/10/20.
//

import UIKit


class ResultsSlider:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
   
    var data = [
        Seller(title: "Greenleaf Compassion Center",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.20540453312603, latitude: 40.81527731188963 ),
        Seller(title: "Alternative Weed Therapy",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.26230337986313, latitude: 40.79925917210424),
        Seller(title: "Elm Park Village",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude:  -74.20531180487427 , latitude:  40.77794423627538),
        
        Seller(title: "Newstead North",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.29579791756386, latitude: 40.762343607328845),
        Seller(title: "Garden State Dispensary - Union",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.29579791756386, latitude: 40.69413342212082),
        Seller(title: "Harmony Dispensary",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.08249742618894, latitude: 40.77327356231169),
        Seller(title: "Garden State Dispensary - Woodbridge",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.29389803332703, latitude: 40.57459107172388),
        Seller(title: "Greenleaf Compassion Center",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.21529997930737, latitude: 40.81422214315388),
        Seller(title: "Zen Leaf - Elizabeth",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.21403944294198, latitude: 40.684319207957635),
        Seller(title: "Get Pot Marijuana Dispensary and Collective",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.03995473787798, latitude: 40.442046014529716),
        
        
        
        Seller(title: "Sunnyside Medical Cannabis Dispensary - Hudson Valley",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -73.98729045735442, latitude: 41.1375927052859),
        Seller(title: "Etain Health - Medical Marijuana Dispensary Westchester",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -73.90097955316304, latitude: 40.948922258629636),
        Seller(title: "Columbia Care Manhattan Dispensary",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -73.9800920823447, latitude: 40.73971618924034),
        
        
    ]
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width*0.8, height: collectionView.frame.size.height*0.9)//controlls size of cells in cv
    }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return data.count //Controlls number of cells in collection view
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//Controlls appearance
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SellerResultsCell
        cell.backgroundColor = .green
        cell.setSellerName(name: data[indexPath.row].title!)
        cell.setSellerTags(tags: data[indexPath.row].tags!)
        if data[indexPath.row].img != nil{
            cell.setSellerImage(img: data[indexPath.row].img!)
        }
        K.shared.addTextFieldStyle(tf: cell)

        return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         print("You chose the dispensary: \(data[indexPath.row].title)")
     }
    
//    var data:[Seller]()
}
class SellerResultsCell: UICollectionViewCell{
    
    
    fileprivate let img: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "dispensary1")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    fileprivate let name: UILabel = {
        let label = UILabel()
        label.text =  "Dispensary"
        label.textColor = K.colors.primaryUIColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont(name: ".AppleSystemUIFont", size: 22)
        return label
    }()
    
    fileprivate let tags: UILabel = {
        let label = UILabel()
        label.text =  " "
        label.textColor = K.colors.grayUIColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont(name: ".AppleSystemUIFont", size: 15)
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(tags)
        
        img.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        img.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.68).isActive = true
        
        name.topAnchor.constraint(equalTo: img.topAnchor, constant: 155).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tags.topAnchor.constraint(equalTo: name.topAnchor, constant: 30).isActive = true
        tags.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        tags.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tags.heightAnchor.constraint(equalToConstant: 15).isActive = true
        

        
    }
    
    func  setSellerName(name: String){
        self.name.text = name
    }
    
    func  setSellerTags(tags: [String]){
        self.tags.text =  tags.joined(separator: " • ")
    }
    func setSellerImage(img: UIImage){
        self.img.image = img
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
