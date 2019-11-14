//
//  MerchantMenuViewController.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MerchantMenuViewController: UIViewController, ButtonCellDelegate {

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
    
    var totalItem: Int!
    var dataItem: Int!
    var totalQtyArray = [Int]()
    
    var totalCount: Int!
    
    
    var total: Int = 0
    var menuCell = MenuTableViewCell()
    lazy var theData = AddDataMerchantMenu.getDataMenu(dataTransaction: 0)
    
    var tableCell = [Int]()
    var totalQty: Int!

    
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

    @objc func AddAction() {
            print("Berhasil")
            setupCard()
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

    func updateMinusQty(_ tag: Int) {
        if (totalQty == 1) {
            decrementQty(tag: tag)
            updateCart(tag: tag)
            printtCart()

            hideCart()
        } else {
            decrementQty(tag: tag)
            updateCart(tag: tag)
            printtCart()
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

// MARK: Data Menu

extension MerchantMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let arrayCell = theData.count
        
        tableCell = Array(0...arrayCell-1)
        totalQtyArray = Array(0...arrayCell-1)

        for a in tableCell {
            tableCell[a] = 0
            totalQtyArray[a] = 0
        }
        
        return arrayCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? MenuTableViewCell else {return UITableViewCell()}
        cell.data = theData[indexPath.row]
        
        cell.activityCart = { [unowned self] in
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.AddAction))
            self.CartView.addGestureRecognizer(tap)
            self.showCart()
        }
                
        cell.cellDelegate = self
        cell.addButton.tag = indexPath.row
        cell.plusTap.tag = indexPath.row
        cell.minusTap.tag = indexPath.row
        return cell
    }
}
