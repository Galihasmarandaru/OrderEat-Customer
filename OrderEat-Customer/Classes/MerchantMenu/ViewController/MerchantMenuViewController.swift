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
        backgroundMerchant.image = UIImage(named: "bg-merchat-1")
        merchantTitle.merchant = merchant
        viewOfMenu()
        createConstraint()
        
        attemptFetchMenus(withMerchantId: merchant.id!)
        setupTransaction()
        setupCartTapRecognizer()
        
//        tableView.tableFooterView = UIView().white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func showCart() {
        let inset : CGFloat = 40
        let contentInset : CGFloat = inset + CartView.frame.height - 20
        tableView.contentInset.bottom = contentInset
        
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint.constant = 0 - inset
            self.view.layoutIfNeeded()
            
        }
        

    }

    func hideCart() {
        tableView.contentInset.bottom = 0
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
    
    // MARK: Handle Signin
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        cardViewController = SigninViewController(nibName:"Signin", bundle:nil)
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight + 10, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        animateTransitionIfNeeded(state: nextState, duration: 0.9)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MerchantMenuViewController.handleCardTap(recognzier:)))
        visualEffectView.addGestureRecognizer(tapGestureRecognizer)
    }

    
    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleView)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight + 80
                    self.visualEffectView.removeFromSuperview()
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}

// MARK: Data Menu

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
            }
        }
        
        cell.refreshCartClosure = { [unowned self] in
            if self.transaction.getTotalMenu() == 0 {
                self.hideCart()
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
