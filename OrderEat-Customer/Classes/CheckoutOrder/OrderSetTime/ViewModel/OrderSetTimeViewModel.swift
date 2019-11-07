//
//  OrderSetTimeViewModel.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

struct OrderSetTimeViewModel {
    static func getDataMenuTransaction() -> [Menu] {
        let cell: [Menu] = [Menu(nameMenu: "Burger", detailMenu: "Test", priceMenu: 50000, imageMenu: UIImage(named: "Blackpepper Burger.png")!, qty: 2), Menu(nameMenu: "Noodle", detailMenu: "Test", priceMenu: 25000, imageMenu: UIImage(named: "Blackpepper Burger.png")!, qty: 1), Menu(nameMenu: "Fried Chicken", detailMenu: "Test", priceMenu: 30000, imageMenu: UIImage(named: "Blackpepper Burger.png")!, qty: 1)]
         
        return cell
    }
}
