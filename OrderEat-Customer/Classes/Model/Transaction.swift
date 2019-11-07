//
//  Transaction.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

struct Transaction {
//    private var transactionID: UUID
//    private var customerID: String
//    private var merchantID: String
//    private var statusTransaction: Int64
//    private var totalTransaction: Int
//    private var pickUpTime: UIDatePicker
    
    
    let transactionID: String
    let customerID: String
    let merchantName: String
    let statusTransaction: String
    let transactionPrice: String
    let pickupDate: String
    let pickupTime: String
    
    init(from transID:String,custID:String,merchName:String,statusTrans:String,transPrice:String,pickupDat:String,pickUpTim:String) {
        self.transactionID = transID
        self.customerID = custID
        self.merchantName = merchName
        self.statusTransaction = statusTrans
        self.transactionPrice = transPrice
        self.pickupDate = pickupDat
        self.pickupTime = pickUpTim
    }
    
    
}

