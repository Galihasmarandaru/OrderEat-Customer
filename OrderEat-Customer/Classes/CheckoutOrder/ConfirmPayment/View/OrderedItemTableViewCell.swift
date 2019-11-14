//
//  OrderedItemTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderedItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemImageView: UIImageView!
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
    
    var detail: TransactionDetail! {
        didSet {
            //self.itemImageVIew.image = menu.image
            itemNameLabel.text = detail.menu?.name
            itemQtyLabel.text = String(detail.qty!)
            
            let price = detail.menu?.price
            itemPriceLabel.text = "Rp. \(price!)"
        }
    }

}
