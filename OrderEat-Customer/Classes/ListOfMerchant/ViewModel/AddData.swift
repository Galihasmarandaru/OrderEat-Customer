//
//  ListViewModel.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit


struct AddData{
    static func getDataMerchant() -> [Merchant]{
        let isiTable:[Merchant] = [Merchant(from: "Burger King", restorAddress: "AEON Mall BSD City",restorImage: #imageLiteral(resourceName: "bk.spain_.bannernassicabrandpage.1080x1080_0"),restorDistance: "1.5km",restorTravelTime: "6 minutes"),Merchant(from: "Onezo", restorAddress: "Pasar Intramoda",restorImage: #imageLiteral(resourceName: "mcd"),restorDistance: "0.6km",restorTravelTime: "12 minutes"),Merchant(from: "Burgushi", restorAddress: "Summarecon Mall Serpong",restorImage: #imageLiteral(resourceName: "WingstopMeal_Lead"),restorDistance: "1.5km",restorTravelTime: "6 minutes"),]
        return isiTable
    }
}
