//
//  QRTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class QRTableViewCell: UITableViewCell {

    @IBOutlet weak var QRImageView: UIImageView!
    @IBOutlet weak var saveQRButton: UIButton!
    @IBOutlet weak var confirmPaymentButton: CustomButton!
    
    var confirmBtnClosure : (() -> ())?
    var changeBtnTitleClosure : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.confirmPaymentButton.setTitle("Confirm Payment", for: .normal)
    }
    
    func disableButton() {
        confirmPaymentButton.isEnabled = false
        confirmPaymentButton.backgroundColor = .systemGray6
        confirmPaymentButton.setTitleColor(.systemGray, for: .normal)
    }
    
    func enableButton() {
        confirmPaymentButton.isEnabled = true
        confirmPaymentButton.backgroundColor = .ijoDela
        confirmPaymentButton.setTitleColor(.black, for: .normal)
    }
    
    func changeButton(name: String) {
        confirmPaymentButton.setTitle(name, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func confirmBtnPressed(_ sender: Any) {
        confirmBtnClosure?()

    }
}
