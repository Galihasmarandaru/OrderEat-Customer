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
            if let transactionID = event.data {
             // you can parse the data as necessary
                print("whatdataisthis: \(transactionID)")
                print("IDDDDD: \(String(describing: self.transaction.id))")
            
                
                if self.transaction.id == transactionID {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Home", bundle: nil)
                        let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                        tabBarVC.selectedIndex = 1
                        let appDelegate = UIApplication.shared.windows
                        appDelegate.first?.rootViewController = tabBarVC
                }
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
        // Show Alert
        
        APIRequest.put(.transactions, id: transaction.id!, parameter: ["status" : 5])
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func minimizeButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
        tabBarVC.selectedIndex = 1
        let appDelegate = UIApplication.shared.windows
        appDelegate.first?.rootViewController = tabBarVC
    }
}
