//
//  OnGoingViewModel.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation


enum statusOperation {
    case zero, one, two, three, four
}

struct OnGoingViewModel{
    static func getTransaction() -> [Transaction]{
        let isiCell:[Transaction] = [Transaction(transactionID:"D-01",customerID: "",merchantID: "",merchantName: "Burger King Aeon Mall",pickUpTime: "09.00",orderedItem: [],statusTransaction: "Ready To Pick Up",transactionPrice: "120.000",pickupDate: "29 November 2019")]
        return isiCell
    }
    
//    func status(){
//        let statusText:Transaction
//        
//        var condition: String;
//
//        func statusOperationRestaurant(status: statusOperation) -> String {
//            switch status {
//            case .zero:
//                condition = "Not Confirmed"
//            case .one:
//                condition = "Confirmed"
//            case .two:
//                condition = "On Process"
//            case .three:
//                condition = "Ready To PickUp"
//            case .four:
//                condition = "Your Food Already Dingin"
//            }
//            return condition
//        }
//    }
    
}
