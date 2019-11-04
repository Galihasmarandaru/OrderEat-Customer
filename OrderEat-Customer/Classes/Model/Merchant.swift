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

struct Restaurant {
    private var restaurantName: String;
    private var passwordMerchant: String;
    private var coordinatMerchant: CLLocation;
    private var timeOpenMerchant: UIDatePicker;
    private var timeCloseMerchant: UIDatePicker;
    
    var condition: String;
    
    mutating func statusOperationMerchant(status: statusOperation) -> String {
        switch status {
        case .open:
            condition = "Open until, \(timeCloseMerchant)"
        case .close:
            condition = "Close until, \(timeOpenMerchant)"
        }
        return condition
    }
}
