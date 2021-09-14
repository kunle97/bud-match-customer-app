//
//  EditAddressViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 7/10/21.
//

import UIKit

class EditAddressViewController: UIViewController {
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var aptTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var setDefaultButton: UIBarButtonItem!
    
    var currentAddress:Address?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countryTF.text = currentAddress?.country
        streetTF.text = currentAddress?.street
        aptTF.text = currentAddress?.apt
        cityTF.text = currentAddress?.city
        stateTF.text = currentAddress?.state
        zipTF.text = currentAddress?.zipcode
        print("Default address value: \(currentAddress?.isDefaultAddress)")
        self.setDefaultButton.image = UIImage(systemName: "star")
        if currentAddress?.isDefaultAddress == true{
            self.setDefaultButton.image = UIImage(systemName: "star.fill")
        }else{
            self.setDefaultButton.image = UIImage(systemName: "star")
        }
        
    }


    @IBAction func saveButtonPressed(_ sender: Any) {
        var new_country = countryTF.text!
        var new_street = streetTF.text!
        var new_apt = aptTF.text!
        var new_city = cityTF.text!
        var new_state = stateTF.text!
        var new_zip = zipTF.text
        
        if (new_country != currentAddress?.country) ||
            (new_street != currentAddress?.street) ||
            (new_apt != currentAddress?.apt) || //TODO: Check if new credentials do not match old ones
            (new_city != currentAddress?.city) ||
            (new_state != currentAddress?.state) ||
            (new_zip != currentAddress?.zipcode)
        {
            APIManager.shared.updateCustomerAddress(id: currentAddress!.addressID!,street: streetTF.text!, apt: aptTF.text!, city: cityTF.text!, state: stateTF.text!, zipcode: zipTF.text!, country: countryTF.text!) { (json) in
                if(json["Status"].string == "Success"){
                    let av = Helpers.create1ButtonAlert(alertTitle: "Address updated", alertMessage: "Changes Saved", buttonTitle: "Ok")
                    self.present(av, animated: true, completion:    nil)
                }
            }

        }else{
           let av = Helpers.create1ButtonAlert(alertTitle: "No Information Changed", alertMessage: "You must make a change to your address in order to save a change.", buttonTitle: "Ok")
            self.present(av, animated: true, completion: nil)
        }

    }
    
    
    
    
    @IBAction func setDefaultAddressPressed(_ sender: Any) {
        APIManager.shared.setDefaultCustomerAddress(addressID: (currentAddress?.addressID)!) { [self] (json) in
            if(json["Status"].string == "Success"){
                self.setDefaultButton.image = UIImage(systemName:  "star.fill")
                let av = Helpers.create1ButtonAlert(alertTitle: "New Default Address Set", alertMessage: "You have set this address to be your new default address.", buttonTitle: "Ok")
                 self.present(av, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
}
