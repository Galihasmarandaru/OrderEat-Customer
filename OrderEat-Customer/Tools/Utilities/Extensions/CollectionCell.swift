//
//  CollectionCell.swift
//  
//
//  Created by Frederic Orlando on 29/12/19.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func disable() {
        self.contentView.alpha = 0.5
        self.isUserInteractionEnabled = false
    }
    
    func enable() {
        self.contentView.alpha = 1
        self.isUserInteractionEnabled = true
    }
}
