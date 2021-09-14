//
//  MyAccountViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 7/4/21.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var menuItemData = [
            ["name":"Personal Info",
             "image":"personal-info-icon",
             "segue": "PersonalInfo"
            ],
            ["name":"My Addresses",
             "image":"address-icon",
             "segue":"CustomerAddresses"
            ],
            ["name":"Change Password",
             "image":"leaf1-green-ui",
             "segue":"ChangePassword"
            ],
            ["name":"New UI",
             "image":"leaf1-green-ui",
             "segue":""
            ]
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
//        Helpers.addLogoToNavgation(view: self)
        self.navigationItem.title = "My Account"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alwaysBounceVertical = false
        // Do any additional setup after loading the view.
        self.modalPresentationStyle = .fullScreen
        
        menuBarButton.target = self.revealViewController()
        menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }


}

extension MyAccountViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAccountCell", for: indexPath) as! MyAccountTableTableViewCell
        cell.myAccountMenuCellLabel.text = menuItemData[indexPath.row]["name"]
//        cell.myAccountMenuCellIcon.image = UIImage(named: menuItemData[indexPath.row]["image"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.performSegue(withIdentifier: menuItemData[indexPath.row]["segue"]!, sender: self)
        }else if indexPath.row == 1{
            self.performSegue(withIdentifier: menuItemData[indexPath.row]["segue"]!, sender: self)
        }else if indexPath.row == 2{
            self.performSegue(withIdentifier: menuItemData[indexPath.row]["segue"]!, sender: self)

        }else if indexPath.row == 3{

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homeScreen")
            self.navigationController!.pushViewController(vc, animated: true)

        }
    }

    
}
