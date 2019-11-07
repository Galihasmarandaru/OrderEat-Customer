//
//  CustomButton.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton()
    {
        backgroundColor = .ijoDela
        layer.cornerRadius = 20
        heightAnchor.constraint(equalToConstant: 45.0).isActive = true
    }
}

