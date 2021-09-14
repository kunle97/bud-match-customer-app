//
//  PaymentViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/28/21.
//

import UIKit
import Braintree
import BraintreeDropIn
class PaymentViewController: UIViewController {
//    @IBOutlet weak var cardholderNameTF: UITextField!
//    @IBOutlet weak var cardNumberTF: UITextField!
//    @IBOutlet weak var cardExpMonthTF: UITextField!
//    @IBOutlet weak var cardExpYearTF: UITextField!
//    @IBOutlet weak var cardCvvTF: UITextField!
//    @IBOutlet weak var cardTextField: STPPaymentCardTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Jar total amount: \(Jar.currentJar.getTotal())")
        
        let path = "api/driver/orders/latest/"
        
//        let paymentButton = PayPalButton()
//        view.addSubview(paymentButton)
//        paymentButton.translatesAutoresizingMaskIntoConstraints  = false
//        NSLayoutConstraint.activate(
//            [
//                paymentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                paymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            ]
//        )
//        configurePayPalCheckout() // Do any additional setup after loading the view.
        
        
        showDropIn(clientTokenOrTokenizationKey: BRAINTREE_TOKENIZATION_KEY)
        
    }
    

    func postNonceToServer(paymentMethodNonce: String) {
        var dataCollector = BTDataCollector()
        var devData = ""
        dataCollector.collectDeviceData { (string) in
            devData = string
        }
        // Update URL with your server
        let paymentURL = URL(string: "http://127.0.0.1:8000/api/customer/braintree/test/")!
        var request = URLRequest(url: paymentURL)
        request.httpBody = "payment_method_nonce=\(paymentMethodNonce)".data(using: String.Encoding.utf8)
        request.httpBody = "access_token=\(User.currentUser.accessToken!)".data(using: String.Encoding.utf8)
        request.httpBody = "total=\(Jar.currentJar.getTotal())".data(using: String.Encoding.utf8)
        request.httpBody = "device_data=\(devData)".data(using: String.Encoding.utf8)
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
        }.resume()
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCanceled == true) {
                print("CANCELED")
            } else if let result = result {
                var dataCollector = BTDataCollector()
                var devData = ""
                dataCollector.collectDeviceData { (string) in
                    devData = string
                }
               
                APIManager.shared.braintreeTest(total: Jar.currentJar.getTotal(), nonce: result.paymentMethod!.nonce, devData: devData) { (json) in
                    
                }
                // Use the BTDropInResult properties to update your UI
                // result.paymentMethodType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
               
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    

    
    
    func placeOrder(){
        APIManager.shared.getLatestOrder { (json) in

            if json["order"]["status"]  == nil || json["order"]["status"] == "Delivered" || json["order"]["total"] == nil || json["order"]["address"] == "" {
//                stripePayment()
//                self.braintreePayment()
                
                self.showDropIn(clientTokenOrTokenizationKey: BRAINTREE_TOKENIZATION_KEY)
                
            }else{
                //Show appropriate error message
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
                let okAction = UIAlertAction(title: "Go To Order", style: .default) { (UIAlertAction) in
                    self.performSegue(withIdentifier: "ViewOrder", sender: self)
                }

                let alertView = UIAlertController(title: "Already Ordered?", message: "Your previous order has not been completed", preferredStyle: .alert)
                alertView.addAction(okAction)
                alertView.addAction(cancelAction)

                self.present(alertView, animated: true, completion: nil)

            }
        }
        
    }
    
    @IBAction func placeOrderButtonPressed(_ sender: Any) {

        
    }
    
}
