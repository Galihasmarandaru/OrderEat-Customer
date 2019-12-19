//
//  PickUpTimeTableViewCell.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class PickUpTimeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pickUpTimeTextField: UITextField!
    
    var datePicker : UIDatePicker! {
        didSet {
            pickUpTimeTextField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func datePickerChanged(_ sender : UIDatePicker) {
        pickUpTimeTextField.text = sender.date.time
    }
}
