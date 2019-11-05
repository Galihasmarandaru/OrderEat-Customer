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
struct Restaurant{
    let restoName: String
    let restoAddress: String
    let restoImage: UIImage
    let restoDistance: String
    let restoTravelTime:String
    
    init(from restorName:String, restorAddress:String, restorImage:UIImage, restorDistance:String, restorTravelTime:String) {
        self.restoName = restorName
        self.restoAddress = restorAddress
        self.restoImage = restorImage
        self.restoDistance = restorDistance
        self.restoTravelTime = restorTravelTime
    }
}


