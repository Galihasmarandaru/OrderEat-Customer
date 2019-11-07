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
    
    var foods = ConfirmPaymentViewModel.getDataMenuPayment()
    var merchants = ConfirmPaymentViewModel.getDataMerchant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBackground()

        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 15
        
        self.orderDetailsTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveQRButtonPressed(_ sender: Any) {
//        UIImageWriteToSavedPhotosAlbum(merchants.QRMerchant, nil, nil, nil)
        
        let gojekHooks = "gojek://"
        let gojekUrl = URL(string: gojekHooks)
        if UIApplication.shared.canOpenURL(gojekUrl!) {
            UIApplication.shared.open(gojekUrl!, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.open(URL(string: "https://apps.apple.com/id/app/gojek/id944875099")!, options: [:], completionHandler: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ConfirmPaymentViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count + 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < foods.count {
            let cellFood = tableView.dequeueReusableCell(withIdentifier: "orderedItemTableViewCell", for: indexPath) as! OrderedItemTableViewCell
            cellFood.data = foods[indexPath.row]
            
            return cellFood
        }
        else if indexPath.row == foods.count {
            let cellSub = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellSub.leftLabel.text = "Subtotal"
            cellSub.rightLabel.text = "Rp. 130.000"
            
            return cellSub
        }
        else if indexPath.row == (foods.count + 1) {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellTax.leftLabel.text = "Tax"
            cellTax.rightLabel.text = "Rp. 13.000"
            
            return cellTax
        }
        else if indexPath.row == (foods.count + 2) {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = "Rp. 143.000"
            
            return cellTotal
        }
        else if indexPath.row == (foods.count + 3) {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cellPickup.leftLabel.text = "Pick Up Time"
            cellPickup.rightLabel.text = "12.00"
            
            return cellPickup
        }
        else if indexPath.row == (foods.count + 4) {
        let cellPayment = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell", for: indexPath) as! DetailsTableViewCell
        
            cellPayment.leftLabel.text = "Payment Method"
            cellPayment.rightLabel.text = "GOPAY"
        
        return cellPayment
        }
        
        let cellButton = tableView.dequeueReusableCell(withIdentifier: "QRTableViewCell", for: indexPath) as! QRTableViewCell
        
        cellButton.QRImageView.image = merchants.QRMerchant
        
        cellButton.confirmPaymentButton.setTitle("Confirm Payment", for: .normal)
        cellButton.confirmPaymentButton.setTitleColor(.black, for: .normal)
        
        return cellButton
    }


}
