//
//  ItemOrderedTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class ItemOrderedTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageVIew: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQtyLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: Menu! {
        didSet {
            self.itemImageVIew.image = data.imageMenu
            self.itemNameLabel.text = data.nameMenu
            self.itemQtyLabel.text = String(data.qty)
            self.itemPriceLabel.text = String(data.priceMenu)
        }
    }
    
    var transaction: Transaction! {
        didSet {
            
        }
    }

}