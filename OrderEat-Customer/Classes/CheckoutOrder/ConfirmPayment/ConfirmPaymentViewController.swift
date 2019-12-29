//
//  ConfirmPaymentViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import PusherSwift

class ConfirmPaymentViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var orderDetailsTableView: UITableView!

    // Header View
    @IBOutlet weak var merchantNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var orderNumberLbl: UILabel!
    
    var details : [TransactionDetail]!
    var transaction : Transaction! {
        didSet {
            self.details = transaction.details
        }
    }
    
    var flag : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
                        
        merchantNameLbl.text = transaction.merchant?.name!
        orderNumberLbl.text = "Order No: " + transaction.orderNumber!
        statusLbl.text = "Status: " + transactionStatus[transaction.status!]
        
        
        // PUSHERRR
        // bind a callback to handle an event
        let _ = PusherChannels.channel.bind(eventName: "Transaction", eventCallback: { (event: PusherEvent) in
            if let transaction = event.data {
                
                let data =  Data(transaction.utf8)
                
                let decoder = JSONDecoder()
                do {
                    let transactions = try decoder.decode([Transaction].self, from: data)
                    
                    if self.transaction.id == (transactions[0].id!) {
                       
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                        
                        let alert = UIAlertController(title: "Notice", message: "Payment has been confirmed", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            let storyboard = UIStoryboard(name: "Home", bundle: nil)
                            let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                            tabBarVC.selectedIndex = 1
                            let appDelegate = UIApplication.shared.windows
                            appDelegate.first?.rootViewController = tabBarVC
                       }))
                       self.present(alert, animated: true, completion: nil)
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
        PusherChannels.pusher.disconnect()
    }
    
    func config() {
        self.view.addBackground()

        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 15
        flag = 0
        
        self.orderDetailsTableView.tableFooterView = UIView()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
        tabBarVC.selectedIndex = 1
        let appDelegate = UIApplication.shared.windows
        appDelegate.first?.rootViewController = tabBarVC
    }
    
    @IBAction func saveQRButtonPressed(_ sender: Any) {
        //UIImageWriteToSavedPhotosAlbum(merchants.QRMerchant, nil, nil, nil)
        
        let gojekHooks = "gojek://"
        let gojekUrl = URL(string: gojekHooks)
        if UIApplication.shared.canOpenURL(gojekUrl!) {
            UIApplication.shared.open(gojekUrl!, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.open(URL(string: "https://apps.apple.com/id/app/gojek/id944875099")!, options: [:], completionHandler: nil)
        }
        flag = 1
        orderDetailsTableView.reloadData()
    }
    
//    @IBAction func confirmPaymentButtonClicked(_ sender: Any) {
//        let alert = AlertView.showAlert(title: "Confirm Payment", message: "Are you sure you have done your payment?")
//
//        self.present(alert, animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "OrderDone", bundle: nil)
//        let orderDonePage = storyboard.instantiateViewController(identifier: "orderDone") as! OrderDoneViewController
//        let appDelegate = UIApplication.shared.windows
//        appDelegate.first?.rootViewController = orderDonePage
//        self.flag = 1
//    }
    
}

extension ConfirmPaymentViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count + 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < details.count {
            let cellFood = tableView.dequeueReusableCell(withIdentifier: "orderedItemTableViewCell", for: indexPath) as! OrderedItemTableViewCell
            cellFood.detail = details[indexPath.row]

            return cellFood
        }
        else if indexPath.row == details.count {
            let cellSub = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellSub.leftLabel.text = "Subtotal"
            cellSub.rightLabel.text = transaction.getSubTotalPrice().asCurrency

            return cellSub
        }
        else if indexPath.row == (details.count + 1) {
            let cellDiscount = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell

            cellDiscount.leftLabel.text = "Discount (\(Int(transaction.merchant!.discount! * 100))%)"
            cellDiscount.rightLabel.text = "- " + transaction.getDiscount().asPrice
            
            return cellDiscount
        }
        else if indexPath.row == (details.count + 2) {
            
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellTax.leftLabel.text = "Tax (\(Int(transaction.merchant!.tax! * 100))%)"
            cellTax.rightLabel.text = transaction.getTaxPrice().asPrice

            return cellTax
        }
        else if indexPath.row == (details.count + 3) {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = transaction.discountedTotal!.asCurrency

            return cellTotal
        }
        else if indexPath.row == (details.count + 4) {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellPickup.leftLabel.text = "Pick Up Time"
            cellPickup.rightLabel.text = transaction.pickUpTime?.time

            return cellPickup
        }
        
        let cellButton = tableView.dequeueReusableCell(withIdentifier: "QRTableViewCell", for: indexPath) as! QRTableViewCell

        if transaction.midtransUrl == nil {
            cellButton.confirmPaymentButton.setTitle("Pay with Gopay", for: .normal)
            cellButton.confirmPaymentButton.setTitleColor(.black, for: .normal)
        } else {
            cellButton.confirmPaymentButton.setTitle("Waiting Payment", for: .disabled)
            cellButton.confirmPaymentButton.isEnabled = false
        }
        
        cellButton.confirmBtnClosure = { [unowned self] in
                             
            cellButton.confirmPaymentButton.setTitle("Waiting Payment", for: .normal)
            cellButton.confirmPaymentButton.isEnabled = false

            // request midtrans token
            Midtrans.createGopayPayment(transaction: self.transaction) { (response, error) in
                
                if let error = error {
                    print(error)
                } else {
                    
                    let paymentRecord = response as! [String:String]
                    
                    DispatchQueue.main.async {
                        self.transaction.midtransUrl = paymentRecord["redirect_url"]!

                        UIApplication.shared.open(URL(string: paymentRecord["redirect_url"]!)!, options: [:], completionHandler: nil)
                        
//                            Alert.showConfirmationAlert(on: self, title: "Confirm Payment", message: "Are you sure you have done your payment?", yesAction: {
                            
//                            Midtrans.getPaymentStatus(transactionId: self.transaction.id!) { (response, error) in
//                                if let error = error {
//                                    print(error)
//                                } else {
//
//                                    DispatchQueue.main.async {
//                                        let paymentStatus = response as! [String:String]
//                                        print(paymentStatus["transaction_status"]!)
//                                        if paymentStatus["transaction_status"] == "settlement" {
//                                            APIRequest.put(.transactions, id: self.transaction.id!, parameter: ["status" : 2])
//                                        }
//                                    }
//                                }
//                            }
                            
//                                self.dismiss(animated: true, completion: nil)
//                            })
                    }
                }
            }
        }
        
        return cellButton
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < details.count {
            return 135
        }
        else if indexPath.row == details.count + 5 {
            return 150
        }
        else {
            return 35
        }
    }
}
