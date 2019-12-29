//
//  TableCell.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 29/12/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func disable() {
        self.contentView.alpha = 0.5
        self.isUserInteractionEnabled = false
    }
    
    func enable() {
        self.contentView.alpha = 1
        self.isUserInteractionEnabled = true
    }
}
