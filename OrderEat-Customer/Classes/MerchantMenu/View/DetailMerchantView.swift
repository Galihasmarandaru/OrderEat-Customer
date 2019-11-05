//
//  DetailMerchantView.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class DetailMerchantView: UIView {
    
    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var locationMerchant: UILabel!
    @IBOutlet weak var distanceAndTime: UILabel!
    @IBOutlet weak var timeOpen: UILabel!
    @IBOutlet weak var iconDAT: UIImageView!
    @IBOutlet weak var iconTO: UIImageView!
    
    var data: Merchant! {
        didSet {
            self.merchantName.text = data.nameMerchant
            self.locationMerchant.text = data.adressMerchant
        }
    }
    
}
