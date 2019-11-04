//
//  Customer.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 29/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

struct Customer {
    private var customerID: UUID;
    private var customerName: String;
    private var emailCustomer: String;
    private var phoneNumberCustomer: String;
    
    private var orderNumberCustomer: String;
    private var pickupTimeCustomer: UIDatePicker;
}
