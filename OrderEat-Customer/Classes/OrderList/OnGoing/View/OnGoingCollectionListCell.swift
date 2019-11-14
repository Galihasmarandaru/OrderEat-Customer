//
//  OnGoingCollectionListCell.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 08/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OnGoingCollectionListCell: UICollectionViewCell {

    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
