//
//  TodaysViewModel.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 29/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

class TodaysViewModel : NSObject, UICollectionViewDataSource {
    let image:[UIImage] = [#imageLiteral(resourceName: "Kupon disc"),#imageLiteral(resourceName: "Kupon disc")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellToday = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayDealCollectionCell", for: indexPath) as! TodayDealCollectionViewCell
        return cellToday
    }
}
