//
//  DispensaryMapVIew.swift
//  Kronik
//
//  Created by Kunle Ademefun on 9/18/21.
//

import UIKit
import MapKit
class DispensaryMapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var dispensaries = [Dispensary]()
    var filterDiespensaries = [Dispensary]()
    
    let activityIndicator = UIActivityIndicatorView()
    let zoomModeUser = true
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Helpers.addLogoToNavgation(view: self)
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
        loadDisensaries()
    }

    func loadDisensaries(){
        
        Helpers.showActivityIndicator(activityIndicator,self.view)
        APIManager.shared.getDispensaries{ (json) in
//            print("JSON = \(json["dispensarys"].array)")
            if json != nil{
                self.dispensaries = []
                if let listDis = json["dispensarys"].array{
                    for item in listDis{
                        let dispensary = Dispensary(json: item)
                        self.dispensaries.append(dispensary)
                        self.getLocation(dispensary.address!, dispensary.name!) { (placemarks) in
                            
                        }
                    }
                    self.zoomCoords(dispensaries: self.dispensaries)
                    Helpers.hideActivityIndicator(self.activityIndicator)
                }
            }else{ print("JSON = Nil") }
        }
        
       zoom()
        
    }
    func zoomCoords(dispensaries: [Dispensary]){
        var maxLat = -200.0
        var maxLong = -200.0
        var minLat = 100000.0
        var minLong = 100000.0
        var coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
        for dispensary in dispensaries{
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(dispensary.address!) { (placemarks, error) in
                if error != nil{
                    print("Error: ", error)
                }
                if let placemark = placemarks?.first{
                  coordinates = placemark.location!.coordinate
                
                }
            }
            
            
            var location = CLLocationCoordinate2D(latitude:coordinates.latitude , longitude: coordinates.latitude)

            if (location.latitude < minLat) {
                minLat = location.latitude
            }

            if (location.longitude < minLong) {
                minLong = location.longitude
            }

            if (location.latitude > maxLat) {
                maxLat = location.latitude
            }

            if (location.longitude > maxLong) {
                maxLong = location.longitude
            }
        }

    }
    func zoom(){
        let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)

        if zoomModeUser{
            //Zoom to user location
            if let userLocation = locationManager.location?.coordinate {
                let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 70000, longitudinalMeters: 70000)
                map.setRegion(viewRegion, animated: false)
            }
        }else{
            guard let initial = map.overlays.first?.boundingMapRect else { return }

              let mapRect = map.overlays
                  .dropFirst()
                  .reduce(initial) { $0.union($1.boundingMapRect) }

              map.setVisibleMapRect(mapRect, edgePadding: insets, animated: true)
        }
    }
    
    //MARK: - MAPVIEW FUNCTION

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
//            self.mapView(mapView: self.map, viewForAnnotation: dispoAnno).annotation = dispoAnno
            
            self.map.addAnnotation(dispoAnno)
            
            
//            self.map.addOverlay(route.polyline)//add the direcgtions graphic to the actuall mapview
//            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)//Make the overlay visible
        }
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
//                self.mapView(mapView: self.map, viewForAnnotation: dropPin).annotation = dropPin
                self.map.addAnnotation(dropPin)
                MKPlacemark.init(placemark: placemark)
            }
        }
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }

        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKAnnotationView
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = false
                print("Pin View Is nil")
            }else {
                pinView!.annotation = annotation
                print("Pin View Is not nil")
            }
        
            pinView!.image = UIImage(named: "dispensary-drop-pin")!
  
        
            return pinView!
    }
    
    
    
}
