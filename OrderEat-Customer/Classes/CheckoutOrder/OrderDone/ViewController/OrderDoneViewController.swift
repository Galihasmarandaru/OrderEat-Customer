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
    var foods = OrderDoneViewModel.getDataMenuPayment()
    var merchants = OrderDoneViewModel.getDataMerchant()
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        // Do any additional setup after loading the view.
    }
    
    func config() {
        self.view.addBackground()
        headerView.layer.masksToBounds = true
        headerView.layer.cornerRadius = 15
        self.orderDoneTableView.tableFooterView = UIView()
        
        image = generateQRCode(from: "A4cae43b4-d3a3-410f-9ea3-1488e03a0de3")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OrderDoneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < foods.count {
            let cellFood = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! ItemTableViewCell
            cellFood.data = foods[indexPath.row]
            
            return cellFood
        }
        else if indexPath.row == foods.count {
            let cellSub = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellSub.leftLabel.text = "Subtotal"
            cellSub.rightLabel.text = "Rp. 130.000"
            
            return cellSub
        }
        else if indexPath.row == (foods.count + 1) {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellTax.leftLabel.text = "Tax"
            cellTax.rightLabel.text = "Rp. 13.000"
            
            return cellTax
        }
        else if indexPath.row == (foods.count + 2){
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "detailTableViewCell", for: indexPath) as! DetailTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = "Rp. 143.000"
            
            return cellTotal
        }
        else {
            let cellQR = tableView.dequeueReusableCell(withIdentifier: "showQRTableViewCell", for: indexPath) as! ShowQRTableViewCell
            
            cellQR.QRImageView.image = image
            cellQR.pickUpTimeLabel.text = "12.00"
            
            return cellQR
        }
    }
}
