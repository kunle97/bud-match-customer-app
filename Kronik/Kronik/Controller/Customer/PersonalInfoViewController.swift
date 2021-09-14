//
//  PersonalInfoViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 7/6/21.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    let currentUser = User.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.text = currentUser.firstName
        lastNameTF.text = currentUser.lastName
        phoneTF.text = currentUser.phone
        emailTF.text = currentUser.email
        
        
        
    }

    @IBAction func updateInfoButtonPressed(_ sender: Any) {
        let new_firstName = firstNameTF.text!
        let new_lastName = lastNameTF.text!
        let new_phone = phoneTF.text!
        let new_email = emailTF.text!
        
        if (new_firstName != User.currentUser.firstName) ||
            (new_lastName != User.currentUser.lastName) ||
            (new_phone != User.currentUser.phone) || //TODO: Check if new credentials do not match old ones
            (new_email != User.currentUser.email) {
            APIManager.shared.updateCustomerAccount(firstName: new_firstName, lastName: new_lastName, phone: new_phone, email: new_email) { (json) in
                print(json)
                User.currentUser.firstName = new_firstName
                User.currentUser.lastName = new_lastName
                User.currentUser.phone = new_phone
                User.currentUser.email = new_email
                let av = Helpers.create1ButtonAlert(alertTitle: "Info updated", alertMessage: "Changes Saved", buttonTitle: "Ok")
                self.present(av, animated: true, completion:    nil)
            }
        }else{
           let av = Helpers.create1ButtonAlert(alertTitle: "No Information Changed", alertMessage: "You must make a change to your personal information in order to save a change.", buttonTitle: "Ok")
            self.present(av, animated: true, completion: nil)
        }
        
        
//        if new_firstName.isEmpty || new_lastName.isEmpty || new_phone.isEmpty || new_email.isEmpty{
//            Helpers.create1ButtonAlert(alertTitle: "Empty Fields", alertMessage: "The fields for your personal information cannot be left blank.", buttonTitle: "Ok")
//        }else{
//
//        }
        

        
        

        
    }
    
    
}
