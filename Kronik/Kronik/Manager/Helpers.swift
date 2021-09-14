//
//  Helpers.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/8/21.
//
import UIKit
import Foundation
class Helpers{
    //Helper method Load Image asynchronously
    static func loadImage(_ imageView: UIImageView,_ urlString: String){
        let imgURL: URL = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: imgURL){( data,response ,error ) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async(execute:  {
                imageView.image = UIImage(data: data)
            })
            print("loadImage() Error \(error)")
            
        }.resume()
    }
    //Helper method to show activity indicator
    static func showActivityIndicator(_ activityIndicator: UIActivityIndicatorView,_ view: UIView){
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = UIColor.black
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    //Helper method to hide activity indicator
    static func hideActivityIndicator(_ activityIndicator: UIActivityIndicatorView){
        activityIndicator.stopAnimating()
    }
    
    //Helper method to determine correct weight notation for pricetype
    static func getTextPriceType(_ strain: Strain) -> String{
        switch strain.price_type {
        case 1://Quarter
            if let price = strain.price{
                return "1/4 Oz"
            }
            break
        case 2:// Half
            if let price = strain.price{
                return "1/4 Oz"
            }
            break
        case 3://Eighth
            if let price = strain.price{
                return "1/4 Oz"
            }
            break
        case 4://Gram
            if let price = strain.price{
                return "1/4 Oz"
            }
            break
        default:
            print("")
        }
        return ""
    }
    
    static func create2ButtonAlert(alertTitle:String, alertMessage:String, okActionTitle:String, cancelActionTitle:String ) -> UIAlertController{
        let alertView = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel)
        let okAction = UIAlertAction(title: okActionTitle, style: .default)
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)

      return alertView
    }
    
    static func create1ButtonAlert(alertTitle:String, alertMessage: String, buttonTitle:String) -> UIAlertController{
        let alertView = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default)
        alertView.addAction(action)
        
        return alertView
    }
    
    static func addLogoToNavgation(view: UIViewController){
        let logo = UIImage(named: "flat-logo-black.png")
        let logoImageView = UIImageView(image: logo)
        logoImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        view.navigationItem.titleView = logoImageView
    }
    
    static func resetUserDefaults(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
    
    static func logout(view: UIViewController){
        Helpers.resetUserDefaults()
        User.currentUser.resetInfo()
        view.performSegue(withIdentifier: "LoginViewFromLogout", sender: self)
    }
    static func roundTo2(num:Float) -> Float{
        var newNum = round(num*100)/100
        return newNum
        
    }
    
}
