//
//  MyAccountTableTableViewCell.swift
//  Kronik
//
//  Created by Kunle Ademefun on 8/8/21.
//

import UIKit

class MyAccountTableTableViewCell: UITableViewCell {
    @IBOutlet weak var myAccountMenuCellIcon: UIImageView!
    @IBOutlet weak var myAccountMenuCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
