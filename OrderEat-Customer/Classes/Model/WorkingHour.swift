//
//  WorkingHour.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 19/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

class WorkingHour : Codable {
    var dayOfWeek : Int?
    var openHour : String?
    var closeHour : String?
    
    private enum CodingKeys: String, CodingKey{
        case dayOfWeek
        case openHour
        case closeHour
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dayOfWeek = try container.decodeIfPresent(Int.self, forKey: .dayOfWeek)
        openHour = try container.decodeIfPresent(String.self, forKey: .openHour)
        closeHour = try container.decodeIfPresent(String.self, forKey: .closeHour)
    }
}
