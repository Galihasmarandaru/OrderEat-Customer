//
//  WaitingforRestoConfirmViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import PusherSwift

class WaitingforRestoConfirmViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var waitingImageView: UIImageView!
    @IBOutlet weak var cancelOrderButton: CustomButton!
    @IBOutlet weak var minimizeButton: UIButton!
    
    var transaction : Transaction!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background Orange.png")!)
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 15
        self.waitingImageView.image = UIImage(named: "waitingImage.png")
        self.cancelOrderButton.setTitle("Cancel Order", for: .normal)
        self.cancelOrderButton.setTitleColor(.merahTextButton, for: .normal)
        self.minimizeButton.setTitle("Minimize", for: .normal)
        self.minimizeButton.setTitleColor(.gray, for: .normal)
        
        self.restaurantNameLabel.text = transaction.merchant?.name
        
        // bind a callback to handle an event
        let _ = PusherChannels.channel.bind(eventName: "Transaction", eventCallback: { (event: PusherEvent) in
            if let transaction = event.data {
                
                let data =  Data(transaction.utf8)
                
                let decoder = JSONDecoder()
                do {
                    let transactions = try decoder.decode([Transaction].self, from: data)
                                        
                    // transaction[0] => after update
                    // transaction[1] => before update
                    
                    if self.transaction.id == (transactions[0].id!) {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        
                        if (transactions[0].status!) == 1 {
                            DispatchQueue.main.async {
                                let vc = UIStoryboard(name: "ActionSuggestTime", bundle: nil).instantiateViewController(identifier: "ActionSuggestTime") as! ActionSuggestTimeViewController
                                vc.transaction = (transactions[0])
                                let appDelegate = UIApplication.shared.windows
                                appDelegate.first?.rootViewController = vc
//                                self.present(vc, animated: true, completion: nil)
                                
                            }
                        } else if (transactions[0].status!) == 2 {
                            
                            APIRequest.getDetail(.transactions, id: (transactions[0].id!) ) { ( transaction, error) in
                                if error != nil {
                                     print("ERRROR OCCURED")
                                } else {
                                    DispatchQueue.main.async {
                                        let vc = UIStoryboard(name: "ConfirmPayment", bundle: nil).instantiateViewController(identifier: "ConfirmPayment") as! ConfirmPaymentViewController
                                        vc.transaction = transaction as? Transaction
                                        let appDelegate = UIApplication.shared.windows
                                        appDelegate.first?.rootViewController = vc
                                    }
                                }
                            }
                        } else if (transactions[0].status!) == 6 {
                            // Alert that transaction has been cancelled.
                            let alert = UIAlertController(title: "Notice", message: "Your order has been cancelled", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                self.dismiss(animated: true, completion: {
                                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                                })
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } catch let error as NSError {
                   print(error)
               }
            
           }
       })
        PusherChannels.pusher.connect()
        
//        _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { _ in
//            APIRequest.put(.transactions, id: self.transaction.id!, parameter: ["status" : 1])
//
//            // Change root
//            let storyboard = UIStoryboard(name: "Home", bundle: nil)
//            let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
//            tabBarVC.selectedIndex = 1
//            let appDelegate = UIApplication.shared.windows
//            appDelegate.first?.rootViewController = tabBarVC
//        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func cancelOrderButtonPressed(_ sender: Any) {
        APIRequest.put(.transactions, id: transaction.id!, parameter: ["status" : 6])
    
        self.dismiss(animated: true, completion: {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func minimizeButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
        tabBarVC.selectedIndex = 1
        let appDelegate = UIApplication.shared.windows
        appDelegate.first?.rootViewController = tabBarVC
    }
}
