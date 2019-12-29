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
    @IBOutlet weak var itemNotesLabel: UILabel!
    
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
            itemImageVIew.image = detail.menu?.image != nil ? UIImage(named: "default") : UIImage(named: "default")
            itemNameLabel.text = detail.menu?.name
            itemQtyLabel.text = String(detail.qty!)
            
            let price = detail.menu?.price
            itemPriceLabel.text = price!.asPrice
            
            itemNotesLabel.text = detail.notes
        }
    }
}
