//
//  LoginViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/29/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var customerLoginButton: UIButton!
    let defaults = UserDefaults.standard
    
    var fbLoginSuccess = false
    var userType: String = USERTYPE_CUSTOMER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        
        print("User Default access_token: \(UserDefaults.standard.string(forKey: "access_token") ?? "Access token not set")\n")
        
        if UserDefaults.standard.string(forKey: "access_token") != nil{//Check if the user defaults have been saved
           
            print("User defaults set")
            
            APIManager.shared.retrieveUserData(accessToken: defaults.string(forKey: "access_token")!) { (json) in
                if json["status"].string == "success"{//Sett all appropriate values for the currentUser object
                    User.currentUser.accessToken =  json["access_token"].string!
                    User.currentUser.firstName = json["first_name"].string!
                    User.currentUser.lastName = json["last_name"].string!
                    User.currentUser.name = "\(json["first_name"].string!) \(json["last_name"].string!)"
                    User.currentUser.email = "\(json["email"].string!)"
                    User.currentUser.phone = json["phone"].string!
                    print("JSON \(json)")
                    print("Current User Data - Access Token: \(User.currentUser.accessToken), Full Name: \(User.currentUser.name), Email: \(User.currentUser.email), Phone: \(User.currentUser.phone)")
                    
                    
                    self.performSegue(withIdentifier: "CustomerView", sender: self) //Segue to new UI
                    
         
                }
            }
        }else{
            print("User defaults ignored")
        }
        
        
        
        
    }
    
    func retrieveUserDefaultJar(){
        // Read/Get Data
        if let data = UserDefaults.standard.data(forKey: "note") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let note = try decoder.decode(Jar.self, from: data)

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       /* if (AccessToken.current != nil && fbLoginSuccess == true){
            
        }*/
    }
    

    @IBAction func customerLoginPressed(_ sender: Any) {
        //#1 Form Validation
        if usernameTF.text == "" || passwordTF.text == ""{
            errorLabel.isHidden = false
            errorLabel.text = "Please enter your login information"
        }else{
            
            //#2 Server Request
            APIManager.shared.loginCustomer(userType: userType, username: usernameTF.text!, password: passwordTF.text!) { (json) in
                //#3 Handle Response
                let status = json["status"].string
                
                if status != nil && status! == "success"{
                    let login_access_token = json["access_token"].string!
                    
                    //Set all variables for current user
                    User.currentUser.setAccessToken(token: login_access_token)
                    print("Success: \(json)")
    //                print("User: \(json["user"])")
                    User.currentUser.setName(json["first_name"].string!, json["last_name"].string!)
                    User.currentUser.setEmail(email: json["email"].string!)
                    User.currentUser.setPhone(json["phone"].string!)
                    
                    //Set the user defaults to store data on phone
                    self.defaults.set(json["access_token"].string!, forKey: "access_token")
//                  self.setJarUserDefault(object: Jar.currentJar, key: "current_jar")
                    
                    
//                    self.defaults.set(true, forKey: "keep_signed_in")
                    
                    self.performSegue(withIdentifier: "CustomerView", sender: self)
                    
                }else{
                    //Show error message for why login failed
//                    let errorMessage = json["message"].string!
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "There was an error logging you into your account. Make sure that your username and password are entered correctly."
//                    print("Fail: \(json)")
                    
                }
            }
        }
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    

    
    func setJarUserDefault(object: Jar, key: String){
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(object)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: key)

        } catch {
            print("Unable to Encode Jar (\(error))")
        }
    }
    
    
}



struct LoginResponseData: Codable {
    var status: String
}

