//
//  TodayDealCollectionViewCell.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 28/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class TodayDealCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var todayDealImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("Width: ", todayDealImage.frame.size.width)
        print("Height: ", todayDealImage.frame.size.height)
    }


}
