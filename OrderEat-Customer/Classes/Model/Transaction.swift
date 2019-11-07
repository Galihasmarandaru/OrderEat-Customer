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
    let merchantName: String
    let pickUpTime: String;
    let orderedItem: [Menu];
    let statusTransaction: String
    let transactionPrice: String
    let pickUpDate: String
    
    init(transactionID: String, customerID: String, merchantID: String, merchantName: String, pickUpTime: String, orderedItem: [Menu], statusTransaction: String, transactionPrice: String, pickupDate: String) {
        self.transactionID = transactionID
        self.customerID = customerID
        self.merchantID = merchantID
        self.merchantName = merchantName
        self.pickUpTime = pickUpTime
        self.orderedItem = orderedItem
        self.statusTransaction = statusTransaction
        self.transactionPrice = transactionPrice
        self.pickUpDate = pickupDate
    }
}



