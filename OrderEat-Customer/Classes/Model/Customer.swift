//
//  Customer.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 29/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

struct Customer {
    let customerID: UUID
    let customerName: String
    let emailCustomer: String
    let phoneNumberCustomer: String
    
    let orderNumberCustomer: String
    let pickupTimeCustomer: UIDatePicker
}
