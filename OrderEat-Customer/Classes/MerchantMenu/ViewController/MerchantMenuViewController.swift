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
    
    @IBOutlet weak var itemSelected: UILabel!
    @IBOutlet weak var priceSelected: UILabel!
    
    @IBOutlet weak var CartView: UIView!
    @IBOutlet var MainView: UIView!
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardViewController:SigninViewController!
    var visualEffectView:UIVisualEffectView!
    
    let cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 65
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0

    
    var bottomConstraint: NSLayoutConstraint!
    
    var selectedItem: Int!
    var qtyItem: Int!
        
    var totalItem: Int!
    var dataItem: [Int] = [0]
    var totalItemArray: [Int] = [0]
    var totalQtyArray: [Int] = [0]
    
    var totalCount: Int!
    var totalQty: Int!
    
    var total: Int = 0
    var menuCell = MenuTableViewCell()
//    lazy var theData = AddDataMerchantMenu.getDataMenu(dataTransaction: 0)
    
    // Injection
    let viewModel = MerchantMenuViewModel()
    
    var merchant : Merchant!
    var menus = [Menu]()
    
    var transaction : Transaction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        merchantTitle.data = AddDataMerchantMenu.getDataMerchant()
        backgroundMerchant.image = UIImage(named: "bg-merchat-1")
        merchantTitle.merchant = merchant
        viewOfMenu()
        createConstraint()
        
        attemptFetchMenus(withMerchantId: merchant.id!)
        setupTransaction()
        setupCartTapRecognizer()
        //transaction = DecodeTest.attemptDecodeTransaction()
        
//        tableView.tableFooterView = UIView().white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //tabBarController.setta
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func attemptFetchMenus(withMerchantId merchantId : String) {
        viewModel.fetchMenu(withMerchantId: merchantId)
        
        viewModel.didFinishFetch = {
            self.menus = self.viewModel.menus!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTransaction() {
        transaction = Transaction(merchantId: merchant.id!)
        transaction.merchant = merchant
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
    
//    MARK: Update Cart
    
    func updatePlusQty(_ tag: Int) {
        incrementQty(tag: tag)
        updateCart(tag: tag)
        printtCart()
    }
    
    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    func didPressButtonAdd(_ tag: Int) {
        if (tableCell[tag] == 0) {
            incrementQty(tag: tag)
            updateCart(tag: tag)
            printtCart()
        }
    }
    
    func incrementQty(tag: Int) {
        theData[tag].qty += 1
    }
    
    func decrementQty(tag: Int) {
        theData[tag].qty -= 1
    }

    
    func updateCart(tag: Int) {
        totalQtyArray[tag] = theData[tag].qty
        tableCell[tag] = theData[tag].priceMenu * theData[tag].qty
        dataItem = tableCell.filter { $0 != 0 }.count
        totalItem = theData[tag].priceMenu * tableCell[tag]
        printtCart()

    }
    
    func printtCart() {
        totalQty = totalQtyArray.reduce(0, +)
        totalCount = tableCell.reduce(0, +)
        priceSelected.text = String(totalCount)
        itemSelected.text = String(dataItem) + " Item"
    }
    
    func didPressButtonCart(_ tag: Int) {

    }
    
    // MARK: Handle Signin
    func setupCard() {
        let storyboard = UIStoryboard(name:"Signin", bundle:nil)
        let showCardVC = storyboard.instantiateViewController(identifier: "Signin") as! SigninViewController
        self.present(showCardVC, animated: true, completion: nil)
        
    }
    
}

// MARK: Data Menu Merchant

extension MerchantMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? MenuTableViewCell else {return UITableViewCell()}
        
        // assign menu data to cell
        cell.detail = TransactionDetail(menu: menus[indexPath.row])
        
        cell.addBtnClosure = { [unowned self] in
            self.transaction.details?.append(cell.detail)
            if self.transaction.getTotalMenu() == 1 {
                self.showCart()
                print("Cart show")
            }
        }
        
        cell.refreshCartClosure = { [unowned self] in
            if self.transaction.getTotalMenu() == 0 {
                self.hideCart()
                print("Cart hide")
            }
            else {
                let totalMenu = self.transaction.getTotalMenu()
                self.itemSelected.text = "\(totalMenu) item" + (totalMenu > 1 ? "s" : "")
                self.priceSelected.text = "Rp. \(self.transaction.getSubTotalPrice())"
            }
        }
        
        cell.checkCartClosure = { [unowned self] in
            self.transaction.details!.removeAll(where: {$0.qty == 0})
        }

        return cell
    }
}
