//
//  Customer.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 29/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

/*
struct Customer {
    let customerID: UUID
    let customerName: String
    let emailCustomer: String
    let phoneNumberCustomer: String
    
    let orderNumberCustomer: String
    let pickupTimeCustomer: UIDatePicker
}
*/

class Customer : Codable {
    var id : String? // D
    var name : String? // D, E
    var phone : String? // D, E
    var email : String? // E
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case phone
        case email
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(phone, forKey: .phone)
        try container.encode(email, forKey: .email)
    }
}
