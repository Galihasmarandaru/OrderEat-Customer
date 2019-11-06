//
//  ListViewModel.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


struct AddData{
    static func getDataMerchant() -> [Merchant]{

        
        let isiTable:[Merchant] = [Merchant(merchantName: "Burger King", merchantAddress: "AEON Mall BSD City", merchantImage: #imageLiteral(resourceName: "bk.spain_.bannernassicabrandpage.1080x1080_0"))]
        return isiTable
    }
}
