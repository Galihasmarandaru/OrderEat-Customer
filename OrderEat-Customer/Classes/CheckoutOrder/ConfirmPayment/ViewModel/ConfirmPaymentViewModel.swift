//
//  ConfirmOrderViewModel.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

struct ConfirmPaymentViewModel {
    static func getDataMenuPayment() -> [Menu] {
        let cell: [Menu] = [Menu(nameMenu: "Burger", detailMenu: "Test", priceMenu: 50000, imageMenu: UIImage(named: "Blackpepper Burger.png")!, qty: 0), Menu(nameMenu: "Noodle", detailMenu: "Test", priceMenu: 25000, imageMenu: UIImage(named: "Blackpepper Burger.png")!, qty: 0), Menu(nameMenu: "Fried Chicken", detailMenu: "Test", priceMenu: 30000, imageMenu: UIImage(named: "Blackpepper Burger.png")!, qty: 0)]
        
        return cell
    }
    static func getDataMerchant() -> Merchant {
        let cell: Merchant = Merchant(merchantID: "1", merchantName: "Burger King AEON Mall, BSD City", QRMerchant: UIImage(named: "qr.png")!, merchantAddress: "BSD City", merchantImage: UIImage(named: "bg-merchat-1"))
        
        return cell
    }
}
