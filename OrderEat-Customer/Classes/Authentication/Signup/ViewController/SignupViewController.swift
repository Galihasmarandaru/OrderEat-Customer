//
//  SignupViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 05/12/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    func config() {
        self.view.addBackground()
        hideKeyboard()
    }

    @IBAction func continueButtonClicked(_ sender: Any) {
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
    }
    
}
