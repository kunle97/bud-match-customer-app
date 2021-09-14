//
//  OrderViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/28/21.
//

import UIKit
import SwiftyJSON
import MapKit
import FloatingPanel
class TrackOrderViewController: UIViewController ,FloatingPanelControllerDelegate{

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
//    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var map: MKMapView!
//    @IBOutlet weak var statusLabel: UILabel!
    
    var jar = [JSON]()
    
//    var destination: MKPlacemark?
//    var source:MKPlacemark?
    
    
    var driverPin: MKPointAnnotation!
    var destinationPin: MKPointAnnotation!
    var timer = Timer()
    
    
    var locationManager:CLLocationManager!
    
    var fpc: FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helpers.addLogoToNavgation(view: self)
        getLatestOrder()
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        map.delegate = self
        // Do any additional setup after loading the view.
        
        
        
        addFloatingPanel(view: self)
        
    }
    
    
    func addFloatingPanel(view:UIViewController){
        

        fpc = FloatingPanelController()

        // Assign self as the delegate of the controller.
        fpc.delegate = view as! FloatingPanelControllerDelegate // Optional

        // Set a content view controller.
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpc_content") as? TrackOrderContentViewController else{
            return
        }
        
        fpc.set(contentViewController: contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
//        fpc.track(scrollView: contentVC.tableView)

        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self)
    }
    
    func showNoActiveOrderView(){
        //If Customer has no active order
//        self.map.isHidden = true
//        self.orderTableView.isHidden = true
//        self.statusLabel.isHidden = true
        
        let noActiveOrderLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        noActiveOrderLabel.center =  self.view.center
        noActiveOrderLabel.textAlignment = NSTextAlignment.center
        noActiveOrderLabel.text = "You do not have an active order."
        self.view.addSubview(noActiveOrderLabel)
    }
    func showActiveOrderView(){
//        self.map.isHidden = false
//        self.orderTableView.isHidden = false
//        self.statusLabel.isHidden = false
    }
//    
    func getCoordinatesFromStringAddress(address:String){
        var locationCoords = CLLocationCoordinate2D()
        var returnLocation = CLLocation()
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [self] (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
            else{
                print("No Location Found")
                return
            }
            print("Address: \(location)")
            locationCoords = location.coordinate
            self.destinationPin = MKPointAnnotation()
            self.destinationPin.coordinate = locationCoords
            self.destinationPin.title = "Destination Pin"
            self.map.addAnnotation(self.destinationPin)

            
        }
    }
    
    func getLatestOrder(){
        APIManager.shared.getLatestOrder{ [self](json) in
            let order = json["order"]
            let deliveryAddress = order["address"].string!
            let driverCoords = order["driver"]
            
            
            if order["dispensary"]["name"].string! == ""  {
                self.showNoActiveOrderView()
            } else if order["status"] != nil || order["status"].string! != "Delivered"{
                self.showActiveOrderView()
                
                if let orderDetails = order["order_details"].array{
//                    self.statusLabel.text = order["status"].string!
//                    self.jar = orderDetails
//                    self.orderTableView.reloadData()
                    print(self.jar)
                }
                
                getCoordinatesFromStringAddress(address: deliveryAddress)


                
                
                //TODO: Create Reigon for the map so that theuser doesnt have to zoom in every time
                if order["status"] != "Delivered" && order["status"] == "On The Way" {
                    self.setTimer()                
                }
            }

            
        }
    }
    
    @objc func getDriverLocation(_ sender: AnyObject) {
        APIManager.shared.getDriverLocation { (json) in
            
            if let location = json["location"].string {
                
//                self.statusLabel.text = "ON THE WAY"
                
                let split = location.components(separatedBy: ",")
                let lat = split[0]
                let lng = split[1]
                
                let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat)!, longitude: CLLocationDegrees(lng)!)
                
                // Create pin annotation for Driver
                if self.driverPin != nil {
                    self.driverPin.coordinate = coordinate
                } else {
                    self.driverPin = MKPointAnnotation()
                    self.driverPin.coordinate = coordinate
                    self.driverPin.title = "Driver"
                    self.map.addAnnotation(self.driverPin)
                }
                let region = self.map.regionThatFits(MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400))
                self.map.setRegion(region, animated: true)
                
                // Reset zoom rect to cover 3 locations
//                self.autoZoom()
                
            } else {
                self.timer.invalidate()
            }
        }
    }

    
    func setTimer(){
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(getDriverLocation(_:)),
            userInfo: nil, repeats: true)
    }
    

    
    
}

extension TrackOrderViewController: MKMapViewDelegate{
    


}

extension TrackOrderViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell",for: indexPath) as! OrderViewCell
        
        let item = jar[indexPath.row]
        
        cell.qtyLabel.text = String(item["quantity"].int!)
        cell.strainNameLabel.text = item["strain"]["name"].string!
        cell.strainSubtotalLabel.text = "$\(String(item["subtotal"].float!))"
        return cell
    }
}
