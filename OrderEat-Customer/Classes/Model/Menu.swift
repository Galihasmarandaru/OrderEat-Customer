//
//  Menu.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 29/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

struct Menu {
    let nameMenu: String;
    let detailMenu: String;
    let priceMenu: Int;
    let imageMenu: UIImage;
    var qty: Int;
    
    init(nameMenu: String, detailMenu: String, priceMenu: Int, imageMenu: UIImage, qty: Int) {
        self.nameMenu = nameMenu
        self.detailMenu = detailMenu
        self.priceMenu = priceMenu
        self.imageMenu = imageMenu
        self.qty = qty
    }
}
