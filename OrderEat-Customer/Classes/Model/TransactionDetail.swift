//
//  TransactionDetail.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 10/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

class TransactionDetail : Codable {
    var transactionId : String? // E
    var menu : Menu? // D
    var menuId : String? // E
    var notes: String?
    var qty : Int? // D, E //
    
    private enum CodingKeys: String, CodingKey{
        case transactionId
        case menu
        case menuId
        case notes
        case qty
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //transactionID = try container.decodeIfPresent(String.self, forKey: .transactionID)
        menu = try container.decodeIfPresent(Menu.self, forKey: .menu)
        notes = try container.decodeIfPresent(String.self, forKey: .notes)
        qty = try container.decodeIfPresent(Int.self, forKey: .qty)
    }
    
    init(menu : Menu) {
        self.notes = ""
        self.menu = menu
        self.qty = 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transactionId, forKey: .transactionId)
        try container.encode(menuId, forKey: .menuId)
        try container.encode(notes, forKey: .notes)
        try container.encode(qty, forKey: .qty)
    }
}
