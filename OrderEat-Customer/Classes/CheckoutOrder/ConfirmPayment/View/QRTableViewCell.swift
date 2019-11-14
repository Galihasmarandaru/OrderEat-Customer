//
//  QRTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class QRTableViewCell: UITableViewCell {

    @IBOutlet weak var QRImageView: UIImageView!
    @IBOutlet weak var saveQRButton: UIButton!
    @IBOutlet weak var confirmPaymentButton: CustomButton!
    
    var confirmBtnClosure : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func confirmBtnPressed(_ sender: Any) {
        confirmBtnClosure?()
    }
}
