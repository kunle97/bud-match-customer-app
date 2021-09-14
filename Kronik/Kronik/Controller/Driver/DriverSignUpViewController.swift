//
//  DriverSignUpViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/27/21.
//

import UIKit

class DriverSignUpViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.errorLabel.text = ""
    }
    

    @IBAction func becomeADriverPressed(_ sender: Any) {
        APIManager.shared.convertToDriver { (json) in
            if json != nil && json["status"].string! == "success"{
                
                self.performSegue(withIdentifier: "DriverViewFromSignUp", sender: self)
            }else{
                self.errorLabel.isHidden = false
                self.errorLabel.text = "There was an error logging you into your Driver account."
            }
        }
    }
}
