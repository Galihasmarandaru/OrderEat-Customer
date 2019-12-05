//
//  CategoriesViewModel.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 29/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewModel : NSObject, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    let imageCategories : [UIImage] = [#imageLiteral(resourceName: "NEW 3"),#imageLiteral(resourceName: "Near me 3"),#imageLiteral(resourceName: "24 H 2"),#imageLiteral(resourceName: "healthy food 3"),#imageLiteral(resourceName: "Budget Meal 4"),#imageLiteral(resourceName: "Snack & Drink")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellCate = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCollectionCell", for: indexPath) as! MainMenuCollectionViewCell
        
        cellCate.imageCategories.image = imageCategories[indexPath.row]
        
        return cellCate
    }
    
      
  
 
    
}
