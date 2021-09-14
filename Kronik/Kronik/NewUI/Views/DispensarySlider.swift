//
//  NearMeSlider.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/10/20.
//

import UIKit


class DispensarySlider:UICollectionViewController,UICollectionViewDelegateFlowLayout{
   
    var data = [
        Seller(title: "Greenleaf Compassion Center",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.20540453312603, latitude: 40.81527731188963 ),
        Seller(title: "Alternative Weed Therapy",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.26230337986313, latitude: 40.79925917210424),
        Seller(title: "Elm Park Village",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude:  -74.20531180487427 , latitude:  40.77794423627538),
        
        Seller(title: "Newstead North",tags: ["Free Delivery $50","5-10 min", "Organic"], image: #imageLiteral(resourceName: "dispensary6"),longitude: -74.29579791756386, latitude: 40.762343607328845),
    ]
    
    let flowLayout = UICollectionViewFlowLayout()
    var headerStack:UIStackView?
    var dispoSlider: UICollectionView?
    let headerLabel:UILabel = {
        var l = UILabel()
        l.text = "Change Me"
        l.textColor = .black
        l.font =  UIFont(name: ".AppleSystemUIFont", size: 20)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    @objc func action(destination:UIViewController, title:String, navigationController:UINavigationController){
        let nextScreen = destination
        nextScreen.title = title
        navigationController.pushViewController(nextScreen, animated: true)
    }
    fileprivate let headerButton:UIButton = {
        var l = UIButton()
        l.setTitle("See All", for: .normal)
        l.setTitleColor(#colorLiteral(red: 0.3864510655, green: 0.6746277213, blue: 0.5922906399, alpha: 1), for: .normal)
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.addTarget(self, action: #selector(dispensaryListSeeAllButtonTapped), for: .touchUpInside)
        return l
    }()
    
    func getHeader() -> UIStackView{ // Returns the header of the Dispensary Slider so that it can be accessed

        return headerStack!
    }
    func getDispoSlider() -> UICollectionView{
        return dispoSlider!
    }
    
//    func headerButtonTarget( ){
//        headerButton.addTarget(self, action: #selector(action), for: .touchUpInside)
//    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        headerStack = UIStackView(arrangedSubviews: [self.headerLabel,self.headerButton])
        headerStack!.axis = .horizontal
        
        dispoSlider =  {
            let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
            layout.scrollDirection = .horizontal
            
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.collectionViewLayout = layout
            cv.frame = .zero
            cv.backgroundColor = .none
            cv.showsVerticalScrollIndicator = false
            cv.showsHorizontalScrollIndicator = false
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(SellerCell.self, forCellWithReuseIdentifier: "cell")

            return cv
        }()
        
        dispoSlider!.delegate = self
        dispoSlider!.dataSource  = self
    }
    init(headerTitle: String) {
        self.headerLabel.text = headerTitle
        headerStack = UIStackView(arrangedSubviews: [self.headerLabel,self.headerButton])
        headerStack!.axis = .horizontal

        super.init()
        dispoSlider =  {
            let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.collectionViewLayout = layout
            cv.frame = .zero
            cv.backgroundColor = .none
            cv.showsVerticalScrollIndicator = false
            cv.showsHorizontalScrollIndicator = false
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(SellerCell.self, forCellWithReuseIdentifier: "cell")

            return cv
        }()
        dispoSlider!.delegate = self
        dispoSlider!.dataSource  = self
    }
    
    func setDispoSLiderDelegateAndDataSource(){
        dispoSlider!.delegate = self
        dispoSlider!.dataSource  = self
    }
    init(data:[Seller], headerTitle:String ) {
        self.data = data
        self.headerLabel.text = headerTitle
        headerStack = UIStackView(arrangedSubviews: [self.headerLabel,self.headerButton])
        headerStack!.axis = .horizontal

        super.init()
        dispoSlider =  {
            let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.collectionViewLayout = layout
            cv.frame = .zero
            cv.backgroundColor = .none
            cv.showsVerticalScrollIndicator = false
            cv.showsHorizontalScrollIndicator = false
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(SellerCell.self, forCellWithReuseIdentifier: "cell")

            return cv
        }()
        dispoSlider!.delegate = self
        dispoSlider!.dataSource  = self


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    //MARK: - Contraints
    func headerConstraintsConfig(topView:UIView, parentView:UIView){
        headerStack!.translatesAutoresizingMaskIntoConstraints = false
        headerStack!.topAnchor.constraint(equalTo: topView.topAnchor, constant: 40).isActive = true
        headerStack!.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        headerStack!.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive =  true
        headerStack!.heightAnchor.constraint(equalToConstant: 30).isActive =  true
    }
    func sliderContraintsConfig(parentView:UIView){
        dispoSlider!.topAnchor.constraint(equalTo: headerStack!.topAnchor, constant: 30).isActive = true
        dispoSlider!.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        dispoSlider!.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor).isActive =  true
        dispoSlider!.heightAnchor.constraint(equalToConstant: 210).isActive =  true
    }

    

    
//    var data:[Seller]()
}
extension DispensarySlider{
    //MARK: - Collection View Delecgate/Data Source functions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width*0.8, height: collectionView.frame.size.height*0.9)//controlls size of cells in cv
    }
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count //Controlls number of cells in collection view
     }
     
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//Controlls appearance
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SellerCell
        cell.backgroundColor = .white
        cell.setSellerName(name: self.data[indexPath.row].title!)
        cell.setSellerTags(tags: self.data[indexPath.row].tags!)
        K.shared.addTextFieldStyle(tf: cell)

        return cell
     }
     
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You chose the dispensary: \(self.data[indexPath.row].title)")

     }
}

class SellerCell: UICollectionViewCell{
    
    static let identifier = "SellerCell"
    
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
        label.font =  UIFont(name: ".AppleSystemUIFont", size: 20)
        return label
    }()
    
    fileprivate let tags: UILabel = {
        let label = UILabel()
        label.text =  " "
        label.textColor = K.colors.grayUIColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont(name: ".AppleSystemUIFont", size: 12)
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
        
        name.topAnchor.constraint(equalTo: img.topAnchor, constant: 135).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tags.topAnchor.constraint(equalTo: name.topAnchor, constant: 25).isActive = true
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
