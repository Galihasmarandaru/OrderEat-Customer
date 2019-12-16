//
//  SigninViewController.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 08/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Defaults.getUserLogin() {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
            tabBarVC.selectedIndex = 0
            let appDelegate = UIApplication.shared.windows
            appDelegate.first?.rootViewController = tabBarVC
        }
        
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        // Sign in post request
                
        let params = [
            "phone": phoneTextField.text,
            "PIN": passwordTextField.text?.encrypted ?? nil
        ]
        
        APIRequest.signIn(parameter: params) { (isVerified, error) in
            if let error = error {
                //print("ERROR : \(error)")
                return
            }
            
            if isVerified! {
                DispatchQueue.main.async {
                    
                    if (CurrentUser.id != "") {
                        print(CurrentUser.accessToken)
                        PusherChannels.subscribePushChannel(channel: CurrentUser.id)
                        PusherBeams.registerDeviceInterest(pushInterest: CurrentUser.id)
                    }
                    
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                    // tabBarVC.selectedIndex[1]
                    let appDelegate = UIApplication.shared.windows
                    appDelegate.first?.rootViewController = tabBarVC
                }
               
            }
        }
        
        for interest in PusherBeams.pushNotifications.getDeviceInterests()! {
            print("Interest: \(interest)")
        }
    }
}
