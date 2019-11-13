//
//  OnGoingCollectionListCell.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 08/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OnGoingCollectionListCell: UICollectionViewCell {

    
    @IBOutlet weak var merchantNameLbl: UILabel!
    @IBOutlet weak var orderNumLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var pickUpTimeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    var transaction : Transaction! {
        didSet{
            self.merchantNameLbl.text = transaction.merchant?.name!
            self.priceLbl.text = "Rp. \(transaction.total!)"
            self.statusLbl.text = transactionStatus[transaction.status!]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
