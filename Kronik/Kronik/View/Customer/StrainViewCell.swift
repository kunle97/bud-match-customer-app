//
//  StrainViewCell.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/8/21.
//

import UIKit

class StrainViewCell: UITableViewCell {

    @IBOutlet weak var strainNameLabel: UILabel!
    @IBOutlet weak var shortDescriptionlabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var strainImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
