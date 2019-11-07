//
//  Restaurant.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 29/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CoreLocation

//enum statusOperation {
//    case open, close
//}
struct Merchant {
//    private var merchantID: UUID;
//    private var nameMerchant: String;
//    private var phoneMerchant: String;
//    private var emailMerchant: String;
//    private var passwordMerchant: String;
//
//    private var adressMerchant: String;
//    private var latCoordinatMerchant: CLLocation;
//    private var longCoordinatMerchant: CLLocation;
//
//
//    private var timeOpenMerchant: UIDatePicker;
//    private var timeCloseMerchant: UIDatePicker;
//
//    private var QRMerchant: UIImage;
//
//    var condition: String;
    
    let merchantID: String;
    let merchantName: String;
    let QRMerchant: UIImage;
    
    init(merchantID: String, merchantName: String, QRMerchant: UIImage) {
        self.merchantID = merchantID
        self.merchantName = merchantName
        self.QRMerchant = QRMerchant
    }
}
//    mutating func statusOperationMerchant(status: statusOperation) -> String {
//        switch status {
//        case .open:
//            condition = "Open until, \(timeCloseMerchant)"
//        case .close:
//            condition = "Close until, \(timeOpenMerchant)"
//        }
//        return condition
//    }
//
//struct Restaurant {
//    private var restaurantName: String;
//    private var coordinatRestaurantL: CLLocation;
//    private var timeOpenRestaurant: UIDatePicker;
//    private var timeCloseRestaurant: UIDatePicker;
//
//    var condition: String;
//
//    mutating func statusOperationRestaurant(status: statusOperation) -> String {
//        switch status {
//        case .open:
//            condition = "Open until, \(timeCloseRestaurant)"
//        case .close:
//            condition = "Close until, \(timeOpenRestaurant)"
//        }
//        return condition
//    }
//}
