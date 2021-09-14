//
//  SearchViewController.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/2/20.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation
class SearchViewController: UIViewController, FloatingPanelControllerDelegate, UITextFieldDelegate,CLLocationManagerDelegate  {
    let lm =  CLLocationManager()
    var mkv  = MKMapView()

    //Array containing Random coordinates and location titles (Should contain dispensaries nearby user)
    var places = [
        ["title": "Greenleaf Compassion Center","latitude": 40.81527731188963, "longitude": -74.20540453312603 ],//
        ["title": "Alternative Weed Therapy","latitude": 40.79925917210424, "longitude": -74.26230337986313 ],//
        ["title": "Elm Park Village","latitude": 40.77794423627538, "longitude": -74.20531180487427 ],//
        ["title": "Newstead North","latitude": 40.762343607328845, "longitude": -74.25337698859981],//
        
        ["title": "Garden State Dispensary - Union","latitude": 40.69413342212082, "longitude":-74.29579791756386],//
        ["title": "Harmony Dispensary","latitude": 40.77327356231169, "longitude":-74.08249742618894],//
        ["title": "Garden State Dispensary - Woodbridge","latitude": 40.57459107172388, "longitude": -74.29389803332703],//
        ["title": "Greenleaf Compassion Center","latitude": 40.81422214315388, "longitude":-74.21529997930737],//
        ["title": "Zen Leaf - Elizabeth","latitude": 40.684319207957635, "longitude":-74.21403944294198],//
        ["title": "Get Pot Marijuana Dispensary and Collective","latitude": 40.442046014529716, "longitude": -74.03995473787798],//
        ["title": "Sunnyside Medical Cannabis Dispensary - Hudson Valley","latitude": 41.1375927052859 ,"longitude":-73.98729045735442],//
        ["title": "Etain Health - Medical Marijuana Dispensary Westchester","latitude": 40.948922258629636, "longitude": -73.90097955316304],//
        
        
        
        ["title": "Columbia Care Manhattan Dispensary","latitude": 40.73971618924034, "longitude": -73.9800920823447],//
    ]
    
    //Specify reigon and zoom level
    
    //Specify start location
    //let reigonCenter = CLLocation(latitude: 39.818249, longitude: -86.152995)
    
    //Distance measured in meters
    let distancSpan: CLLocationDistance = 17500
    
    func zoomLevel(location: CLLocation){
        //Create new reigon for zoom level
        let mapCoordinates = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distancSpan, longitudinalMeters: distancSpan)
        
        //Set new reigon
        mkv.setRegion(mapCoordinates, animated: true)
    }

    
    //Function places annotations on the mapkitview
    func createAnnotations(locations: [[String : Any]]){
        for location in locations {
            let annotations  = MKPointAnnotation()
            annotations.title = location["title"] as! String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees )
            mkv.addAnnotation(annotations)
        }
    }
    
    
    var nm:ResultsSlider!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    private let searchBar:CustomTextField = {
        var tf = CustomTextField()
        tf.placeholder = "Search"
        K.shared.addTextFieldStyle(tf: tf)
        return tf
    }()
    
    
    fileprivate let nearMeCollectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout() //Organizes  your colelction view into a grid more or less
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .none
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SellerResultsCell.self, forCellWithReuseIdentifier: "cell")

        return cv
    }()
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        var fpc = floatingPanel()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.isNavigationBarHidden = true
        navigationItem.title = "Search"
        
        
        //Location Manager configuration
        lm.requestWhenInUseAuthorization()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.distanceFilter = kCLDistanceFilterNone
        lm.startUpdatingLocation()
        mkv.showsUserLocation = true
        
        
//        let anotation = MKPointAnnotation()
//        anotation.coordinate = CLLocationCoordinate2D(latitude: 38.8977, longitude: 77.0365)
//        mkv.addAnnotation(anotation)
        
//        zoomLevel(location: reigonCenter)//Add specified zoom level
        createAnnotations(locations: places)//Add Annotations from places array to the mapp
        
        //Add Mapp View, Searchbar and Results slider to the screen
        view.addSubview(mkv)
        view.addSubview(searchBar)
        view.addSubview(fpc)
        
        //Configure Map Kit View Constraints
        mkv.translatesAutoresizingMaskIntoConstraints = false
        mkv.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mkv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mkv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mkv.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Do any additional setup after loading the view.
        mkv.bringSubviewToFront(searchBar)
        mkv.bringSubviewToFront(fpc)
        
        //Set up search bar constraints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 10 ).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    //Use location manager dleegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        zoomLevel(location: CLLocation(latitude: locValue.latitude, longitude: locValue.longitude))
    }
    func createAnotation(){

    }
    func nearMeSliderConfig(){

    }
    func floatingPanel() -> UIView{
       var fpc = FloatingPanelController()
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        
        nm = ResultsSlider()
        nearMeCollectionView.delegate = nm
        nearMeCollectionView.dataSource = nm
        fpc.surfaceView.addSubview(nearMeCollectionView)
        
        nearMeCollectionView.topAnchor.constraint(equalTo: fpc.surfaceView.topAnchor, constant: 10).isActive = true
        nearMeCollectionView.leadingAnchor.constraint(equalTo: fpc.surfaceView.leadingAnchor).isActive =  true
        nearMeCollectionView.trailingAnchor.constraint(equalTo: fpc.surfaceView.trailingAnchor).isActive =  true
        nearMeCollectionView.heightAnchor.constraint(equalToConstant: 240).isActive =  true
        
        
        nearMeSliderConfig()
        
        
        
//        fpc.surfaceView.grabberHandle.isHidden = true
        // Set a content view controller.
//        let contentVC = ResultsPanelViewController()
//        fpc.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
//        fpc.track(scrollView: contentVC.tableView)


        
        
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self)
        fpc.surfaceView.grabberHandle.isHidden = true
        fpc.surfaceView.backgroundColor = .none
//        fpc.surfaceView.backgroundColor = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        
        return fpc.view
    }
    

    
}
    

class CustomTextField: UITextField, UITextFieldDelegate {

    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}





