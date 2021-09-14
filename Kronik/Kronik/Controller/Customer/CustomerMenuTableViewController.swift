//
//  CustomerMenuTableViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/27/21.
//

import UIKit

class CustomerMenuTableViewController: UITableViewController {
//    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = "Welcome, \(User.currentUser.firstName!)!"
        
//        avatarImg.image = try! UIImage(data: Data(contentsOf: URL(string: User.currentUser.pictureURL!)!))
//        avatarImg.layer.cornerRadius = 70/2
//        avatarImg.layer.borderWidth = 2.0
//        avatarImg.layer.borderColor =   UIColor.white.cgColor
//        avatarImg.clipsToBounds = true
//
        view.backgroundColor =  UIColor(red:0.32,green:0.61, blue:0.52, alpha:1)
    }
    @IBAction func logoutButtonPressed(_ sender: Any) {
        Helpers.logout(view: self)
    }
    

    @IBAction func budMatcherPressed(_ sender: Any) {
        guard let url = URL(string:  "https://www.budmatchapp.com/budmatcher/") else{
            return
        }
        let vc  = DispensaryWebViewController(url:url, title: "BudMatcher")
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC,animated: true)
    }
    

    
//    @IBAction func MyAccountButtonPressed(_ sender: Any) {
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginViewFromLogout"{

        }
    }
    

}
