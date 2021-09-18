//
//  APIManager.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/30/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation
//import Braintree

class APIManager {
    
    static let shared = APIManager()
    
    let baseURL = NSURL(string: BASE_URL)
    
    var accessToken:String? = ""
    var refreshToken = ""
    var expired = Date()
    

    
    // API to log an user out
    func logout(completionHandler: @escaping (NSError?) -> Void) {
        
        let path = "api/social/revoke-token/"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET,
            "token": self.accessToken
        ]
        
        AF.request(url!, method: .post, parameters: params, encoding: URLEncoding(), headers: nil).responseString { (response) in
            
            switch response.result {
            case .success:
                completionHandler(nil)
                break
                
            case .failure(let error):
                completionHandler(error as NSError?)
                break
            }
        }
        
        
    }
    
    
    // API to refresh the token when it's expired
    func refreshTokenIfNeed(completionHandler: @escaping () -> Void) {
    
    let path = "api/social/refresh-token/"
    let url = baseURL?.appendingPathComponent(path)
    let params: [String: Any] = [
        "access_token": self.accessToken,
        "refresh_token": self.refreshToken
    ]
    
    if (Date() > self.expired) {
        
        AF.request(url!, method: .post, parameters: params, encoding: URLEncoding(), headers: nil).responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                self.accessToken = jsonData["access_token"].string!
                self.expired = Date().addingTimeInterval(TimeInterval(jsonData["expires_in"].int!))
                completionHandler()
                break
                
            case .failure:
                break
            }
        })
    } else {
        completionHandler()
    }
}
    
    //Function that handles requests from a server
    func requestServer(_ method: Alamofire.HTTPMethod, _ path:String, _ params: [String: Any],_ encoding: ParameterEncoding, _ completionHandler: @escaping(JSON) -> Void)  {
        let url = baseURL!.appendingPathComponent(path)
//        var responseData:Any = []
//        let data  =  Data(base64Encoded: "")!
//        var responseDataJSON:JSON = JSON(data: data)
//        refreshTokenIfNeed {
            
        AF.request(url!, method: method, parameters: params, encoding: encoding, headers: nil).responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
//                    responseData = jsonData.arrayValue
//                    responseDataJSON = jsonData
                    completionHandler(jsonData)
//                    print(jsonData)
                    break
                    
                case .failure:
                    completionHandler(["error comp"])
                    print(response)
                    break
                }
            })
        //}
//        return responseData as! [Any]
    }
    
    // API - Getting DISPENSARary list
    func getDispensaries(completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/dispensaries/"
        let url = baseURL!.appendingPathComponent(path)
        accessToken = User.currentUser.accessToken
        requestServer(.get, path, ["access_token":accessToken!], URLEncoding(),  completionHandler)
    }
    
    //API Get all Strains for specific dispensary
    func getStrains(dispensaryId: Int, completionHandler: @escaping(JSON) -> Void) {
        let path = "api/customer/strains/\(dispensaryId)"
        let data = requestServer(.get, path, ["":""], URLEncoding(),  completionHandler)

    }
    
    func getProducts(dispensaryId: Int, completionHandler: @escaping(JSON) -> Void) {
        let path = "api/customer/products/\(dispensaryId)"
        let data = requestServer(.get, path, ["":""], URLEncoding(),  completionHandler)

    }
    
    func getProductsByType(dispensaryId: Int, type:String,completionHandler: @escaping(JSON) -> Void) {
        let path = "api/customer/products/\(type)/\(dispensaryId)/"
        let data = requestServer(.get, path, ["":""], URLEncoding(),  completionHandler)

    }
    
    func getFlowers(dispensaryId: Int) -> [Strain] {
        let path = "http://budmatchapp.com/api/customer/strains/\(dispensaryId)"
        
        var strainsArr = [Strain]()
        
        
        return strainsArr
    }
    
    

    //MARK: - CUSTOMER FUNCTIONS
    // API to login an customer
    func loginCustomer(userType: String,username: String, password:String , completionHandler: @escaping (JSON) -> Void) {
        if userType == USERTYPE_CUSTOMER{
            let path = "api/customer/auth/"
            let url = baseURL!.appendingPathComponent(path)
            let params: [String: Any]? = [
                "username": username,
                "password": password,
                "user_type": userType
            ]
            
            requestServer(.post, path, params!, URLEncoding(), completionHandler)
                
        }else{
            print("Invalid usertype")
        }
    }
    
    // API to login an user
    func createCustomer(userType: String,firstName: String, lastName:String, email:String ,username: String, password:String, phone:String, completionHandler: @escaping (JSON) -> Void) {
        
        let path = "api/customer/create/"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any]? = [
            "first_name":firstName,
            "last_name":lastName,
            "email":email,
            "username": username,
            "password": password,
            "phone":phone,
            "user_type": userType,
        ]
        
        requestServer(.post, path, params!, URLEncoding(), completionHandler)
    }
    
    func usernameIsValid(username:String, completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/username/check/"
        let url = baseURL!.appendingPathComponent(path)
        let params = [
            "username":username
        ]
        
        requestServer(.get, path, params, URLEncoding(), completionHandler)
    }
    
    func emailIsValid(email:String, completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/email/check/"
        let url = baseURL!.appendingPathComponent(path)
        let params = [
            "email":email
        ]
        
        requestServer(.get, path, params, URLEncoding(), completionHandler)
    }
    
    //API Create new order
    func createOrder(stripeToken: String, completionHandler: @escaping(JSON) -> Void ){
        let path = "api/customer/order/add/"
        let url = baseURL!.appendingPathComponent(path)
        let simpleArray = Jar.currentJar.items
        let jsonArray = simpleArray.map { item in
            return [
                "strain_id": item.strain.id,
                "quantity": item.qty,
            ]
        }
        if JSONSerialization.isValidJSONObject(jsonArray){
            do{
                let data = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
                let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
                accessToken = User.currentUser.accessToken
                let params:[String: Any] = [
                    "access_token":accessToken,
                    "stripe_token":stripeToken,
                    "dispensary_id": "\(Jar.currentJar.dispensary!.id!)",
                    "order_details": dataString,
                    "address":Jar.currentJar.address!
                ]
//                print("Params: \(params)")
//                requestServer(.post, path, params , URLEncoding(), completionHandler)
                AF.request(url!, method: .post, parameters: params, encoding: URLEncoding(), headers: nil).responseJSON(completionHandler: { (response) in
                        
                        switch response.result {
                        case .success(let value):
                            let jsonData = JSON(value)
                            completionHandler(jsonData)
                            print(jsonData)
                            break
                            
                        case .failure:
                            completionHandler(["error comp"])
                            print(response)
                            break
                        }
                    })
            }catch{
                print("JSON Serialiation Failed on some bullshit: \(error)")
            }
        }
        
    }
    
    //API- Get latest Order
    func getLatestOrder(completionHandler: @escaping (JSON) -> Void ){
        let path = "api/customer/order/latest/"
        accessToken = User.currentUser.accessToken
        let params: [String: Any] = [
            "access_token": self.accessToken!
        ]
//        print(myAccessToken!)
        requestServer(.get, path, params, URLEncoding(), completionHandler)
        
    }
    
    //API get drivet location for customer
    func getDriverLocation(completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/driver/location/"
        accessToken = User.currentUser.accessToken
        let params: [String: Any] = [
            "access_token": self.accessToken!
        ]
        requestServer(.get, path, params, URLEncoding(), completionHandler)
    }
    
    //brain tree test
    func braintreeTest(total: Float, nonce: String, devData:String, completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/braintree/test/"
        let url = baseURL!.appendingPathComponent(path)
        let simpleArray = Jar.currentJar.items
        let jsonArray = simpleArray.map { item in
            return [
                "strain_id": item.strain.id,
                "quantity": item.qty,
            ]
        }
        if JSONSerialization.isValidJSONObject(jsonArray){
            do{
                let data = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
                let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
                accessToken = User.currentUser.accessToken!
                let params:[String: Any] = [
                    "total": total,
                    "access_token":accessToken!,
                    "dispensary_id": "\(Jar.currentJar.dispensary!.id!)",
                    "order_details": dataString,
                    "address":Jar.currentJar.address!,
                    "payment_method_nonce": nonce,
                    "device_data": devData
                ]
                print("accessToken! = \(accessToken)")
                requestServer(.post, path, params, URLEncoding(), completionHandler)
            }catch{
                print("JSON Serialiation Failed on some bullshit: \(error)")
            }
        }
    }
    
    //API Update Customer Account
    func updateCustomerAccount(firstName:String, lastName:String, phone:String, email:String,completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/account/update/"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "access_token": User.currentUser.accessToken!,
            "first_name": firstName,
            "last_name":lastName,
            "phone":phone,
            "email":email,
            
        ]
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }
    

    
    //API get customer's addresses
    func getCustomerAddresses( completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/address/get/"
        let url = baseURL!.appendingPathComponent(path)
        accessToken = User.currentUser.accessToken
        let params:[String:Any] = [
            "access_token" : self.accessToken!
        ]
        
        requestServer(.get, path, params, URLEncoding(), completionHandler)
        
        
    }
    
    //API add Customer Address
    func addCustomerAddress(street:String, apt:String,city:String,state:String,zipcode:String,country:String, completionHandler: @escaping (JSON) -> Void) {
        let path = "api/customer/address/create/"
        let url = baseURL!.appendingPathComponent(path)
        accessToken = User.currentUser.accessToken
        let params:[String:Any] = [
            "access_token" : self.accessToken!,
            "street":street,
            "apt":apt,
            "city":city,
            "state": state,
            "zipcode": zipcode,
            "country":country,
            
        ]
        
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }
    
    //API delete Customer Address
    func deleteCustomerAddress(id:Int, completionHandler: @escaping (JSON) -> Void) {
        let path = "api/customer/address/delete/"
        let url = baseURL!.appendingPathComponent(path)
        accessToken = User.currentUser.accessToken
        let params:[String:Any] = [
            "access_token" : self.accessToken!,
            "id":id,
            
        ]
        
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }
    
    //API update Customer Address
    func updateCustomerAddress(id:Int,street:String, apt:String,city:String,state:String,zipcode:String,country:String, completionHandler: @escaping (JSON) -> Void) {
        let path = "api/customer/address/update/"
        let url = baseURL!.appendingPathComponent(path)
        accessToken = User.currentUser.accessToken
        let params:[String:Any] = [
            "access_token" : self.accessToken!,
            "id":id,
            "street":street,
            "apt":apt,
            "city":city,
            "state": state,
            "zipcode": zipcode,
            "country":country,
            
        ]
        
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }
    
    //API set customer address as default
    func setDefaultCustomerAddress(addressID:Int, completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/address/set_default/"
        let url = baseURL!.appendingPathComponent(path)
        accessToken = User.currentUser.accessToken
        let params:[String:Any] = [
            "access_token" : accessToken!,
            "id":addressID
        ]
        
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }
    
    func retrieveUserData(accessToken:String, completionHandler: @escaping (JSON) -> Void){
        let path = "api/customer/data/get/"
        let url = baseURL!.appendingPathComponent(path)
        let params:[String:Any] = [
            "access_token" : accessToken
        ]
        
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }

    //MARK: - DRIVER FUNCTIONS'
    
    // API to login an user
    func loginDriver(userType: String,username: String, password:String , completionHandler: @escaping (JSON) -> Void) {
        if userType == USERTYPE_DRIVER{
            let path = "api/driver/auth/"
            let url = baseURL!.appendingPathComponent(path)

            let params: [String: Any]? = [
                "username": username,
                "password": password,
                "user_type": userType
            ]
            
                requestServer(.post, path, params!, URLEncoding(), completionHandler)
        }else{
            print("invalid usertype")
        }
    }
    
    func convertToDriver(completionHandler: @escaping (JSON) -> Void ){//Inserts adriver account into the database for current user
        let path = "api/driver/create/"
        let url = baseURL!.appendingPathComponent(path)
        accessToken = User.currentUser.accessToken
        let params:[String:Any] = [
            "access_token" : accessToken!
        ]
        
        requestServer(.post, path, params, URLEncoding(), completionHandler)
        
        
    }
    
    func getDriverOrders(completionHandler: @escaping (JSON) -> Void ){
        
        let path = "api/driver/orders/ready/"
        let url = baseURL!.appendingPathComponent(path)
        
        requestServer(.get, path, ["":""], URLEncoding(), completionHandler)

    }

    //API - Pick up an order
    func pickOrder(orderId: Int, completionHandler: @escaping (JSON) -> Void){
        let path = "api/driver/orders/select/"
        accessToken = User.currentUser.accessToken
        let params: [String:Any] = [
            "order_id":"\(orderId)",
            "access_token":accessToken!,
        ]
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }
    //Retriever Drivers current order
    func getCurrentDriverOrder(completionHandler: @escaping (JSON) -> Void){
        let path = "api/driver/orders/latest/"
        accessToken = User.currentUser.accessToken
        let params:[String:Any] = [
            "access_token":self.accessToken!,
        ]
        requestServer(.get, path, params, URLEncoding(), completionHandler)
    }
 
    //API - Updating Driver's Location
    func updateLocation(location: CLLocationCoordinate2D, completionHandler: @escaping (JSON) -> Void){
        let path = "api/driver/location/update/"
        accessToken = User.currentUser.accessToken
        let params: [String: Any] = [
            "access_token":accessToken!,
            "location":"\(location.latitude),\(location.longitude)"
        ]
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }

    // API - Complete the order
    func compeleteOrder(orderId: Int, completionHandler: @escaping (JSON) -> Void) {
        let path = "api/driver/order/complete/"
        accessToken = User.currentUser.accessToken
        let params: [String: Any] = [
            "order_id": "\(orderId)",
            "access_token": self.accessToken
        ]
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }
    
    // API - Getting Driver's revenue
    func getDriverRevenue(completionHandler: @escaping (JSON) -> Void) {
        let path = "api/driver/revenue/"
        accessToken = User.currentUser.accessToken
        let params: [String: Any] = [
            "access_token": self.accessToken
        ]
        requestServer(.get, path, params, URLEncoding(), completionHandler)
    }
    
    
    //MARK: - POST APP SPLIT API MANAGER FUNCTIONS
    //API Update User Password Account
    func updateUserPassword(new_password:String,completionHandler: @escaping (JSON) -> Void){
        let path = "api/user/update/password/"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "access_token": User.currentUser.accessToken!,
            "new_password": new_password,
        ]
        requestServer(.post, path, params, URLEncoding(), completionHandler)
    }
    
}
