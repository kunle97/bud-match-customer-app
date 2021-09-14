//
//  JarViewCell.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/8/21.
//

import UIKit

class JarViewCell: UITableViewCell {
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var strainNameLabel: UILabel!
    @IBOutlet weak var strainSubtotalLabel: UILabel!
    @IBOutlet weak var jarItemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//        qtyLabel.layer.borderColor = UIColor.gray.cgColor
//        qtyLabel.layer.borderWidth = 1.0
//        qtyLabel.layer.cornerRadius = 10
    }

    @IBAction func increaseJarItemPresed(_ sender: Any) {
        var num = Int(qtyLabel.text!)! + 1
        if(num < 99){
            qtyLabel.text = "\(num)"
        }
    }
    @IBAction func decreaseJarItemPressed(_ sender: Any) {
        var num = Int(qtyLabel.text!)! - 1
        if (num > 0 ){
            qtyLabel.text = "\(num)"
        }
    }
}
