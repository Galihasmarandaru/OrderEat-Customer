//
//  ActionSuggestTimeViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 09/12/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class ActionSuggestTimeViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var pickUpTimeLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    var transaction: Transaction!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
        APIRequest.getDetail(.transactions, id: transaction.id!) { ( transaction, error) in
            
            if error != nil {
                 print("ERRROR OCCURED")
            } else {
                self.transaction = transaction as? Transaction
            }
        }
        
        orderNumberLabel.text = transaction.orderNumber
        pickUpTimeLabel.text = transaction.pickUpTime
    }
    
    func config() {
        self.view.addBackground()
        acceptButton.backgroundColor = .orangeButton
        acceptButton.layer.cornerRadius = 20
        acceptButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 15
    }

    @IBAction func acceptButtonClicked(_ sender: Any) {
        APIRequest.put(.transactions, id: self.transaction.id!, parameter: ["status" : 2])
        // bayar
        print("BAYARRR")
        let storyboard = UIStoryboard(name: "ConfirmPayment", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ConfirmPayment") as! ConfirmPaymentViewController
        vc.transaction  = transaction
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        APIRequest.put(.transactions, id: self.transaction.id!, parameter: ["status" : 6])
        // home
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
        tabBarVC.selectedIndex = 0
        let appDelegate = UIApplication.shared.windows
        appDelegate.first?.rootViewController = tabBarVC
//        self.dismiss(animated: true, completion: nil)
    }
    
}
