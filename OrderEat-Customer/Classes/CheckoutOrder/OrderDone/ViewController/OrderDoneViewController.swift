//
//  OrderDoneViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 07/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import PusherSwift

class OrderDoneViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var orderDoneTableView: UITableView!

    // Header View
    @IBOutlet weak var transactionMessageLbl: UILabel!
    @IBOutlet weak var merchantNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var orderNumberLbl: UILabel!
    
    var details : [TransactionDetail]!
    
    // Container
    var transaction : Transaction! {
        didSet {
            self.details = transaction.details!
        }
    }
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        transactionMessageLbl.text = transaction.status == 3 ? "Food On Process" : "Pick Up Your Food Now"
        merchantNameLbl.text = transaction.merchant?.name!
        orderNumberLbl.text = "Order No: " + transaction.orderNumber!
        statusLbl.text = "Status: " + transactionStatus[transaction.status!]
        
        
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
                        
                        if (transactions[0].status!) == 4 {
                            DispatchQueue.main.async {
                                self.statusLbl.text = "Ready to Pick Up"
                            }
                        } else if (transactions[0].status!) == 5 {
                            DispatchQueue.main.async {
                                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                                let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                                tabBarVC.selectedIndex = 1
                                let appDelegate = UIApplication.shared.windows
                                appDelegate.first?.rootViewController = tabBarVC
                            }
                        }
                    }
                } catch let error as NSError {
                   print(error)
               }
           }
       })
        PusherChannels.pusher.connect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PusherChannels.pusher.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        PusherChannels.pusher.disconnect()
    }
    
    func config() {
        self.view.addBackground()
        headerView.layer.masksToBounds = true
        headerView.layer.cornerRadius = 15
        self.orderDoneTableView.tableFooterView = UIView()
        
        image = generateQRCode(from: transaction.id!)
    }

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}

extension OrderDoneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count + 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < details.count {
            let cellFood = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! ItemTableViewCell
            cellFood.detail = details[indexPath.row]

            return cellFood
        }
        else if indexPath.row == details.count {
            let cellSub = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellSub.leftLabel.text = "Subtotal"
            cellSub.rightLabel.text = transaction.getSubTotalPrice().asCurrency

            return cellSub
        }
        else if indexPath.row == (details.count + 1) {
            let cellDiscount = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell

            cellDiscount.leftLabel.text = "Discount (\(Int(transaction.merchant!.discount! * 100))%)"
            cellDiscount.rightLabel.text = "- " + transaction.getDiscount().asPrice
            
            return cellDiscount
        }
        else if indexPath.row == (details.count + 2) {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellTax.leftLabel.text = "Tax (\(Int(transaction.merchant!.tax! * 100))%)"
            cellTax.rightLabel.text = transaction.getTaxPrice().asPrice

            return cellTax
        }
        else if indexPath.row == (details.count + 3) {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = transaction.discountedTotal?.asCurrency

            return cellTotal
        }
        else {
            if transaction.status == 4 {
                let cellQR = tableView.dequeueReusableCell(withIdentifier: "showQRTableViewCell", for: indexPath) as! ShowQRTableViewCell
                
                cellQR.QRImageView.image = image
                
                cellQR.pickUpTimeLabel.text = transaction.pickUpTime?.time

                return cellQR
            }
            else {
                let cellPickup = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
                cellPickup.leftLabel.text = "Pick Up Time"
                cellPickup.rightLabel.text = transaction.pickUpTime?.time

                return cellPickup
            }
        }
//        else if indexPath.row == (details.count + 4) {
//        let cellPayment = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
//
//            cellPayment.leftLabel.text = "Payment Method"
//            cellPayment.rightLabel.text = "GOPAY"
//
//        return cellPayment
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < details.count {
            return 135
        }
        else if indexPath.row == details.count + 4 && transaction.status == 4{
            return 370
        }
        else {
            return 35
        }
    }
}
