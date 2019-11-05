//
//  MenuTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var titleFood: UILabel!
    @IBOutlet weak var detailFood: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    var theData = AddDataMerchantMenu.getDataMenu()
    
    var data: Menu! {
        didSet {
            self.imageMenu.image = data.imageMenu
            self.titleFood.text = data.nameMenu
            self.detailFood.text = data.detailMenu
            self.price.text = String(data.priceMenu)
        }
    }
    
}
