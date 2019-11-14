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
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var minusTap: UIButton!
    @IBOutlet weak var plusTap: UIButton!
    @IBOutlet weak var qtyItem: UILabel!
    
    var cellDelegate: ButtonCellDelegate?
    
    @IBOutlet weak var viewStepper: UIView!
    
    var MerchantMenuVC: MerchantMenuViewController!
    var bottomConstraint: NSLayoutConstraint!
    
    // Closure
    var addBtnClosure: (() ->  ())?
    var refreshCartClosure: (() -> ())?
    var checkCartClosure: (() -> ())?
    
    // Container
    var detail : TransactionDetail! {
        didSet {
            detail.menuId = detail.menu?.id
            titleFood.text = detail.menu?.name!
            detailFood.text = "testtest" // dummy
            
            let price = detail.menu?.price
            priceLbl.text = "Rp. \(price!)"
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        detail.qty! = 1
        toggleButtonView()
        refreshQtyLbl()
        addBtnClosure?()
        refreshCartClosure?()
    }
    
    @IBAction func minusTap(_ sender: UIButton) {
        detail.qty! -= 1
        refreshQtyLbl()
        
        if detail.qty! == 0
        {
            checkCartClosure?()
            toggleButtonView()
        }
        
        refreshCartClosure?()
    }
    
    @IBAction func plusTap(_ sender: UIButton) {
        detail.qty! += 1
        refreshQtyLbl()
        refreshCartClosure?()
    }
    
    func toggleButtonView() {
        addButton.isHidden = !addButton.isHidden
        viewStepper.isHidden = !viewStepper.isHidden
    }
    
    func refreshQtyLbl() {
        qtyItem.text = "\(detail.qty!)"
    }
}
