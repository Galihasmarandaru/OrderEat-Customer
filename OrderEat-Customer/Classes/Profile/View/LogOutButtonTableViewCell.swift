//
//  LogOutButtonTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 28/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class LogOutButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var logOutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        logOutButton.setTitleColor(.merahTextButton, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
