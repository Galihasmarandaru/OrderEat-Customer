//
//  Restaurant.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 29/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CoreLocation

class Merchant : Codable {
    var id : String? // D
    var name : String? // D, E
    var phone : String? // D, E
    var email : String? // E
    var password : String? // E
    var address : String? // D, E
    var isOpen : Bool? // D
    var lat : Double? // D, E
    var long : Double? // D, E
    var qrCode : String? // D, E
    var image : String? // D, E
    var tax : Double? // D, E
    var discount : Double? // D
    var maxDiscount : Int?
    var workingHours : [WorkingHour]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case phone
        case email
        case password
        case address
        case isOpen
        case lat
        case long
        case qrCode
        case image
        case tax
        case discount
        case maxDiscount
        case workingHours = "workingHour"
        case openHour
        case closeHour
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        isOpen = try container.decodeIfPresent(Bool.self, forKey: .isOpen)
        lat = try container.decodeIfPresent(Double.self, forKey: .lat)
        long = try container.decodeIfPresent(Double.self, forKey: .long)
        qrCode = try container.decodeIfPresent(String.self, forKey: .qrCode)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        tax = try container.decodeIfPresent(Double.self, forKey: .tax)
        discount = try container.decodeIfPresent(Double.self, forKey: .discount)
        maxDiscount = try container.decodeIfPresent(Int.self, forKey: .maxDiscount)
        workingHours = try container.decodeIfPresent([WorkingHour].self, forKey: .workingHours)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(phone, forKey: .phone)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(address, forKey: .address)
        try container.encode(lat, forKey: .lat)
        try container.encode(long, forKey: .long)
        try container.encode(qrCode, forKey: .qrCode)
        try container.encode(image, forKey: .image)
        try container.encode(tax, forKey: .tax)
    }
}

