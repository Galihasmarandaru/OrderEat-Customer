//
//  CustomFieldText.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit


@IBDesignable
open class CustomFieldText: UITextField {
    func setup() {
            let border = CALayer()
            let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
