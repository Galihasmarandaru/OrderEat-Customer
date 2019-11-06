//
//  OrderSetTimeViewController.swift
//  OrderEat-Customer
//
//  Created by Gregory Kevin on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderSetTimeViewController: UIViewController {

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
//    var foods: [OrderedMenu] = []
    var foods = OrderSetTimeViewModel.getDataMenuTransaction()
    var pickUpTime: String = ""
    var paymentMethod: String = ""
    
    let viewPicker = UIPickerView()
    var paymentMethodData: [String] = [String]()
    
    lazy var datePicker: UIDatePicker = {
        
        let picker = UIDatePicker()
        
        picker.datePickerMode = .time
        
        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .none
        
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background Orange.png")!)
        datePicker.backgroundColor = .white
        viewPicker.backgroundColor = .white
        
        self.orderTableView.tableFooterView = UIView()
        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 15
//        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        pickUpTime = dateFormatter.string(from: sender.date)
    }

    
    func loadData() {
//        let food1 = OrderedMenu.init(image: UIImage(named: "Blackpepper Burger.png")!, name: "Burger", price: 50000, qty: 2)
//        let food2 = OrderedMenu.init(image: UIImage(named: "Blackpepper Burger.png")!, name: "Noodle", price: 25000, qty: 1)
//        let food3 = OrderedMenu.init(image: UIImage(named: "Blackpepper Burger.png")!, name: "Chicken Wings", price: 38000, qty: 3)
//
//        foods.append(food1)
//        foods.append(food2)
//        foods.append(food3)
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

extension OrderSetTimeViewController: UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count + 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < foods.count {
            let cellFood = tableView.dequeueReusableCell(withIdentifier: "ItemOrderedTableViewCell", for: indexPath) as! ItemOrderedTableViewCell
            cellFood.data = foods[indexPath.row]
            
            return cellFood
        }
        else if indexPath.row == foods.count {
            let cellSub = tableView.dequeueReusableCell(withIdentifier: "priceOrderedTableViewCell", for: indexPath) as! PriceOrderedTableViewCell
            cellSub.leftLabel.text = "Subtotal"
            cellSub.rightLabel.text = "Rp. 130.000"
            
            return cellSub
        }
        else if indexPath.row == (foods.count + 1) {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "priceOrderedTableViewCell", for: indexPath) as! PriceOrderedTableViewCell
            cellTax.leftLabel.text = "Tax"
            cellTax.rightLabel.text = "Rp. 13.000"
            
            return cellTax
        }
        else if indexPath.row == (foods.count + 2) {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "priceOrderedTableViewCell", for: indexPath) as! PriceOrderedTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = "Rp. 143.000"
            
            return cellTotal
        }
        else if indexPath.row == (foods.count + 3) {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "pickUpTimeTableViewCell", for: indexPath) as! PickUpTimeTableViewCell
            
            cellPickup.pickUpTimeTextField.inputAccessoryView = addToolBar()

            cellPickup.pickUpTimeTextField.text = pickUpTime
            cellPickup.pickUpTimeTextField.inputView = datePicker
            
            return cellPickup
        }
        else if indexPath.row == (foods.count + 4) {
            let cellPayment = tableView.dequeueReusableCell(withIdentifier: "paymentMethodTableViewCell", for: indexPath) as! PaymentMethodTableViewCell
            
            paymentMethodData = ["GOPAY", "OVO"]
            viewPicker.delegate = self
            
            cellPayment.paymentMethodTextField.inputAccessoryView = addToolBar()
            
            cellPayment.paymentMethodTextField.inputView = viewPicker
            cellPayment.paymentMethodTextField.text = paymentMethod
            
            return cellPayment
        }
        
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

