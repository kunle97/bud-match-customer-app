//
//  JarViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/28/21.
//

import UIKit
import MapKit
import CoreLocation
import BraintreeDropIn
import Braintree
class JarViewController: UIViewController,JarAddressTableViewControllerDelegate {
    func jarAddressTableViewResponse() {
        
    }
    var jarTotal:Float?
    var deliveryFee:Float?
    var serviceFee:Float?
    var tip:Float = 2
    

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var promoTF: UITextField!
    
    @IBOutlet weak var totalPriceContainer: UIView!
    @IBOutlet weak var strainsTableView: UITableView!
    
  
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var extraFeesLabel: UILabel!//Service,Tax and Tip fees
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addPaymentButton: UIButton!
    @IBOutlet weak var currentAddressLabel: UILabel!
    @IBOutlet weak var tipContainer: UIView!
    @IBOutlet weak var addressContainer: UIView!
    
    var fullTotal:Float?
    
    var deleteAddressIndexPath: IndexPath? = nil
    var locationManager:CLLocationManager!
    
    var addressChanged:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calcPrices()
        
        Helpers.addLogoToNavgation(view: self)
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        

       
        if Jar.currentJar.items.count == 0{
            //Show NO items in jar" message
            let emptyJarLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
            emptyJarLabel.center =  self.view.center
            emptyJarLabel.textAlignment = NSTextAlignment.center
            emptyJarLabel.text = "Your Jar is Empty. Go find some bud!"
            self.view.addSubview(emptyJarLabel)
        }else{
            totalPriceContainer.isHidden = false
            strainsTableView.isHidden = false
            addressContainer.isHidden = false
            addPaymentButton.isHidden = false
            strainsTableView.isHidden = false
            tipContainer.isHidden = false
            promoTF.isHidden = false
            strainsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            strainsTableView.backgroundColor = .clear
            loadStrains()
        }
        

        //Show user current location
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
            self.mapView.showsUserLocation = true
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Jar.currentJar.addressDidChange {
            setNewAddress()
            print("viewDidAppear() new Address: \(Jar.currentJar.address!)")
        }
    }
    
    func calcPrices(){
        jarTotal = Jar.currentJar.getTotal()
        deliveryFee = 7.99
        serviceFee = jarTotal! * 0.04
        var tax = jarTotal! * 0.08875
        var extras = serviceFee! + tip + tax
        
        fullTotal = Float(jarTotal!) + Float(deliveryFee!) + Float(extras) + Float(tip)
        
        deliveryFeeLabel.text = "$\( Helpers.roundTo2(num: deliveryFee!) )"
        extraFeesLabel.text = "$\(Helpers.roundTo2(num:extras) )"
        totalPriceLabel.text = "$\(Helpers.roundTo2(num: fullTotal!))"
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCanceled == true) {
                print("CANCELED")
            } else if let result = result {
                var dataCollector = BTDataCollector()
                var devData = ""
                dataCollector.collectDeviceData { (string) in
                    devData = string
                }
               
                APIManager.shared.braintreeTest(total: Float(self.fullTotal!), nonce: result.paymentMethod!.nonce, devData: devData) { (json) in
                    if json["result"].string! == "Success"{
                      self.performSegue(withIdentifier: "ViewOrder", sender: self)
                    }else{
                        let av = Helpers.create1ButtonAlert(alertTitle: "Error", alertMessage: "There was an error processing your payment. Please re-enter your information and try again.", buttonTitle: "Ok")
                        self.present(av, animated: true, completion: nil)
                    }
                }
                // Use the BTDropInResult properties to update your UI
                // result.paymentMethodType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
               
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    @IBAction func tipChanges(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
           {
           case 0:
              tip = 2
            case 1:
               tip = 3
            case 2:
                tip = 4
           default:
               tip = 0
           }
        calcPrices()
    }
    
    @IBAction func addPaymentPressed(_ sender: Any) {
        APIManager.shared.getLatestOrder { [self] (json) in

            if json["order"]["status"]  == nil || json["order"]["status"] == "Delivered" || json["order"]["total"] == nil || json["order"]["address"] == "" {
//                stripePayment()
//                self.braintreePayment()
                if Jar.currentJar.address == nil{
                    
                    //Show alert that the field is required
                    let alertController = UIAlertController(title: "Enter Address", message: "Please select your desired address before proceeding to add a payment method", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default){ (alert) in
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
        //            self.performSegue(withIdentifier: "AddPayment", sender: self)
              
                    self.showDropIn(clientTokenOrTokenizationKey: BRAINTREE_TOKENIZATION_KEY)
                }
            }else{
                //Show appropriate error message
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
                let okAction = UIAlertAction(title: "Go To Order", style: .default) { (UIAlertAction) in
                    self.performSegue(withIdentifier: "ViewOrder", sender: self)
                }

                let alertView = UIAlertController(title: "Already Ordered?", message: "Your previous order has not been completed", preferredStyle: .alert)
                alertView.addAction(okAction)
                alertView.addAction(cancelAction)

                self.present(alertView, animated: true, completion: nil)

            }
        }
        
    
    }
    
    func loadStrains(){
        self.strainsTableView.reloadData()
        self.subtotalLabel.text = "$\(Jar.currentJar.getTotal())"
    }
    



}

extension JarViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
    }
}

extension JarViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Jar.currentJar.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JarItemCell", for: indexPath) as! JarViewCell
        
        let jar  = Jar.currentJar.items[indexPath.row]
        cell.qtyLabel.text = "\(jar.qty)"
        cell.strainNameLabel.text = jar.product.name
        cell.strainSubtotalLabel.text = "$\(jar.product.price!)"
        Helpers.loadImage(cell.jarItemImage, jar.product.image!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    //MARK: - Handle JarItem Deletion
    
   
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteAddressIndexPath = indexPath
            let jarItemToDelete = Jar.currentJar.items[indexPath.row]
            confirmDelete()
        }
    }

    func confirmDelete() {
        let alert = UIAlertController(title: "Delete Jar Item", message: "Are you sure you want to delete this item from your jar?", preferredStyle: .actionSheet)
 
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteAddress)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteAddress)

       alert.addAction(DeleteAction)
        alert.addAction(CancelAction)



        self.present(alert, animated: true, completion: nil)
    }
    
   func handleDeleteAddress(alertAction: UIAlertAction!) -> Void {
       if let indexPath = deleteAddressIndexPath {
           strainsTableView.beginUpdates()
        
        
    

//        print("Deleted ID \(addresses[indexPath.row].addressID!)")
        
        //Delete from array and tableview
        Jar.currentJar.items.remove(at: indexPath.row)
           // Note that indexPath is wrapped in an array:  [indexPath]
        strainsTableView.deleteRows(at: [indexPath], with: .automatic)
        deleteAddressIndexPath = nil
        

        
        strainsTableView.endUpdates()
       }
   }

   func cancelDeleteAddress(alertAction: UIAlertAction!) {
        deleteAddressIndexPath = nil
   }

    func setNewAddress(){
        let address:String
        //        print("Address to lookup: \(address!)")
        let geocoder = CLGeocoder()
        address = Jar.currentJar.address!
        currentAddressLabel.text = address
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error == nil{
                if let placemark = placemarks?.first{
                    let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                    let region = MKCoordinateRegion(
                        center: coordinates,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                   
                    self.mapView.setRegion(region, animated: true)
                    self.locationManager.stopUpdatingLocation()
                    
                    //Create Pin
                    let dropPin = MKPointAnnotation()
                    dropPin.coordinate = coordinates
                    self.mapView.addAnnotation(dropPin)
                    
                    Jar.currentJar.addressDidChange = false
                }
            }else{
                print("Error: ", error)
            }
        }
    }
    
    
}

extension JarViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        return true
    }
}
