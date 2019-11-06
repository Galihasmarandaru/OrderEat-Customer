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

struct Merchant{
    let merchantName: String
    let merchantAddress: String
    let merchantImage: UIImage
    
//    let coordinatRestaurant: CLLocation
//    let timeOpenRestaurant: UIDatePicker
//    let timeCloseRestaurant: UIDatePicker
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

}
