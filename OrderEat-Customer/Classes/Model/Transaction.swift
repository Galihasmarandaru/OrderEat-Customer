//
//  Transaction.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

struct Transaction : Codable{
    var id : String? // D
    var orderNumber: String?
    var customer : Customer? // D
    var merchant : Merchant? // D
    var customerId : String? // E
    var merchantId : String? // E
    var pickUpTime : String? // D, E
    var total : Int? // D, E
    var discountedTotal : Int?
    var status : Int? // D, E
    var qrCode: String?
    var details : [TransactionDetail]? // D, E
    var midtransUrl : String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case orderNumber
        case customer
        case merchant
        case customerId
        case merchantId
        case pickUpTime
        case total
        case discountedTotal
        case status
        case qrCode
        case details
        case midtransUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.orderNumber = try container.decodeIfPresent(String.self, forKey: .orderNumber)
        self.customer = try container.decodeIfPresent(Customer.self, forKey: .customer)
        self.merchant = try container.decodeIfPresent(Merchant.self, forKey: .merchant)
        self.pickUpTime = try container.decodeIfPresent(String.self, forKey: .pickUpTime)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.discountedTotal = try container.decodeIfPresent(Int.self, forKey: .discountedTotal)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.qrCode = try container.decodeIfPresent(String.self, forKey: .qrCode)
        self.details = try container.decodeIfPresent([TransactionDetail].self, forKey: .details)
        self.midtransUrl = try container.decodeIfPresent(String.self, forKey: .midtransUrl)
    }
    
    init(merchantId : String) {
        self.merchantId = merchantId
        self.customerId = CurrentUser.id
        self.details = []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(customerId, forKey: .customerId)
        try container.encode(merchantId, forKey: .merchantId)
        try container.encode(pickUpTime, forKey: .pickUpTime)
        try container.encode(total, forKey: .total)
        try container.encode(discountedTotal, forKey: .discountedTotal)
        try container.encode(details, forKey: .details)
    }
    
    func getTotalMenu() -> Int {
        var totalMenu = 0
        
        guard let details = details else {return 0}
        for detail in details {
            totalMenu += detail.qty!
        }
        
        return totalMenu
    }
    
    func getSubTotalPrice() -> Int {
        var totalPrice = 0
        
        guard let details = details else {return 0}
        for detail in details {
            totalPrice += (detail.qty! * detail.menu!.price!)
        }
        
        return totalPrice
    }
    
    func getDiscount() -> Int {
        let discount = Double(total!) * merchant!.discount!
        let roundedDiscount = Int(discount / 100) * 100
        
        return roundedDiscount < merchant!.maxDiscount! ? roundedDiscount : merchant!.maxDiscount!
    }
    
    func getTaxPrice() -> Int {
        let taxPrice = Int(merchant!.tax! * Double(getSubTotalPrice()))
        
        return taxPrice
    }
}


