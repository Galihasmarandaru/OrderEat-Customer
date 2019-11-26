//
//  MerchantMenuViewController.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MerchantMenuViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backgroundMerchant: UIImageView!
    @IBOutlet weak var merchantTitle: DetailMerchantView!
    @IBOutlet weak var promoTitle: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMenu: UIView!
    
    @IBOutlet weak var itemSelected: UILabel!
    @IBOutlet weak var priceSelected: UILabel!
    
    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var CartView: UIView!
    
    @IBOutlet weak var menuViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    
    var isScrollingDown : Bool! {
        didSet {
            if isScrollingDown {
                print("Content Down")
            }
            else
            {
                print("Content Up")
            }
        }
    }
    
    var selectedItem: Int!
    var qtyItem: Int!
    
    // Injection
    let viewModel = MerchantMenuViewModel()
    
    var merchant : Merchant!
    var menus = [Menu]()
    
    var transaction : Transaction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        merchantTitle.merchant = merchant
        viewOfMenu()
        createConstraint()
        
        attemptFetchMenus(withMerchantId: merchant.id!)

        setupCartTapRecognizer()
        
        backBtn.layer.cornerRadius = backBtn.frame.height/2
        
        tableView.tableFooterView = UIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func attemptFetchMenus(withMerchantId merchantId : String) {
        viewModel.fetchMenu(withMerchantId: merchantId)
        
        viewModel.updateLoadingStatus = {
            
        }
        
        viewModel.showAlertClosure = {
            if let errorString = self.viewModel.errorString {
                Alert.showErrorAlert(on: self, title: errorString) {
                    self.viewModel.fetchMenu(withMerchantId: merchantId)
                }
            }
        }
        
        viewModel.didFinishFetch = {
            self.menus = self.viewModel.menus!
            self.setupTransaction()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTransaction() {
        transaction = Transaction(merchantId: merchant.id!)
        transaction.merchant = merchant
        for i in 0..<menus.count {
            let detail = TransactionDetail(menu: menus[i])
            detail.menuId = menus[i].id
            transaction.details?.append(detail)
        }
    }
    
    func setupCartTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.cartTapAction))
        CartView.addGestureRecognizer(tap)
    }
    
    func viewOfMenu() {
        self.viewMenu.layer.cornerRadius = 20
        self.viewMenu.layer.shadowColor = UIColor.black.cgColor
        self.viewMenu.layer.shadowOpacity = 0.2
        self.viewMenu.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.viewMenu.layer.shadowRadius = 5
        self.viewMenu.layer.masksToBounds = false
    }
    
//    MARK: Cart Animation
    func showCart() {
        let inset : CGFloat = 40
        
        UIView.animate(withDuration: 0.3) {
            self.tableViewBottomConstraint.constant = inset + self.CartView.frame.height + 20
            self.bottomConstraint.constant = 0 - inset
            self.view.layoutIfNeeded()
        }
    }

    func hideCart() {
        UIView.animate(withDuration: 0.3) {
            self.tableViewBottomConstraint.constant = 0
            self.bottomConstraint.constant = 100
            self.view.layoutIfNeeded()
        }
    }

    @objc func cartTapAction() {
        if let orderSetTimeVC = UIStoryboard(name: "OrderSetTime", bundle: nil).instantiateViewController(identifier: "OrderSetTime") as? OrderSetTimeViewController {
            
            orderSetTimeVC.transaction = self.transaction
            orderSetTimeVC.merchantMenuVC = self

            self.present(orderSetTimeVC, animated: true, completion: nil)
        }
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

// MARK: Data Menu Merchant

extension MerchantMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! MenuTableViewCell
        
        let row = indexPath.row
        
        cell.detail = transaction.details![row]
        cell.menu =  menus[row]
        
        cell.addBtnClosure = { [unowned self] in
            if self.transaction.getTotalMenu() == 0 {
                self.showCart()
            }
        }
        
        cell.minusBtnClosure = { [unowned self] in
            if self.transaction.getTotalMenu() == 0 {
                self.hideCart()
            }
        }
        
        cell.refreshCartClosure = { [unowned self] in
            if self.transaction.getTotalMenu() != 0 {
                let totalMenu = self.transaction.getTotalMenu()
                self.itemSelected.text = "\(totalMenu) item" + (totalMenu > 1 ? "s" : "")
                self.priceSelected.text =  "Rp. \(self.transaction.getSubTotalPrice().currencyFormat)"
            }
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = tableView.contentOffset.y
        let limit : CGFloat = 300.0
        //let maxLimit : CGFloat = 600.0
        
        let isScrollingDown : Bool = contentOffset > limit

        if isScrollingDown != self.isScrollingDown {
            self.isScrollingDown = isScrollingDown
        }

        if !isScrollingDown {
            let progress = contentOffset / limit

            //topBarView.alpha = contentOffset / limit

            menuViewTopConstraint.constant = (1 - progress/2) * 215.0
            self.view.layoutIfNeeded()
        }
    }
}
