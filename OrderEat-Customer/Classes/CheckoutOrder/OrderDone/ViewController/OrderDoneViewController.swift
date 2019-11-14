//
//  OrderDoneViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 07/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderDoneViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var orderDoneTableView: UITableView!

    // Header View
    @IBOutlet weak var merchantNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
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
        
        merchantNameLbl.text = transaction.merchant?.name!
        statusLbl.text = "Status: " + transactionStatus[transaction.status!]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        APIRequest.put(.transactions, id: transaction.id!, parameter: ["status" : 3])
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
        if transaction.status == 2 {
            return details.count + 4
        }
        else {
            return details.count + 5
        }
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
            cellSub.rightLabel.text = "Rp.  \(transaction.getSubTotalPrice())"

            return cellSub
        }
        else if indexPath.row == (details.count + 1) {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellTax.leftLabel.text = "Tax (\(Int(transaction.merchant!.tax! * 100))%)"
            cellTax.rightLabel.text = "Rp. \(transaction.getTaxPrice())"

            return cellTax
        }
        else if indexPath.row == (details.count + 2) {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = "Rp. \(transaction.total!)"

            return cellTotal
        }
        else if indexPath.row == (details.count + 3) {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellPickup.leftLabel.text = "Pick Up Time"
            cellPickup.rightLabel.text = transaction.pickUpTime?.time

            return cellPickup
        }
//        else if indexPath.row == (details.count + 4) {
//        let cellPayment = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
//
//            cellPayment.leftLabel.text = "Payment Method"
//            cellPayment.rightLabel.text = "GOPAY"
//
//        return cellPayment
//        }
        
        if transaction.status == 3 {
            let cellQR = tableView.dequeueReusableCell(withIdentifier: "showQRTableViewCell", for: indexPath) as! ShowQRTableViewCell

            cellQR.QRImageView.image = image

            return cellQR
        }
        
        else {
            return UITableViewCell()
        }
    }
}
