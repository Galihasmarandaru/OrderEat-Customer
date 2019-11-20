//
//  Alert.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    static func showConfirmationAlert(on vc: UIViewController, title: String, message: String, yesAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            yesAction()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
            vc.dismiss(animated: true, completion: nil)
        }))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    static func showErrorAlert(on vc: UIViewController, title: String, retryAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in
            retryAction()
            vc.dismiss(animated: true, completion: nil)
        }))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
}
