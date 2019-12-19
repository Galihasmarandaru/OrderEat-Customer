//
//  SignupViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 05/12/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var validationLbl: UILabel!
    
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
        validationLbl.isHidden = true
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
    
    func validateRegisterForm() {
        
    }

    @IBAction func continueButtonClicked(_ sender: Any) {
        guard let name = nameTextField.text, let email = emailTextField.text, let pin = pinTextField.text, let phone = phoneNumberTextField.text else {
            validationLbl.text = "Fill all fields"
            validationLbl.isHidden = false
            return
        }
        
        if !email.isValidEmail {
            validationLbl.text = "Check email spelling"
            validationLbl.isHidden = false
            return
        } else if !(pin.count == 6) {
            validationLbl.text = "Check PIN should be 6 digits"
            validationLbl.isHidden = false
            return
        } else if !(phone.count > 10 && phone.count < 15) {
            validationLbl.text = "Check your phone number"
            validationLbl.isHidden = false
        } else if !(name.count > 3 && name.count < 25) {
            validationLbl.text = "Type name between 3 - 25 characters"
            validationLbl.isHidden = false
        } else {
            validationLbl.isHidden = true
            
            let params: [String:Any] = [
                "name": nameTextField.text,
                "phone": phoneNumberTextField.text,
                "email": emailTextField.text,
                "pin": pinTextField.text?.encrypted
            ]
                        
            APIRequest.signUp(parameter: params) { (isSuccess, error) in
                if let error = error {
                    //print("ERROR : \(error)")
                    return
                }
                
                if isSuccess! {
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Signin", bundle: nil)
                        let tabBarVC = storyboard.instantiateViewController(identifier: "Signin") as! SigninViewController
                        let appDelegate = UIApplication.shared.windows
                        appDelegate.first?.rootViewController = tabBarVC
                    }
                }
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Signin", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Signin") as! SigninViewController
        let appDelegate = UIApplication.shared.windows
        appDelegate.first?.rootViewController = vc
    }
    
}

extension String {
   var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
//   var isValidPhone: Bool {
//      let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
//      let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
//      return testPhone.evaluate(with: self)
//   }
}
