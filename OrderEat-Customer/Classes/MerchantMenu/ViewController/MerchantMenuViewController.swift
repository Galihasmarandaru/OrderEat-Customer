//
//  MerchantMenuViewController.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MerchantMenuViewController: UIViewController {

    @IBOutlet weak var backgroundMerchant: UIImageView!
    @IBOutlet weak var merchantTitle: DetailMerchantView!
    @IBOutlet weak var promoTitle: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMenu: UIView!
    
    @IBOutlet weak var CartView: UIView!
    @IBOutlet var MainView: UIView!
    
    var bottomConstraint: NSLayoutConstraint!
        
    var theData = AddDataMerchantMenu.getDataMenu()
    var menuCell = MenuTableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        merchantTitle.data = AddDataMerchantMenu.getDataMerchant()
        backgroundMerchant.image = UIImage(named: "bg-merchat-1")
        viewOfMenu()
        createConstraint()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func viewOfMenu() {
        self.viewMenu.layer.cornerRadius = 20
        self.viewMenu.layer.shadowColor = UIColor.black.cgColor
        self.viewMenu.layer.shadowOpacity = 0.2
        self.viewMenu.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.viewMenu.layer.shadowRadius = 5
        self.viewMenu.layer.masksToBounds = false
    }
    
    func showCart() {
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint.constant = -50
            self.view.layoutIfNeeded()
        }
    }

    func hideCart() {
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint.constant = 100
            self.view.layoutIfNeeded()
        }
    }

    @objc func AddAction() {
        print("Berhasil")
    }
    
    func createConstraint() {
        CartView.translatesAutoresizingMaskIntoConstraints = false
        CartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomConstraint = CartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100)
        bottomConstraint.isActive = true
        CartView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        CartView.widthAnchor.constraint(equalToConstant: 325).isActive = true
    }

    
}


extension MerchantMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? MenuTableViewCell else {return UITableViewCell()}
        cell.data = theData[indexPath.row]
        
        cell.activityCart = { [unowned self] in
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.AddAction))
            self.CartView.addGestureRecognizer(tap)
            self.showCart()
        }
        
        cell.hideCartAction = { [unowned self] in
            self.hideCart()
        }
        
        return cell
    }
    
}
