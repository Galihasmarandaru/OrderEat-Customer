//
//  OTPViewController.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var otpTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func postRequest() {
        
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        // Sign in post request
        
        let params = [
            "phone": "087875084320",
//            "pin": "123"
        ]
        
        APIRequest.signIn(parameter: params) { (isVerified, error) in
            if let error = error {
                //print("ERROR : \(error)")
                return
            }
            
            if isVerified! {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                    let appDelegate = UIApplication.shared.windows
                    appDelegate.first?.rootViewController = tabBarVC
                }
               
            }
        }
    
        
    }
}
