//
//  Transaction.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

struct Transaction {
    let transactionID: String;
    let customerID: String;
    let merchantID: String;
//    let statusTransaction: Int64;
//    let totalTransaction: Int;
    let pickUpTime: String;
    let orderedItem: [Menu]; //ganti
    
    init(transactionID: String, customerID: String, merchantID: String, pickUpTime: String, orderedItem: [Menu]) {
        self.transactionID = transactionID
        self.customerID = customerID
        self.merchantID = merchantID
        self.pickUpTime = pickUpTime
        self.orderedItem = orderedItem
    }
}
