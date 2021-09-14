//
//  FilterSlider.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/10/20.
//

import UIKit

struct Filter{
    var type:String?
    var name:String?
    var target:String?
}

class FilterSlider:UICollectionViewController{
    
    var data = [
        Filter(type: "menu", name: "Sort By", target: "panel"),
        Filter(type: "default", name: "Nearby", target: "panel"),
        Filter(type: "default", name: "Sativa", target: "panel"),
        Filter(type: "default", name: "Indica", target: "panel"),
        Filter(type: "default", name: "Hybrid", target: "panel"),
        Filter(type: "default", name: "Nearby", target: "panel"),
        Filter(type: "default", name: "Sativa", target: "panel"),
        Filter(type: "default", name: "Indica", target: "panel"),
        Filter(type: "default", name: "Hybrid", target: "panel"),
        Filter(type: "default", name: "Nearby", target: "panel"),
        Filter(type: "default", name: "Sativa", target: "panel"),
        Filter(type: "default", name: "Indica", target: "panel"),
        Filter(type: "default", name: "Hybrid", target: "panel"),
    ]
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 15)//controlls size of cells in cv
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return data.count //Controlls number of cells in collection view
     }
     
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//Controlls appearance and content within CV cell
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCell
//        cell.backgroundColor = UIColor.init(red: 82/255, green: 157/255, blue: 133/255, alpha: 1.0)
        
         cell.setFilterName(name: data[indexPath.row].name!)
         return cell
     }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You chose the filter: \(data[indexPath.row].name)")
    }
    override func viewDidLoad() {
        self.viewDidLoad()
            let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
            layout.scrollDirection = .horizontal
//            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          
        self.collectionView!.setCollectionViewLayout(layout, animated: true)
        self.collectionView!.showsVerticalScrollIndicator = false
        self.collectionView!.showsHorizontalScrollIndicator = false
        self.collectionView!.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.register(FilterCell.self, forCellWithReuseIdentifier: "cell")
            // Do any additional setup after loading the view.
        }




    
}






class FilterCell: UICollectionViewCell{

    fileprivate let button: UIButton = {
        var btn = UIButton()
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Filter", for: .normal)
        btn.titleLabel!.font =  UIFont(name: ".AppleSystemUIFont", size: 14)
//        btn.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        K.shared.addFilterUIButtonStyle(button: btn)
        return btn
    }()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
       
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
//        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func  setFilterName(name: String){
        button.setTitle("\(name)", for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
