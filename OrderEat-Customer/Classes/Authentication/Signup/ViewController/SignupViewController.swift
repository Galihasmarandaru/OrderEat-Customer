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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    func config() {
        self.view.addBackground()
        hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @IBAction func continueButtonClicked(_ sender: Any) {
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
    }
    
}
