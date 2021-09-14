//
//  HomeViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 7/29/21.
//

import UIKit
import FloatingPanel
class HomeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, FloatingPanelControllerDelegate {

    static var fpc = HomeViewController().amountPickerFloatingPanel()
    static var isFPCHidden:Bool = true
    var imgArr = [
        UIImage(named: "ad1"),
        UIImage(named: "ad2"),
        UIImage(named: "ad3"),
    ]


    var scrollParentContainer = UIScrollView()
    var timer = Timer()
    var counter = 0
    var pageView: UIPageControl!
    
    //Ad Slider
    fileprivate let sliderCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var cv =  UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .none
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    


    
    
    //NearMe Slider Inital Vars
    var nmHeader:UIStackView?
    var nm:NearMeSlider!
    fileprivate let nearMeLabel:UILabel = {
        var l = UILabel()
        l.text = "Near Me"
        l.textColor = .black
        l.font =  UIFont(name: ".AppleSystemUIFont", size: 20)
        return l
    }()
    fileprivate let nearMeSeeAllButton:UIButton = {
        var l = UIButton()
        l.setTitle("See All", for: .normal)
        l.setTitleColor(#colorLiteral(red: 0.3864510655, green: 0.6746277213, blue: 0.5922906399, alpha: 1), for: .normal)
        l.addTarget(self, action: #selector(dispensaryListSeeAllButtonTapped), for: .touchUpInside)
        return l
    }()
    fileprivate let nearMeCollectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .none
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SellerCell.self, forCellWithReuseIdentifier: "cell")

        return cv
    }()
    var fpc:FloatingPanelController?
    var isFPCHidden:Bool = true
    
    //Popular Strain Slider Initial Vars
    var psHeader:UIStackView?
    var ps:StrainSlider!
    fileprivate let popularStrainLabel:UILabel = {
        var l = UILabel()
        l.text = "Popular Strains"
        l.textColor = .black
        l.font =  UIFont(name: ".AppleSystemUIFont", size: 20)
        return l
    }()
    @objc func popularStrainListSeeAllButtonTapped(){
//        let nextScreen = StrainResultsViewController()
//        nextScreen.title = "Strains"
//        navigationController?.pushViewController(nextScreen, animated: true)
    }
    fileprivate let popularStrainSeeAllButton:UIButton = {
        var l = UIButton()
        l.setTitle("See All", for: .normal)
        l.setTitleColor(#colorLiteral(red: 0.3864510655, green: 0.6746277213, blue: 0.5922906399, alpha: 1), for: .normal)
        l.addTarget(self, action: #selector(popularStrainListSeeAllButtonTapped), for: .touchUpInside)
        return l
    }()
    
    fileprivate let popularStrainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .none
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(StrainCell.self, forCellWithReuseIdentifier: "cell")
        

        return cv
    }()
    var sm = StrainManager()
    
    
    
    
    
    
    
    
    
    //All dispensary list header
    var dlHeader:UIStackView?
    var dl:DispensaryList!
    fileprivate let dispensaryListLabel:UILabel = {
        var l = UILabel()
        l.text = "All Dispensaries"
        l.textColor = .black
        l.font =  UIFont(name: ".AppleSystemUIFont", size: 20)
        return l
    }()
    @objc func dispensaryListSeeAllButtonTapped(){
//        let nextScreen = DispensaryResultsViewController()
//        nextScreen.title = "Home"
//        navigationController?.pushViewController(nextScreen, animated: true)
    }
    fileprivate let dispensaryListSeeAllButton:UIButton = {
        var l = UIButton()
        l.setTitle("See All", for: .normal)
        l.addTarget(self, action: #selector(dispensaryListSeeAllButtonTapped), for: .touchUpInside)
        l.setTitleColor(#colorLiteral(red: 0.3864510655, green: 0.6746277213, blue: 0.5922906399, alpha: 1), for: .normal)
        return l
    }()
    fileprivate let dispensaryListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .none
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.register(DispensaryListCell.self, forCellWithReuseIdentifier: "cell")
        

        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let nextScreen = DispensaryProfileViewController()
//        nextScreen.title = "Dispensary Profile"
//        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    static var fcvc = FilterSlider()
    var filterCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
        layout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      
       collectionView.setCollectionViewLayout(layout, animated: true)
       collectionView.showsVerticalScrollIndicator = false
       collectionView.showsHorizontalScrollIndicator = false
       collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate =  fcvc
       collectionView.dataSource = fcvc
       collectionView.register(FilterCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var netMan = NetworkManager()
//        netMan.auth()
//
        
        
        fpc = amountPickerFloatingPanel()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Home"
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = K.colors.screenBGColor
        
        
        scrollParentContainer.backgroundColor = K.colors.screenBGColor
        view.addSubview(scrollParentContainer)
        scrollViewConfig(scrollView: scrollParentContainer, contentSize: CGSize(width: view.bounds.width, height: 1700))
       
        //Ad Slider config and stuff
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        scrollParentContainer.addSubview(sliderCollectionView)
        sliderCollectionViewConfig()
        
        //Page Control stuff
        pageView = UIPageControl()
        scrollParentContainer.addSubview(pageView)
        pageControlConfig()
        
        //Filters Slider config
//        var fcvc = FilterSlider()
//        filterCollectionView = fcvc.view! as! UICollectionView
//        let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
//        layout.scrollDirection = .horizontal
//
//
//
//        filterCollectionView.setCollectionViewLayout(layout, animated: true)
//        filterCollectionView.reloadData()
        scrollParentContainer.addSubview(filterCollectionView)
        filterConfig()
        
//
        //Near by label and button config
        nmHeader = UIStackView(arrangedSubviews: [nearMeLabel,nearMeSeeAllButton])
        nmHeader!.axis = .horizontal
        scrollParentContainer.addSubview(nmHeader!)
        nmHeaderConfig()
        
        //Near Me Slider
        nm = NearMeSlider()
        nearMeCollectionView.delegate = nm
        nearMeCollectionView.dataSource = nm
   
        scrollParentContainer.addSubview(nearMeCollectionView)
        nearMeSliderConfig()

        
        //Strain Slider Header
        psHeader = UIStackView(arrangedSubviews: [popularStrainLabel,popularStrainSeeAllButton])
        psHeader!.axis = .horizontal
        scrollParentContainer.addSubview(psHeader!)
        psHeaderConfig()
        
        //Strain Slider
        ps = StrainSlider()
        popularStrainCollectionView.delegate = ps
        popularStrainCollectionView.dataSource = ps
        scrollParentContainer.addSubview(popularStrainCollectionView)
        popularStrainSliderConfig()
        
        //All Dispensary List Header
        dlHeader = UIStackView(arrangedSubviews: [dispensaryListLabel,dispensaryListSeeAllButton])
        dlHeader!.axis = .horizontal
        scrollParentContainer.addSubview(dlHeader!)
        dlHeaderConfig()
        
        //All Dispensary List
        dl = DispensaryList()
        dispensaryListCollectionView.delegate = dl
        dispensaryListCollectionView.dataSource = dl
        scrollParentContainer.addSubview(dispensaryListCollectionView)
        dispensaryListConfig()
        
        view.addSubview(fpc!.view)
        fpc!.hide(animated: true) { }
        
        
    }
    
    func amountPickerFloatingPanel() -> FloatingPanelController{
        let fpc = FloatingPanelController()
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        fpc.surfaceView.grabberHandle.isHidden = true
  
        
        
//        fpc.surfaceView.grabberHandle.isHidden = true
//         Set a content view controller.
        let contentVC = AmountPickerPanelViewController()
        fpc.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
//        fpc.track(scrollView: contentVC.tableView)


        
        
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self)
//        fpc.surfaceView.grabberHandle.isHidden = true
//        fpc.surfaceView.backgroundColor = .none
//        fpc.surfaceView.backgroundColor = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        
        return fpc
    }
    
    
    //MARK: - Constraints and Config Functions
    func scrollViewConfig(scrollView: UIScrollView, contentSize: CGSize){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        scrollParentContainer.contentSize = preferredContentSize
        scrollView.contentSize = contentSize
    }
    func sliderCollectionViewConfig(){
        sliderCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        sliderCollectionView.translatesAutoresizingMaskIntoConstraints = false
        sliderCollectionView.layer.cornerRadius = 15
//        sliderCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive =  true
        sliderCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        sliderCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive =  true
        sliderCollectionView.heightAnchor.constraint(equalToConstant: 170).isActive =  true
        sliderCollectionView.isPagingEnabled = true
    }
    func pageControlConfig(){
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        pageView.translatesAutoresizingMaskIntoConstraints = false
//        pageView?.centerYAnchor.constraint(equalTo: sliderCollectionView!.centerYAnchor, constant: 50)
        pageView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive =  true
        pageView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive =  true
        pageView? .bottomAnchor.constraint(equalTo: sliderCollectionView.bottomAnchor, constant: -10).isActive =  true
        pageView?.heightAnchor.constraint(equalToConstant: 20).isActive =  true
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    func filterConfig(){
        filterCollectionView.backgroundColor = .none
        filterCollectionView.topAnchor.constraint(equalTo: pageView!.topAnchor, constant: 40).isActive = true
        filterCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 5).isActive =  true
        filterCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive =  true
        filterCollectionView.heightAnchor.constraint(equalToConstant: 30).isActive =  true
    }
    func nmHeaderConfig(){
        nmHeader!.translatesAutoresizingMaskIntoConstraints = false
        nmHeader!.topAnchor.constraint(equalTo: filterCollectionView.topAnchor, constant: 40).isActive = true
//        nmHeader!.topAnchor.constraint(equalTo: sliderCollectionView.topAnchor, constant: 40).isActive = true
        nmHeader!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        nmHeader!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive =  true
        nmHeader!.heightAnchor.constraint(equalToConstant: 30).isActive =  true
    }
    func nearMeSliderConfig(){
        nearMeCollectionView.topAnchor.constraint(equalTo: nmHeader!.topAnchor, constant: 30).isActive = true
        nearMeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        nearMeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive =  true
        nearMeCollectionView.heightAnchor.constraint(equalToConstant: 210).isActive =  true
    }
    func psHeaderConfig(){
        psHeader!.translatesAutoresizingMaskIntoConstraints = false
        psHeader!.topAnchor.constraint(equalTo: nearMeCollectionView.bottomAnchor, constant: 5).isActive = true
        psHeader!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        psHeader!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive =  true
        psHeader!.heightAnchor.constraint(equalToConstant: 30).isActive =  true
    }
    func popularStrainSliderConfig(){
        popularStrainCollectionView.topAnchor.constraint(equalTo: psHeader!.topAnchor, constant: 40).isActive = true
        popularStrainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        popularStrainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive =  true
        popularStrainCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive =  true
        
    }
    func dlHeaderConfig(){
        dlHeader!.translatesAutoresizingMaskIntoConstraints = false
        dlHeader!.topAnchor.constraint(equalTo: popularStrainCollectionView.bottomAnchor, constant: 10).isActive = true
        dlHeader!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        dlHeader!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive =  true
        dlHeader!.heightAnchor.constraint(equalToConstant: 30).isActive =  true
    }
    func dispensaryListConfig(){
        dispensaryListCollectionView.topAnchor.constraint(equalTo: dlHeader!.topAnchor, constant: 40).isActive = true
        dispensaryListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive =  true
        dispensaryListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive =  true
        dispensaryListCollectionView.heightAnchor.constraint(equalToConstant: 1000).isActive =  true
    }
    
    //Other
    @objc func changeImage() {
        if counter < imgArr.count {
             let index = IndexPath.init(item: counter, section: 0)
             self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             pageView.currentPage = counter
             counter += 1
        } else {
             counter = 0
             let index = IndexPath.init(item: counter, section: 0)
             self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             pageView.currentPage = counter
             counter = 1
        }
    }
    
    
    
    
    
    //FLow Layout Delegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollectionView.frame.size.width, height: sliderCollectionView.frame.size.height)//controlls size of cells in cv
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    

    
    
    
    //CollectionView Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
        var iv = UIImageView()
        iv.image = imgArr[indexPath.row]
        iv.contentMode = .scaleAspectFill
        cell.addSubview(iv)
        cell.backgroundColor = .darkGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        iv.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        iv.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        iv.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        cell.layer.cornerRadius = 15
        return cell
    }
    
    
    
    
}
