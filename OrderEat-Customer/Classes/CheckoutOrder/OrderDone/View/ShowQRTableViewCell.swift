//
//  ShowQRTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 08/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class ShowQRTableViewCell: UITableViewCell {

    @IBOutlet weak var pickUpTimeLabel: UILabel!
    @IBOutlet weak var QRImageView: UIImageView!
    @IBOutlet weak var pickUpTimeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pickUpTimeView.backgroundColor = .ijoDela
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
