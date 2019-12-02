//
//  TodayDealTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 28/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class TodayDealTableViewCell: UITableViewCell {
    var carouselCounter = 0
       var countSlideChange = 0
       var timer = Timer()
       let imageToday = TodaysViewModel().image
    @IBOutlet weak var todayViewCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timer = Timer.scheduledTimer(timeInterval: 3.25, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
    changeImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func changeImage(){
        if carouselCounter >= imageToday.count {
                carouselCounter = 0
            }
            
            sliderUpadte()
            countSlideChange += 1
    }
    
    func sliderUpadte(){
        let index = IndexPath.init(item: carouselCounter, section: 0)
        self.todayViewCell?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        carouselCounter += 1
    }

}
