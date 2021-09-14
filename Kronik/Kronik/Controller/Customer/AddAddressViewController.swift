//
//  AddAddressViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 7/10/21.
//

import UIKit

class AddAddressViewController: UIViewController {
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var aptTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addAddressButtonPressed(_ sender: Any) {
        APIManager.shared.addCustomerAddress(street: streetTF.text!, apt: aptTF.text!, city: cityTF.text!, state: stateTF.text!, zipcode: zipTF.text!, country: countryTF.text!) { (json) in
            print(json)
            if json["Status"].string! == "Success"{
                self.navigationController?.popViewController(animated: true)//Go Back to previous view controller
                
            }
            
        }
    }
    

}
