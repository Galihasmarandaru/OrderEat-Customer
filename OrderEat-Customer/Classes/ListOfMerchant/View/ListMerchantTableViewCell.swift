//
//  ListMerchantTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class ListMerchantTableViewCell: UITableViewCell {

    @IBOutlet weak var merchantImage: UIImageView!
    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var merchantADdress: UILabel!
    @IBOutlet weak var merchantDistance: UILabel!
    @IBOutlet weak var merchantDistanceTime: UILabel!
    
    var merchant: Merchant!{
        didSet{
            //self.merchantImage.image = data.ima
            self.merchantName.text = merchant.name
            self.merchantADdress.text = merchant.address
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
