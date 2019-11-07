//
//  OrderedMenu.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

class OrderedMenu {
    var image: UIImage
    var name: String?
    var price: Int64?
    var qty: Int64?
    
    init(image: UIImage, name: String, price: Int64, qty: Int64) {
        self.image = image
        self.name = name
        self.price = price
        self.qty = qty
    }
}
