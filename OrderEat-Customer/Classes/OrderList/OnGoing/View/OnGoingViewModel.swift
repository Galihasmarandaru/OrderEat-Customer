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
        let isiCell:[Transaction] = [Transaction(from: "D-01", custID: "1", merchName: "1", statusTrans: "3", transPrice: "Rp 20.000", pickupDat: "29 October 2019", pickUpTim: "09.00"),Transaction(from: "D-02", custID: "1", merchName: "2", statusTrans: "2", transPrice: "Rp 121.000", pickupDat: "29 October 2019", pickUpTim: "12.00"),Transaction(from: "D-03", custID: "1", merchName: "3", statusTrans: "2", transPrice: "Rp 58.000", pickupDat: "29 October 2019", pickUpTim: "13.00"),]
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
