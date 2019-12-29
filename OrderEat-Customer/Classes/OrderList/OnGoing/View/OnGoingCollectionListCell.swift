//
//  OnGoingCollectionListCell.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 08/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OnGoingCollectionListCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var merchantNameLbl: UILabel!
    @IBOutlet weak var orderNumLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var pickUpTimeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    var transaction : Transaction! {
        didSet{
            self.merchantNameLbl.text = transaction.merchant?.name!
            self.orderNumLbl.text = "Order Number: " +  transaction.orderNumber!
            self.priceLbl.text = transaction.total!.asCurrency
            self.statusLbl.text = "Status: " + transactionStatus[transaction.status!]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
