//
//  DispensaryViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/27/21.
//

import UIKit

class DispensaryViewController: UIViewController {

    @IBOutlet weak var dispensarySearchBar: UISearchBar!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var dispensaries = [Dispensary]()
    var filterDiespensaries = [Dispensary]()
    
    let activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var dispensariesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        
        
        menuBarButton.target = self.revealViewController()
        menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        loadDisensaries()
        
        
        Helpers.addLogoToNavgation(view: self)
        
    }

    
    func loadDisensaries(){
        Helpers.showActivityIndicator(activityIndicator,self.view)
        APIManager.shared.getDispensaries{ (json) in
//            print("JSON = \(json["dispensarys"].array)")
            if json != nil{
                self.dispensaries = []
                if let listDis = json["dispensarys"].array{
                    for item in listDis{
                        let dispensary = Dispensary(json: item)
                        self.dispensaries.append(dispensary)
                    }
                    self.dispensariesTableView.reloadData()
                    Helpers.hideActivityIndicator(self.activityIndicator)
                }
            }else{ print("JSON = Nil") }
        }
        
       
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StrainList"{
            let controller = segue.destination as! ProductListTableViewController
            controller.dispensary = dispensaries[(dispensariesTableView.indexPathForSelectedRow?.row)!]
        }
    }

}

extension DispensaryViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterDiespensaries = self.dispensaries.filter({ (dis:Dispensary) -> Bool in
            return dis.name!.lowercased().range(of: searchText.lowercased()) != nil
        })
        self.dispensariesTableView.reloadData()
    }
}

extension DispensaryViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dispensarySearchBar.text != ""{
            return self.filterDiespensaries.count
        }
        return self.dispensaries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispensaryCell", for: indexPath) as! DispensaryViewCell
        var dispensary: Dispensary
        
        
        if dispensarySearchBar.text! != ""{
            dispensary = filterDiespensaries[indexPath.row]
        }else{
            dispensary  = dispensaries[indexPath.row]
        }
        
        cell.dispensaryNameLabel.text = dispensary.name!
        cell.dispensaryAddressLabel.text = dispensary.address!
        
        if let logoName = dispensary.backdrop{
            let url = "\(logoName)"
            Helpers.loadImage(cell.dispensaryCoverImage, url)
        }
        
        return cell
    }
}
