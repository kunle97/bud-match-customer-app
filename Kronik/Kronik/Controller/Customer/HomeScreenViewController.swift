//
//  HomeScreenViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 8/30/21.
//

import UIKit

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var productData: ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON()
        productData = readLocalFile(forName: "EcommerceJson") as! ProductModel
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        print("productData: \(productData)")
    }
    
    
    func loadJSON(){
        if let path = Bundle.main.path(forResource: "EcommerceJson", ofType: "json") {
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                productData = try jsonDecoder.decode(ProductModel.self, from: jsonData)
                
            }catch{
                print(error)
            }
            
        }
    }
}

func parse(jsonData: Data) -> Any {
    do {
        let decodedData = try JSONDecoder().decode(ProductModel.self,
                                                   from: jsonData)
        
        return decodedData
    } catch {
        print("decode error")
    }
    return ""
}

func readLocalFile(forName name: String) -> Any? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return parse(jsonData: jsonData)
        }
    } catch {
        print(error)
    }
    
    return nil
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as? ProductsTableViewCell else {
          return UITableViewCell()
      }
        cell.products = productData?.response?[indexPath.row]
        return cell
    }
}
