//
//  OTPSignupViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 05/12/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OTPSignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    func config() {
        self.view.addBackground()
        hideKeyboard()
    }

}
