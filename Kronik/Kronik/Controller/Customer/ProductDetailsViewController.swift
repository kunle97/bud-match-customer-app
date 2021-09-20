//
//  StrainDetailsViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/28/21.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var strainImg: UIImageView!
    @IBOutlet weak var strainNameLabel: UILabel!
    @IBOutlet weak var strainDescriptionLabel: UILabel!
    @IBOutlet weak var priceTypeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addToJarButton: UIButton!
    @IBOutlet weak var staticPriceLabel: UILabel!
    @IBOutlet weak var dynamicPriceLabel: UILabel!


    
    var product: Product?
    var dispensary: Dispensary?
    var qty = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = true
        loadProduct()
        // Do any additional setup after loading the view.
    }
    
    func loadProduct(){
        
        if let price = product?.price{
//            addToJarButton.setTitle("Add To Jar - $\(price)", for: .normal)
            staticPriceLabel.text = "$\(price)"
            dynamicPriceLabel.text = "$\(price)"
        }
        
        strainNameLabel.text = product?.name
        strainDescriptionLabel.text = product?.description
        
        
        

        
        if let imgURL = product?.image{
            Helpers.loadImage(strainImg, "\(imgURL)")
        }
    }
    
    @IBAction func increaseQuantity(_ sender: Any) {
        if qty < 99{
            qty += 1
            quantityLabel.text = String(qty)
            if let price = product?.price{
                dynamicPriceLabel.text = "$\(price*Float(qty))"
//                addToJarButton.setTitle("Add To Jar - $\(price*Float(qty))", for: .normal)
            }
        }
    }
    
    @IBAction func decreaseQuantity(_ sender: Any) {
        if qty >= 2{
            qty -= 1
            quantityLabel.text = String(qty)
            if let price = product?.price{
//                addToJarButton.setTitle("Add To Jar - $\(price*Float(qty))", for: .normal)
                dynamicPriceLabel.text = "$\(price*Float(qty))"
            }
        }
    }
    func animateAddToJar(){
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let image = UIImageView(frame: frame)
        image.image = UIImage(named: "leaf1-green-ui")
        image.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-100)
        self.view.addSubview(image)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {image.center = CGPoint(x: self.view.frame.width-40, y:  24)},
                       completion: { _ in image.removeFromSuperview()})
        let jarItem = JarItem(product: product!, qty: self.qty)
        guard let jarDispensary = Jar.currentJar.dispensary, let currentDispensary =  self.dispensary else{
            Jar.currentJar.dispensary = self.dispensary
            Jar.currentJar.items.append(jarItem)
            return
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        //Check if user ordered strain from the same dispensary
        if jarDispensary.id == currentDispensary.id{
            let inJar = Jar.currentJar.items.firstIndex(where:{ (item) -> Bool in
                return  item.product.id! == jarItem.product.id
            })
             
            if let index = inJar{
                let alertView = UIAlertController(title: "Add More?", message: "Your jar already contains this strain. Are you sure you want to add more?", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Add more", style: .default) { (action: UIAlertAction!) in
                    Jar.currentJar.items[index].qty += self.qty
                }
                alertView.addAction(okAction)
                alertView.addAction(cancelAction)
                self.present(alertView, animated: true, completion: nil)
                
            }else{
                Jar.currentJar.items.append(jarItem)
            }
            
        }else{//Triggered if user orders from another dispensary
            let alertView = UIAlertController(title: "Start New Jar?", message: "You have selected a strain from another dispensary. Would you like to empty your current jar?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "New Jar", style: .default) { (action: UIAlertAction!) in
                Jar.currentJar.items = []
                Jar.currentJar.items.append(jarItem)
                Jar.currentJar.dispensary = self.dispensary
            }
            alertView.addAction(okAction)
            alertView.addAction(cancelAction)
            self.present(alertView, animated: true, completion: nil)
        }
        
        
        
    }

    @IBAction func addToJarButtonPressed(_ sender: Any) {
        animateAddToJar()
    }
    
    @IBAction func jarIconPressed(_ sender: Any) {
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
}
