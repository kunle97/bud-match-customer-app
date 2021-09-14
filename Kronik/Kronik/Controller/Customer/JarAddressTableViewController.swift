//
//  AddressTableViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 7/7/21.
//

import UIKit
protocol JarAddressTableViewControllerDelegate
{
    func jarAddressTableViewResponse()
}
class JarAddressTableViewController: UITableViewController {
 
    var selectedAddressDelegate: JarAddressTableViewControllerDelegate?
    
    @IBOutlet var addressesTableView: UITableView!
    let cellSpacingHeight: CGFloat = 15
    let activityIndicator = UIActivityIndicatorView()
    var addresses = [Address]()
    var addAddressButton:UIButton?
    //   Get tjhe table vierw in this style:
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadAddresses()
//        if self.addresses.count == 0{
//            //Hide Table View
//            addressesTableView.isHidden = true
//            //and navigate to the add address page
//            addAddressButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
//            addAddressButton!.center =  self.view.center
//            addAddressButton?.titleLabel!.text = "Add Address"
//            addAddressButton!.addTarget(self, action: #selector(addAddressPressed), for: .touchUpInside)
//            addAddressButton!.isHidden = false
//            self.view.addSubview(addAddressButton!)
//        }else{
//            addressesTableView.isHidden = false
//            addAddressButton!.isHidden = true
//        }
    }
  
    @objc func addAddressPressed(){
        self.present(AddAddressViewController(), animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.addresses.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 93
        return cellHeight
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressTableViewCell
        var address: Address
        // Configure the cell...
        // add border and color
        cell.backgroundColor = UIColor.white
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        cell.jarStreetLabel.text = addresses[indexPath.row].street!
//        cell.jarAptLabel.text = addresses[indexPath.row].apt!
        cell.jarCityLabel.text = addresses[indexPath.row].city!
        cell.jarStateLabel.text = addresses[indexPath.row].state!
        cell.jarZipLabel.text = addresses[indexPath.row].zipcode!
        cell.jarCountryLabel.text = addresses[indexPath.row].country!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Jar.currentJar.address = addresses[indexPath.row].toString()
        Jar.currentJar.addressDidChange = true
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Handle Address Deletion
    
//    var deleteAddressIndexPath: IndexPath? = nil
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            deleteAddressIndexPath = indexPath
//            let addressToDelete = addresses[indexPath.row]
//            confirmDelete()
//        }
//    }
//
//    func confirmDelete() {
//        let alert = UIAlertController(title: "Delete Address", message: "Are you sure you want to permanently delete this address?", preferredStyle: .actionSheet)
//
//        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteAddress)
//        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteAddress)
//
//       alert.addAction(DeleteAction)
//    alert.addAction(CancelAction)
//
//
//
//        self.present(alert, animated: true, completion: nil)
//    }
//
//   func handleDeleteAddress(alertAction: UIAlertAction!) -> Void {
//       if let indexPath = deleteAddressIndexPath {
//           tableView.beginUpdates()
//
//
//        //Delete From database
//        APIManager.shared.deleteCustomerAddress(id: addresses[indexPath.row].addressID!) { (json) in
//            print(json)
//        }
//
////        print("Deleted ID \(addresses[indexPath.row].addressID!)")
//
//        //Delete from array and tableview
//        addresses.remove(at: indexPath.row)
//           // Note that indexPath is wrapped in an array:  [indexPath]
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//        deleteAddressIndexPath = nil
//
//
//
//       tableView.endUpdates()
//       }
//   }
//
//   func cancelDeleteAddress(alertAction: UIAlertAction!) {
//        deleteAddressIndexPath = nil
//   }
    
    //MARK: - Extra functions
    func loadAddresses(){
        Helpers.showActivityIndicator(activityIndicator,self.view)
        APIManager.shared.getCustomerAddresses{ (json) in
    //            print("JSON = \(json["dispensarys"].array)")
            if json != nil{
                self.addresses = []
                if let listAddy = json["addresses"].array{
                    for item in listAddy{
                        let address = Address(json: item)
                        self.addresses.append(address)
                    }
                    self.addressesTableView.reloadData()
                    Helpers.hideActivityIndicator(self.activityIndicator)
                }
            }else{ print("JSON = Nil") }
        }
        print("Self.addresses: \(self.addresses)")
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddressToJar"{
            let controller = segue.destination as! JarViewController
            Jar.currentJar.address  = addresses[(tableView.indexPathForSelectedRow?.row)!].toString()
            controller.addressChanged = true
        }
    }
    

}


