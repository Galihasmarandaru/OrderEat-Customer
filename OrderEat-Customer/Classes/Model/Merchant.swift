//
//  Restaurant.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 29/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CoreLocation

enum statusOperation {
    case open, close
}

struct Merchant {
//    private var merchantID: UUID
    var nameMerchant: String
//    private var phoneMerchant: String
//    private var emailMerchant: String
//    private var passwordMerchant: String
    
    var adressMerchant: String
//    private var latCoordinatMerchant: CLLocation
//    private var longCoordinatMerchant: CLLocation
    
    
//    private var timeOpenMerchant: UIDatePicker
//    let timeCloseMerchant: UIDatePicker
//
//    private var QRMerchant: UIImage
//
//    var condition: String
//
//    mutating func statusOperationMerchant(status: statusOperation) -> String {
//        switch status {
//        case .open:
//            condition = "Open until, \(timeCloseMerchant)"
//        case .close:
//            condition = "Close until, \(timeOpenMerchant)"
//        }
//        return condition
//    }
    
    init(nameMerchant: String, adressMerchant: String) {
        self.nameMerchant = nameMerchant
        self.adressMerchant = adressMerchant
    }
}
