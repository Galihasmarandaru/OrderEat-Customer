//
//  AddData.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

struct AddDataMerchantMenu {
    static func getDataMenu() -> [Menu] {
        var data = [Menu]()
        
        let menu1 = Menu(nameMenu: "Blackpepper Burger", detailMenu: "Blackpapper Ham, Pepperoni with Mayonaise Sauce", priceMenu: 20000, imageMenu: UIImage(named: "menu-1")!, qty: 1)

        let menu2 = Menu(nameMenu: "Blackpepper Burger", detailMenu: "Blackpapper Ham, Pepperoni with Mayonaise Sauce", priceMenu: 20000, imageMenu: UIImage(named: "menu-1")!, qty: 1)

        let menu3 = Menu(nameMenu: "Blackpepper Burger", detailMenu: "Blackpapper Ham, Pepperoni with Mayonaise Sauce", priceMenu: 20000, imageMenu: UIImage(named: "menu-1")!, qty: 1)
        
        let menu4 = Menu(nameMenu: "Blackpepper Burger", detailMenu: "Blackpapper Ham, Pepperoni with Mayonaise Sauce", priceMenu: 20000, imageMenu: UIImage(named: "menu-1")!, qty: 1)

        data.append(menu1)
        data.append(menu2)
        data.append(menu3)
        data.append(menu4)
        
        return data
    }
    
    static func getDataMerchant() -> Merchant {
        let dataMerchant = Merchant(merchantID: "Burger King", merchantName: "AEON Mall, BSD City", QRMerchant: UIImage(named: "qr.png")!, merchantAddress: "BSD City", merchantImage: UIImage(named: "BK.png"))
        return dataMerchant
    }
}
