//
//  K.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/2/20.
//

import UIKit
import FloatingPanel
//import Firebase
//import FirebaseAuth
class K:UIViewController, FloatingPanelControllerDelegate{
    
    static let shared = K()
    struct colors{
        public static var primaryUIColor = UIColor.init(red: 82/255, green: 157/255, blue: 133/255, alpha: 1.0)
        public static var secondaryUIColor = UIColor.white
        public static var grayUIColor = UIColor.init(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        public static var screenBGColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
        static var tint = 0.75
        public static var hybridColor = UIColor.init(red: 82/255, green: 157/255, blue: 133/255, alpha: CGFloat(tint))
        public static var sativaColor = UIColor.init(red: 239/255, green: 139/255, blue: 102/255, alpha: CGFloat(tint))
        public static var indicaColor = UIColor.init(red: 95/255, green: 79/255, blue: 118/255, alpha: CGFloat(tint))
    }
//    struct firebase{
//        public static let currentUser = Auth.auth().currentUser//Check if user is signed in with snippent below
////        if Auth.auth().currentUser != nil {
////            let currentUser = Auth.auth().currentUser
////        } else {
////          // No user is signed in.
////          print("No user is signed in.")
////        }
    
public var buttonCornerRadius = 30
    

func loadNewScreen(title:String,destination:UIViewController, navigationVC:UINavigationController){
        let nextScreen = destination
        nextScreen.title = title
        navigationVC.pushViewController(nextScreen, animated: true)
    }
    

func bouttomBarTextFieldSTyle(myTextField:UITextField){
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 1, width: myTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.init(red: 82/255, green: 157/255, blue: 133/255, alpha: 1.0).cgColor
        myTextField.borderStyle = UITextField.BorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    }
    
func addFilterUIButtonStyle(button: UIButton){
        button.backgroundColor = UIColor.init(red: 82/255, green: 157/255, blue: 133/255, alpha: 1.0)
        // Shadow Color and Radius
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 20
        button.layer.cornerRadius = 15
//        button.font.pointSize = 12.0
    }

func addPrimaryUIButtonStyle(button: UIButton){
        button.backgroundColor = UIColor.init(red: 82/255, green: 157/255, blue: 133/255, alpha: 1.0)
        // Shadow Color and Radius
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 20
    }
func addSecondaryUIButtonStyle(button: UIButton){
        button.backgroundColor = .white
        // Shadow Color and Radius
        button.setTitleColor(UIColor.init(red: 82/255, green: 157/255, blue: 133/255, alpha: 1.0), for: .normal)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 20
    }
    
    
func addTextFieldStyle(tf: UIView){
        tf.backgroundColor = .white
        tf.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tf.layer.shadowOpacity = 1.0
        tf.layer.shadowRadius = 0.0
        tf.layer.masksToBounds = false
        tf.layer.cornerRadius = 20
    }
    
func addCellStyle(tf: UIView){
        tf.backgroundColor = .white
        tf.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tf.layer.shadowOpacity = 1.0
        tf.layer.shadowRadius = 0.0
        tf.layer.masksToBounds = false
        tf.layer.cornerRadius = 10
    }
    
    
func addStrainCellStyle(cell: UICollectionViewCell){
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowRadius = 0.0
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 15
    }
    
func buttonTapped(button: UIButton, destination: UIViewController, nav: UINavigationController){
//        let nextScreen = SignUpViewController()
//        nextScreen.title = "SignUp"
//        nav.pushViewController(nextScreen, animated: true)
    }
    
    
func isPasswordValid(_ password : String) -> Bool{
        //        Start anchor
        //       (?=.*[A-Z].*[A-Z])        Ensure string has 2 uppercase letters.
        //       (?=.*[!@#$&*])            Ensure string has 1 special case letter.
        //       (?=.*[0-9].*[0-9])        Ensure string has 2 digits.
        //       (?=.*[a-z].*[a-z].*[a-z]) Ensure string has 3 lowercase letters.
        //       .{8,}                      Ensure string is of at least length 8.
        //       $                         End anchor.
        let regex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"

        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordTest.evaluate(with: password)
    }

}
