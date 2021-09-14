//
//  FilterSlider.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/10/20.
//

import UIKit
class StrainSlider:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    static var sm = StrainManager()
//    var ldata = sm.fetchStrainByName(name: "Jack Herer")
    var data = [
    
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
    
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Sativa"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Indica"),
        TempStrain(id: 1804, name: "Jack Herer", race: "Hybrid"),
    
    ]
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height:120)//controlls size of cells in cv
    }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count //Controlls number of cells in collection view
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//Controlls appearance and content within CV cell
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StrainCell
        cell.backgroundColor = .white
        
        K.shared.addTextFieldStyle(tf: cell)
        
        cell.setStrainName(name: data[indexPath.row].name!)
        cell.setStrainRace(race: data[indexPath.row].race!)
         return cell
     }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if HomeViewController.isFPCHidden{
            HomeViewController.fpc.show(animated: true) { }
            HomeViewController.isFPCHidden = false
        }else{
            HomeViewController.fpc.hide(animated: true) { }
            HomeViewController.isFPCHidden = true
        }
    }
}


class StrainCell: UICollectionViewCell{
    fileprivate let img: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "leaf1-green-ui")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    fileprivate let name: UILabel = {
        let label = UILabel()
        label.text =  "Strain"
        label.textColor = K.colors.primaryUIColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont(name: ".AppleSystemUIFont", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let race: UIButton = {
        let label = UIButton()
        label.setTitle("Race", for: .normal)
        label.setTitleColor(.white, for: .normal)
        label.layer.cornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.titleLabel!.font =  UIFont(name: ".AppleSystemUIFont", size: 10)
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.addSubview(img)
        contentView.addSubview(name)
        contentView.addSubview(race)
        
        
        img.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        img.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        img.heightAnchor.constraint(equalToConstant: 60).isActive = true
        img.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        name.topAnchor.constraint(equalTo: img.bottomAnchor, constant: -3).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        race.topAnchor.constraint(equalTo: name.bottomAnchor, constant:-4).isActive = true
        race.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 40).isActive = true
        race.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -40).isActive = true
        race.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func  setStrainName(name: String){
        self.name.text = name
    }
    func  setStrainRace(race: String){
        self.race.setTitle(race.capitalized, for: .normal)
        if race == "hybrid" || race == "Hybrid"{
            self.race.backgroundColor = K.colors.hybridColor
        }else if race == "indica" || race == "Indica"{
            self.race.backgroundColor = K.colors.indicaColor
        }else if race == "sativa" || race == "Sativa"{
            self.race.backgroundColor = K.colors.sativaColor
        }
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
