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
    
    var details : [TransactionDetail]!
    var transaction : Transaction! {
        didSet {
            self.details = transaction.details
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        merchantNameLbl.text = transaction.merchant?.name!
        statusLbl.text = "Status: " + transactionStatus[transaction.status!]
    }
    
    func config() {
        self.view.addBackground()

        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 15
        
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
    }
    
    @IBAction func confirmPaymentButtonClicked(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "OrderDone", bundle: nil)
//        let orderDonePage = storyboard.instantiateViewController(identifier: "orderDone") as! OrderDoneViewController
//        let appDelegate = UIApplication.shared.windows
//        appDelegate.first?.rootViewController = orderDonePage
    }
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
            cellSub.rightLabel.text = "Rp.  \(transaction.getSubTotalPrice())"

            return cellSub
        }
        else if indexPath.row == (details.count + 1) {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellTax.leftLabel.text = "Tax"
            cellTax.rightLabel.text = "Rp. \(transaction.getTaxPrice())"

            return cellTax
        }
        else if indexPath.row == (details.count + 2) {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = "Rp. \(transaction.total!)"

            return cellTotal
        }
        else if indexPath.row == (details.count + 3) {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellPickup.leftLabel.text = "Pick Up Time"
            cellPickup.rightLabel.text = "12.00"

            return cellPickup
        }
        else if indexPath.row == (details.count + 4) {
        let cellPayment = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell

            cellPayment.leftLabel.text = "Payment Method"
            cellPayment.rightLabel.text = "GOPAY"

        return cellPayment
        }
        
        let cellButton = tableView.dequeueReusableCell(withIdentifier: "QRTableViewCell", for: indexPath) as! QRTableViewCell

        //cellButton.QRImageView.image = merchants.QRMerchant

        cellButton.confirmPaymentButton.setTitle("Confirm Payment", for: .normal)
        cellButton.confirmPaymentButton.setTitleColor(.black, for: .normal)
        
        cellButton.confirmBtnClosure = { [unowned self] in
            APIRequest.put(.transactions, id: self.transaction.id!, parameter: ["status" : 2])
            self.dismiss(animated: true, completion: nil)
        }
        
        return cellButton
    }


}
