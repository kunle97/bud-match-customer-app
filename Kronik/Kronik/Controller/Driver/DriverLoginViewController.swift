//
//  DriverLoginViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/12/21.
//

import UIKit

class DriverLoginViewController: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var userType: String = USERTYPE_DRIVER
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func driverLoginButtonPressed(_ sender: Any) {
        //#1 Form Validation
        if usernameTF.text == "" || passwordTF.text == ""{
            errorLabel.isHidden = false
            errorLabel.text = "Please enter your login information"
        }else{
            
            //#2 Server Request
            APIManager.shared.loginDriver(userType: userType, username: usernameTF.text!, password: passwordTF.text!) { (json) in
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
                    
                    self.performSegue(withIdentifier: "DriverView", sender: self)
                    
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
    
}
