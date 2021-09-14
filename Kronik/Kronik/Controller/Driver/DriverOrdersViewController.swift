//
//  DriverOrdersViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/12/21.
//

import UIKit

class DriverOrdersViewController: UITableViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var orders = [DriverOrder]()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBarButton.target = self.revealViewController()
        menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadReadyOrders()
    }
    
    func loadReadyOrders(){
        Helpers.showActivityIndicator(activityIndicator, self.view)
        APIManager.shared.getDriverOrders { (json) in
            if json != nil{
                self.orders = []
                if let readyOrders = json["orders"].array{
                    for item in readyOrders{
                        let order = DriverOrder(json: item)
                        self.orders.append(order)
                    }
                }
                self.tableView.reloadData()
                Helpers.hideActivityIndicator(self.activityIndicator)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverOrderCell", for: indexPath) as! DriverOrderCell
        
        let order =  orders[indexPath.row]
        cell.customerNameLabel.text = order.customerName
        cell.customerAddressLabel.text = order.customerAddress
        cell.dispensaryNameLabel.text = order.dispensaryName
        
//        cell.customerAvatar.image  = try! UIImage(data: Data(contentsOf: URL(string: order.customerAvatar!)!))
        cell.customerAvatar.layer.cornerRadius = 50/2
        cell.customerAvatar.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Driver Access Token: \(User.currentUser.accessToken!)")
        let order = orders[indexPath.row]
        self.pickOrder(orderId: order.id!)
    }
    
    
    private func pickOrder(orderId: Int){
        APIManager.shared.pickOrder(orderId: orderId) { (json) in
            if let status = json["status"].string{
                switch status{
                case "fail":
                    //Show error
                    let alertView = UIAlertController(title: "Error", message: json["error"].string, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                    alertView.addAction(cancelAction)
                    self.present(alertView, animated: true, completion: nil)
                    break
                default:
                    let alertView = UIAlertController(title: nil, message: "Success! You will now receive the direction for your delivery.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "View Map", style: .default) { (action) in
                        self.performSegue(withIdentifier: "CurrentDelivery", sender: self)
                    }
                    alertView.addAction(okAction)
                    self.present(alertView, animated: true, completion: nil)
                    break
                }
            }
        }
    }
}
