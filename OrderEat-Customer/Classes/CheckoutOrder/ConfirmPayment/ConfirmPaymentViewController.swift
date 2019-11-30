//
//  ConfirmPaymentViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

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
    }
    
    func config() {
        self.view.addBackground()

        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 15
        flag = 0
        
        self.orderDetailsTableView.tableFooterView = UIView()
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
    
    @IBAction func confirmPaymentButtonClicked(_ sender: Any) {
        let alert = AlertView.showAlert(title: "Confirm Payment", message: "Are you sure you have done your payment?")

        self.present(alert, animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "OrderDone", bundle: nil)
//        let orderDonePage = storyboard.instantiateViewController(identifier: "orderDone") as! OrderDoneViewController
//        let appDelegate = UIApplication.shared.windows
//        appDelegate.first?.rootViewController = orderDonePage
//        self.flag = 1
    }
}

extension ConfirmPaymentViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count + 5
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
            cellSub.rightLabel.text = "Rp.  \(transaction.getSubTotalPrice().currencyFormat)"

            return cellSub
        }
        else if indexPath.row == (details.count + 1) {
            
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellTax.leftLabel.text = "Tax (\(Int(transaction.merchant!.tax! * 100))%)"
            cellTax.rightLabel.text = "Rp. \(transaction.getTaxPrice().currencyFormat)"

            return cellTax
        }
        else if indexPath.row == (details.count + 2) {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = "Rp. \(transaction.total!.currencyFormat)"

            return cellTotal
        }
        else if indexPath.row == (details.count + 3) {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellPickup.leftLabel.text = "Pick Up Time"
            cellPickup.rightLabel.text = transaction.pickUpTime?.time

            return cellPickup
        }
//        else if indexPath.row == (details.count + 4) {
//        let cellPayment = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
//
//            cellPayment.leftLabel.text = "Payment Method"
//            cellPayment.rightLabel.text = "GOPAY"
//
//        return cellPayment
//        }
        
        let cellButton = tableView.dequeueReusableCell(withIdentifier: "QRTableViewCell", for: indexPath) as! QRTableViewCell

        if let qrCodeURL = transaction.merchant!.qrCode {
            cellButton.QRImageView.load(url: URL(string: qrCodeURL)!)
        }

        cellButton.confirmPaymentButton.setTitle("Confirm Payment", for: .normal)
        cellButton.confirmPaymentButton.setTitleColor(.black, for: .normal)
        
        cellButton.confirmBtnClosure = { [unowned self] in
            Alert.showConfirmationAlert(on: self, title: "Confirm Payment", message: "Are you sure you have done your payment?", yesAction: {
                APIRequest.put(.transactions, id: self.transaction.id!, parameter: ["status" : 2])
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        return cellButton
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < details.count {
            return 135
        }
        else if indexPath.row == details.count + 4 {
            return 280
        }
        else {
            return 35
        }
    }
}
