//
//  OurPicksTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 29/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OurPicksTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOurPick: UIImageView!
    @IBOutlet weak var restoNameLabel: UILabel!
    @IBOutlet weak var restoAddressLabel: UILabel!
    @IBOutlet weak var restoDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
