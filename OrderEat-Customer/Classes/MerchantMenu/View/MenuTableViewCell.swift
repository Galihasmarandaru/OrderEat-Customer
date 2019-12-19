//
//  MenuTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

protocol MenuTableViewCellDelegate {
    func didPressedNotesBtn(detail: TransactionDetail)
}

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var titleFood: UILabel!
    @IBOutlet weak var detailFood: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var minusTap: UIButton!
    @IBOutlet weak var plusTap: UIButton!
    @IBOutlet weak var qtyItem: UILabel!
    
    @IBOutlet weak var viewStepper: UIView!
    
    @IBOutlet weak var AddNotes: UIView!
    
    
    var MerchantMenuVC: MerchantMenuViewController!
    var bottomConstraint: NSLayoutConstraint!
    
    var delegate : MenuTableViewCellDelegate!
    
    // Closure
    var addBtnClosure: (() ->  ())?
    var refreshCartClosure: (() -> ())?
    var checkCartClosure: (() -> ())?
    var plusBtnClosure: (() -> ())?
    var minusBtnClosure: (() -> ())?
    var activityCart: (() -> ())?
        
    // Container
    var menu : Menu! {
        didSet {
            titleFood.text = menu.name!
            
            if let imageUrl = menu.image {
                imageMenu.load(url: URL(string: imageUrl)!)
            } else {
                imageMenu.image = UIImage(named: "default")
            }

            let price = menu.price
            priceLbl.text = "Rp. \(price!.currencyFormat)"
        }
    }
    
    var detail : TransactionDetail! {
        didSet {
            if detail.qty! > 0 {
                toggleButtonView()
            }
            refreshLabel()
        }
    }
//
    override func prepareForReuse() {
        addButton.isHidden = false
        viewStepper.isHidden = true
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        addBtnClosure?()
        detail.qty! += 1
        toggleButtonView()
        refreshLabel()
        refreshCartClosure?()
        activityCart?()
    }
    
    @IBAction func minusTap(_ sender: UIButton) {
        detail.qty! -= 1
        minusBtnClosure?()
        refreshCartClosure?()
        if detail.qty! == 0 {
            toggleButtonView()

        }
        else {
            refreshLabel()
        }
    }
    
    @IBAction func plusTap(_ sender: UIButton) {
        detail.qty! += 1
        refreshCartClosure?()
        refreshLabel()
    }
    
    @IBAction func noteTap(_ sender: Any) {
        delegate.didPressedNotesBtn(detail: detail)
    }
    
    
    func toggleButtonView() {
        addButton.isHidden = !addButton.isHidden
        viewStepper.isHidden = !viewStepper.isHidden
    }
    
    func refreshLabel() {
        qtyItem.text = String(detail.qty!)
    }
    
    
}
