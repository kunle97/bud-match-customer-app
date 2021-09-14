//
//  ChangePasswordViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 8/10/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updatePasswordPressed(_ sender: Any) {
        if newPasswordTF.text == newPasswordTF2.text {
            //COntinuue to change password
            APIManager.shared.updateUserPassword(new_password: newPasswordTF.text!) { (json) in
                var status = json["status"].string!
                if status == "success"{
                    //Alert user upon successful password change and return to my account screen
                    var alert = Helpers.create1ButtonAlert(alertTitle: "Password Changed", alertMessage: "Your password has been successfully changed", buttonTitle: "Ok")
                    self.present(alert, animated: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    var alert = Helpers.create1ButtonAlert(alertTitle: "Password Change Error", alertMessage: "There was an error changing your password. please try again", buttonTitle: "Ok")
                }
            }
        }else{
            //Alert that passwords are not matching
            var alert = Helpers.create1ButtonAlert(alertTitle: "New Passwords Must Match", alertMessage: "Please ensure that your new passwords match before continuing", buttonTitle: "Ok")
            alert.present(self, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
