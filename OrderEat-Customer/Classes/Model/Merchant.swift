//
//  Restaurant.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 29/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CoreLocation

struct Merchant {
    
    let merchantID: String;
    let merchantName: String;
    let QRMerchant: UIImage;
    let merchantAddress: String;
    let merchantImage: UIImage?
    
    
    init(merchantID: String, merchantName: String, QRMerchant: UIImage, merchantAddress: String, merchantImage: UIImage?) {
        self.merchantID = merchantID
        self.merchantName = merchantName
        self.QRMerchant = QRMerchant
        self.merchantAddress = merchantAddress
        self.merchantImage = merchantImage
        
    }

}
