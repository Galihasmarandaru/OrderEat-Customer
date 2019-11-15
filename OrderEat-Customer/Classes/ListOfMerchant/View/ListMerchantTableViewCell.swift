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
    @IBOutlet weak var merchantAddress: UILabel!
    @IBOutlet weak var merchantDistance: UILabel!
    @IBOutlet weak var merchantDistanceTime: UILabel!
    
    var merchant: Merchant!{
        didSet{
            self.merchantImage.image = merchant!.image != nil ? UIImage(named: "default") : UIImage(named: "default")
            self.merchantName.text = merchant.name
            self.merchantAddress.text = merchant.address
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
