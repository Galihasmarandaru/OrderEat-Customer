//
//  Transaction.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class Transaction : Codable{
    var id : String? // D
    var customer : Customer? // D
    var merchant : Merchant? // D
    var customerId : String? // E
    var merchantId : String? // E
    var pickUpTime : String? // D, E
    var total : Int? // D, E
    var status : Int? // D, E
    var details : [TransactionDetail]? // D, E
    
    private enum CodingKeys: String, CodingKey {
        case id
        case customer
        case merchant
        case customerId
        case merchantId
        case pickUpTime
        case total
        case status
        case details
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.customer = try container.decodeIfPresent(Customer.self, forKey: .customer)
        self.merchant = try container.decodeIfPresent(Merchant.self, forKey: .merchant)
        self.pickUpTime = try container.decodeIfPresent(String.self, forKey: .pickUpTime)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.details = try container.decodeIfPresent([TransactionDetail].self, forKey: .details)
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
    
    func getTaxPrice() -> Int {
        
        let taxPrice = Int(merchant!.tax! * Double(getSubTotalPrice()))
        
        return taxPrice
    }
}


