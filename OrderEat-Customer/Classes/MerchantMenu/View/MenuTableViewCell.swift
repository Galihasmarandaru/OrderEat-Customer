//
//  MenuTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var titleFood: UILabel!
    @IBOutlet weak var detailFood: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var minusTap: UIButton!
    @IBOutlet weak var plusTap: UIButton!
    @IBOutlet weak var qtyItem: UILabel!
    
//    @IBOutlet weak var CartView: UIView!
    
    @IBOutlet weak var viewStepper: UIView!
    
    var MerchantMenuVC: MerchantMenuViewController!
    var bottomConstraint: NSLayoutConstraint!
    
    var activityCart: (() -> ())?
    var hideCartAction: (() -> ())?
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        sender.isHidden = !sender.isHidden
        viewStepper.isHidden = false
        activityCart?()
    }
    
    @IBAction func minusTap(_ sender: Any) {
        if (data.qty == 0) {
            viewStepper.isHidden = true
            addButton.isHidden = false
            hideCartAction?()
        } else {
            data.qty -= 1
        }
    }
    
    @IBAction func plusTap(_ sender: Any) {
        data.qty += 1
    }
    
    var data: Menu! {
        didSet {
            self.imageMenu.image = data.imageMenu
            self.titleFood.text = data.nameMenu
            self.detailFood.text = data.detailMenu
            self.price.text = String("Rp \(data.priceMenu)")
            self.qtyItem.text = String(data.qty)
        }
    }
}
