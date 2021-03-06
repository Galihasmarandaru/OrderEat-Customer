//
//  OrderSetTimeViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderSetTimeViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var merchantNameLbl: UILabel!
    
    var pickUpTime : Date?
    var paymentMethod: String = "GOPAY"
    
    let viewPicker = UIPickerView()
    var paymentMethodData: [String] = ["GOPAY", "OVO"]
    
    lazy var datePicker: UIDatePicker = {
        
        let picker = UIDatePicker()
        
        picker.datePickerMode = .time
        picker.minuteInterval = 10
        
        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }()
    
    var merchantMenuVC : MerchantMenuViewController!
    
    // Array
    var transaction : Transaction! {
        didSet {
            transaction.details!.removeAll(where: {$0.qty == 0})
            details = transaction.details!
            transaction.total = transaction.getSubTotalPrice() + transaction.getTaxPrice()
            transaction.discountedTotal = transaction.total! - transaction.getDiscount()
        }
    }
    
    var details : [TransactionDetail]!
    var subtotal : Int!
    var tax : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        pickUpTime = Calendar.current.date(byAdding: .minute, value: 10, to: Date())?.roundedByTenMinute
        merchantNameLbl.text = transaction.merchant?.name!
    }
    
    func config() {
        self.view.addBackground()
        datePicker.backgroundColor = .white
        viewPicker.backgroundColor = .white
        
        self.orderTableView.tableFooterView = UIView()
        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 15
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        pickUpTime = sender.date
    }

    @IBAction func confirmOrderButtonClicked(_ sender: Any) {
        transaction.pickUpTime = pickUpTime!.string
        
        APIRequest.post(.transactions, object: transaction) { (id, error) in
            self.transaction.id = id
            self.transaction.pickUpTime = self.pickUpTime!.string
            
            let storyboard02 = UIStoryboard(name: "Home", bundle: nil)
            DispatchQueue.main.async {
                
                let tabBarVC = storyboard02.instantiateViewController(identifier: "tabBar") as! UITabBarController
                tabBarVC.selectedIndex = 1
                
                let ongoingVC = tabBarVC.viewControllers![1] as! OnGoingViewController
                ongoingVC.isWaitingForConfirmation = true
                ongoingVC.pendingTransaction = self.transaction
                
                let appDelegate = UIApplication.shared.windows
                
                appDelegate.first?.rootViewController = tabBarVC
            }
        }
    }
}

extension OrderSetTimeViewController: UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return details.count + 6
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < details.count {
            let cellFood = tableView.dequeueReusableCell(withIdentifier: "ItemOrderedTableViewCell", for: indexPath) as! ItemOrderedTableViewCell
            cellFood.detail = details[indexPath.row]

            return cellFood
        }
        else if indexPath.row == details.count {
            let cellSub = tableView.dequeueReusableCell(withIdentifier: "priceOrderedTableViewCell", for: indexPath) as! PriceOrderedTableViewCell
            cellSub.leftLabel.text = "Subtotal"
            cellSub.rightLabel.text = transaction.getSubTotalPrice().asCurrency

            return cellSub
        }
        else if indexPath.row == (details.count + 1) {
            let cellDiscount = tableView.dequeueReusableCell(withIdentifier: "priceOrderedTableViewCell", for: indexPath) as! PriceOrderedTableViewCell

            cellDiscount.leftLabel.text = "Discount (\(Int(transaction.merchant!.discount! * 100))%)"
            cellDiscount.rightLabel.text = "- " + transaction.getDiscount().asPrice
            
            return cellDiscount
        }
        else if indexPath.row == (details.count + 2) {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "priceOrderedTableViewCell", for: indexPath) as! PriceOrderedTableViewCell

            cellTax.leftLabel.text = "Tax (\(Int(transaction.merchant!.tax! * 100))%)"
            cellTax.rightLabel.text = transaction.getTaxPrice().asPrice
            
            return cellTax
        }
        else if indexPath.row == (details.count + 3) {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "priceOrderedTableViewCell", for: indexPath) as! PriceOrderedTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = transaction.discountedTotal!.asCurrency
            
            return cellTotal
        }
        else if indexPath.row == (details.count + 4) {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "pickUpTimeTableViewCell", for: indexPath) as! PickUpTimeTableViewCell

            cellPickup.pickUpTimeTextField.inputAccessoryView = addToolBar()
            
            cellPickup.pickUpTimeTextField.text = pickUpTime?.time
            datePicker.date = pickUpTime!
            
            cellPickup.datePicker = datePicker
                        
            cellPickup.pickUpTimeTextField.becomeFirstResponder()
            
            return cellPickup
        }
//        else if indexPath.row == (details.count + 4) {
//            let cellPayment = tableView.dequeueReusableCell(withIdentifier: "paymentMethodTableViewCell", for: indexPath) as! PaymentMethodTableViewCell
//
//            paymentMethodData = ["GOPAY", "OVO"]
//            viewPicker.delegate = self
//
//            cellPayment.paymentMethodTextField.inputAccessoryView = addToolBar()
//
//            cellPayment.paymentMethodTextField.inputView = viewPicker
//            cellPayment.paymentMethodTextField.text = paymentMethod
//
//            return cellPayment
//        }
        
        let cellButton = tableView.dequeueReusableCell(withIdentifier: "confirmOrderButtonTableViewCell", for: indexPath) as! ConfirmOrderButtonTableViewCell
        
        cellButton.confirmOrderButton.setTitle("Confirm Order", for: .normal)
        cellButton.confirmOrderButton.setTitleColor(.black, for: .normal)
        
        return cellButton
    }
    
    func addToolBar() -> UIToolbar {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paymentMethodData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return paymentMethodData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentMethod = paymentMethodData[row]
    }
    
    @objc func doneButtonAction()
    {
        view.endEditing(true)
        self.orderTableView.reloadData()
    }
    
}
