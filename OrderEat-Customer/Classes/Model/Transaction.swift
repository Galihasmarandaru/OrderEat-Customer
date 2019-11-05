//
//  Transaction.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

struct Tarnsaction {
    private var transactionID: UUID
    private var customerID: String
    private var merchantID: String
    private var statusTransaction: Int64
    private var totalTransaction: Int
    private var pickUpTime: UIDatePicker
}
