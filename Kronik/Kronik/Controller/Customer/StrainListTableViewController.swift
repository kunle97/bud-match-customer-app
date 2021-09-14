//
//  StrainListTableViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/27/21.
//

import UIKit

class StrainListTableViewController: UITableViewController {

    var dispensary: Dispensary?
    var strains = [Strain]()
    var dispensaryURL:String?
    @IBOutlet weak var webViewButton: UIBarButtonItem!
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dispensaryName = dispensary?.name{
            self.navigationItem.title = dispensaryName
        }
        dispensaryURL = dispensary?.url
        loadStrains()
    }
    
    func loadStrains(){
        Helpers.showActivityIndicator(activityIndicator,self.view)
        if let dispensaryId = dispensary?.id{
            APIManager.shared.getStrains(dispensaryId: dispensaryId) { (json) in
                if json != nil{
                    self.strains = []
                    if let tempStrains = json["strains"].array{
                        for item in tempStrains{
                            let strain = Strain(json: item)
                            self.strains.append(strain)
                            self.tableView.reloadData()
                            Helpers.hideActivityIndicator(self.activityIndicator)
                        }
                    }
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StrainDetails"{
            let controller = segue.destination as! StrainDetailsViewController
            controller.strain = strains[(tableView.indexPathForSelectedRow?.row) as! Int]
            controller.dispensary = dispensary
        }
    }
    @IBAction func dispensaryWebViewPressed(_ sender: Any) {
        guard let url = URL(string:  (dispensary?.url)!) else{
            return
        }
        let vc  = DispensaryWebViewController(url:url, title: (dispensary?.name)!)
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC,animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return strains.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "StrainCell", for: indexPath) as! StrainViewCell
        let strain = strains[indexPath.row]
        cell.strainNameLabel.text = strain.name
        cell.shortDescriptionlabel.text = strain.short_description
        

        switch strain.price_type {
        case 1://Quarter
            if let price = strain.price{
                cell.priceLabel.text = "$\(price) per 1/4 Oz"
            }
            break
        case 2:// Half
            if let price = strain.price{
                cell.priceLabel.text = "$\(price) per 1/2 Oz"
            }
            break
        case 3://Eighth
            if let price = strain.price{
                cell.priceLabel.text = "$\(price) per 1/8 Oz"
            }
            break
        case 4://Gram
            if let price = strain.price{
                cell.priceLabel.text = "$\(price) per gram"
            }
            break
        default:
            print("")
        }
        
        if let image = strain.image{
            Helpers.loadImage(cell.strainImage, "\(image)")
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
