//
//  DeliveryViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/12/21.
//

import UIKit
import MapKit
class DeliveryViewController: UIViewController {
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var customerAddressLabel: UILabel!
    @IBOutlet weak var customerImage: UIImageView!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var customerInfoView: UIView!
    @IBOutlet weak var completeOrderButton: UIButton!
    
    var orderId: Int?
    
    var destination: MKPlacemark?
    var source: MKPlacemark?
    
    var locationManager:CLLocationManager!
    var driverPin: MKPointAnnotation!
    var lastLocation: CLLocationCoordinate2D!
    
    var isRoutingDispo = false //Variable that controlls if the map gets directions to either the dispensary or the customer
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        menuBarButton.target = self.revealViewController()
        menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //Show user current location
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            self.map.showsUserLocation = true
        }
        map.delegate = self
        getDispoDirections()
        
        //Running the updating location process
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLocation(_:)), userInfo: nil, repeats: true)
        
    }
    
    func getDispoDirections(){
        APIManager.shared.getCurrentDriverOrder { [self] (json) in
           
           let order = json["order"]
            self.getAddress(address: order["dispensary"]["address"].string!, addressTitle: order["dispensary"]["name"].string!)
        }
    }
    
    func getCustomerDirections(){
        APIManager.shared.getCurrentDriverOrder { [self] (json) in
           
           let order = json["order"]
            self.getAddress(address: order["address"].string!, addressTitle: order["customer"]["name"].string!)
        }
    }
    
    func mapThis(destinationCoord: CLLocationCoordinate2D, destAnnotationTitle:String){
        //1.
        let sourceCoordinate = locationManager.location?.coordinate
        
        //2. Create Placemark for source and destination
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate!)
        let destPlaceMark = MKPlacemark(coordinate: destinationCoord)
        
        //3. Create Map item for source and destiations
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        //4. Create a Directions request so that apple know you are preparing to get the direction
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType =  .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        //5. Calculate the direction
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response =  response else{
                if let error = error{
                    print("somthing is wrong")
                }
                return
            }
            let route = response.routes[0]//Retrive the first route
                
            // Add a droppin/annotation that shows the dispensary
            let dispoAnno = MKPointAnnotation()
            dispoAnno.coordinate = destinationCoord
            dispoAnno.title = destAnnotationTitle
            self.map.addAnnotation(dispoAnno)
            
            
            self.map.addOverlay(route.polyline)//add the direcgtions graphic to the actuall mapview
            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)//Make the overlay visible
        }
        
    }
    
    @IBAction func changeDirectionPressed(_ sender: Any) {
        //A function that toggles the route for the driver to the dispensary or to te customer
        map.removeAnnotations(map.annotations)
        map.removeOverlays(map.overlays)
        if isRoutingDispo {
            isRoutingDispo = false
            getDispoDirections()
        }else{
            isRoutingDispo = true
            getCustomerDirections()
        }
        
    }
    @IBAction func completeOrder(_ sender: Any) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in

            APIManager.shared.compeleteOrder(orderId: self.orderId!, completionHandler: { (json) in

                if json != nil {
                    // Stop updating driver location
                    self.timer.invalidate()
                    self.locationManager.stopUpdatingLocation()

                    // Redirect driver to the Ready Orders View
                    self.performSegue(withIdentifier: "ViewOrders", sender: self)
                }
            })
        }

        let alertView = UIAlertController(title: "Complete Order", message: "Are you sure you want to complete this order? Incomplete orders may result in an immediate ban for your driver account.", preferredStyle: .alert)
        alertView.addAction(cancelAction)
        alertView.addAction(okAction)

        self.present(alertView, animated: true, completion: nil)
        
    }
    @objc func updateLocation(_ sender: AnyObject){
        APIManager.shared.updateLocation(location: self.lastLocation) { (json) in
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()

    }
    
    func getAddress(address:String, addressTitle:String){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) {(placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
            else{
                print("No Location Found")
                return
            }
            print("Get Address for location: \(location)")
            self.mapThis(destinationCoord: location.coordinate, destAnnotationTitle: addressTitle)
        }
        
    }
    
    func loadData(){
        APIManager.shared.getCurrentDriverOrder { (json) in
           
           let order = json["order"]
            if let id = order["id"].int, order["status"] == "On The Way"{
                
                self.orderId = id
                
                let from = order["address"].string!
                print("From: \(from)")
                let to = order["dispensary"]["address"].string!
                print("To: \(to)")
                let customerName =  order["customer"]["name"].string!
                let customerAvatar = order["customer"]["avatar"].string!
                
                self.customerNameLabel.text = customerName
                self.customerAddressLabel.text = from
//                self.customerImage.image = try! UIImage(data: Data(contentsOf: URL(string: customerAvatar)!))
  

                
            }else{
                //If driver has no active order
                self.map.isHidden = true
                self.customerInfoView.isHidden = true
                self.completeOrderButton.isHidden = true
                
                let noActiveOrderLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
                noActiveOrderLabel.center =  self.view.center
                noActiveOrderLabel.textAlignment = NSTextAlignment.center
                noActiveOrderLabel.text = "You have not selected an order to complete yet"
                self.view.addSubview(noActiveOrderLabel)
                
            }
        }
    }
    
}

extension DeliveryViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//OLD CODE:
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
//        renderer.lineWidth = 5.0

        return renderer
    }
    
    
    //Convert Address string to map location
    func getLocation(_ address: String, _ title: String, completionHandler: @escaping (MKPlacemark) -> Void){
     print("getLocation Function called")
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil{
                print("Error: ", error)
            }
            if let placemark = placemarks?.first{
                let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                
                //Create Pin
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = coordinates
                dropPin.title = title
                
                self.map.addAnnotation(dropPin)
                MKPlacemark.init(placemark: placemark)
            }
        }
        
    }


}

extension DeliveryViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let location = locations.last! as CLLocation
        self.lastLocation = location.coordinate

//
//        //Create pin annotation for Driver
//        if driverPin != nil{
//            driverPin.coordinate = self.lastLocation
//        }else{
//            driverPin = MKPointAnnotation()
//            driverPin.coordinate = self.lastLocation
//            self.map.addAnnotation(driverPin)
//        }
//        //Reset zoom rect to show 3 locations
//        var zoomRect = MKMapRect.null
//        for annotation in self.map.annotations{
//            let annotationPoint = MKMapPoint(annotation.coordinate)
//            let zoomRect = MKMapRect.init(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1)
//            if zoomRect.isNull {
//                print("zoomRect is null")
//            }
//        }
//        let insetWidth = -zoomRect.size.width * 0.2
//        let insetHeight = -zoomRect.size.height * 0.2
//        zoomRect.insetBy(dx: insetWidth, dy: insetHeight)
////        zoomRect.insetBy( dx: insetWidth, dy: insetHeight)
//
//        self.map.setVisibleMapRect(zoomRect, animated: true)
    }
}
