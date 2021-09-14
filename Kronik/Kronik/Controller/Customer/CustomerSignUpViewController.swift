//
//  CustomerSignUpViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/16/21.
//

import UIKit

class CustomerSignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var validationErrors = [
        "first_name_blank":"Please enter your first name\n",
        "last_name_blank":"Please enter your last name\n",
        "username_blank":"Please enter a username\n",
        "email_blank":"Please enter a vaild email\n",
        "password_blank":"Please enter a password\n",
        "invalid_password_text":"Make sure that your password is  at least 8 characters long and contains the following\n - one uppercase letter\n- One lowercase letter\n- One number\n- one special character (Ex: *,!,&)",
        "phone_blank":"Please enter a valid phone number",
        "username_taken": "This username has already been taken.",
        "email_exists": "A user with this email is already registered."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        errorLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    func validateBlankTextFields() -> Bool{
        if firstNameTF.text == ""{
            self.errorLabel.text! = validationErrors["first_name_blank"]!
            self.errorLabel.isHidden = false
            return false
        }else{
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
            
        }
        
        if lastNameTF.text == ""{
            self.errorLabel.text! = validationErrors["last_name_blank"]!
            self.errorLabel.isHidden = false
            return false
        }else{
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
        }
        
        if usernameTF.text == ""{
            self.errorLabel.text! = validationErrors["username_blank"]!
            self.errorLabel.isHidden = false
            return false
        }else{
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
        }
        
        if emailTF.text == ""{
            self.errorLabel.text! = validationErrors["email_blank"]!
            self.errorLabel.isHidden = false
            return false
        }else{
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
        }
        
        if passwordTF.text == ""{
            self.errorLabel.text! = validationErrors["password_blank"]!
            self.errorLabel.isHidden = false
            return false
        }else{
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
        }
        
        if phoneTF.text == ""{
            self.errorLabel.text! = validationErrors["phone_blank"]!
            self.errorLabel.isHidden = false
            return false
        }else{
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
        }
        
        return true
    }
    
    func initCreateCustomer(){
        APIManager.shared.createCustomer(userType: USERTYPE_CUSTOMER, firstName: firstNameTF.text!, lastName: lastNameTF.text!, email: emailTF.text!, username: usernameTF.text!, password: passwordTF.text!, phone: phoneTF.text!) { (json) in



            //#3 - Handle response
            if json != nil && self.errorLabel.text == "" {
                //#4 - If Success - Store uesr data in currentUser
                User.currentUser.setAccessToken(token: json["access_token"].string!)
                User.currentUser.setName(json["first_name"].string!, json["last_name"].string!)
                User.currentUser.setEmail(email: json["email"].string!)
                self.performSegue(withIdentifier: "CustomerViewFromSignUp", sender: self)
            }else{
                //#5 - If Fail - Show Appropriate error message

            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        //#1 - Front End Validation
        if self.validateBlankTextFields(){//Validate blank text fields
        //TODO: Enter password Regex validation here
        
        APIManager.shared.usernameIsValid(username: usernameTF.text!) { (json) in //Check username validity
            let response = json["response"]
            print(response)
            if response.string! == "ERROR"{
                //Username is invalid
                self.errorLabel.text! = self.validationErrors["username_taken"]!
                self.errorLabel.isHidden = false
            }else{
                self.errorLabel.text! = ""
                
                //Check if email is valid
                APIManager.shared.emailIsValid(email: self.emailTF.text!) { (json) in
                    let validEmailResponse = json["response"]
                    print(validEmailResponse)
                    if validEmailResponse.string! == "ERROR"{
                        //Email is invalid
                        self.errorLabel.text! = self.validationErrors["email_exists"]!
                        self.errorLabel.isHidden = false
                    }else{
                        //proceed with login process
                        //#2 - server Request
                        self.initCreateCustomer()
                        print("Email OK")
                    }
                }
            }
        }
        }else{
            //There are still blank text fields so do nothing
        }
        
    }
    
}

