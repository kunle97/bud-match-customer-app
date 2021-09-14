//
//  AddressTableViewCell.swift
//  Kronik
//
//  Created by Kunle Ademefun on 7/7/21.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var aptLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statelabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var jarStreetLabel: UILabel!
    @IBOutlet weak var jarAptLabel: UILabel!
    @IBOutlet weak var jarCityLabel: UILabel!
    @IBOutlet weak var jarStateLabel: UILabel!
    @IBOutlet weak var jarZipLabel: UILabel!
    @IBOutlet weak var jarCountryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
