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
    
    var selectedItem: Int!
        
    var total: Int = 1
    var menuCell = MenuTableViewCell()
    lazy var theData = AddDataMerchantMenu.getDataMenu(dataTransaction: total)
    
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

    func didPressButtonAdd(_ tag: Int) {
        selectedItem = theData[tag].priceMenu
        let totalItem = selectedItem * 1
        itemSelected.text = String(totalItem)
    }
    
    func didPressButtonCart(_ tag: Int) {        
        var totalItem = [Int]()
        totalItem = [theData[tag].priceMenu * theData[tag].qty]
        let totalCount = totalItem.reduce(0, +)
        itemSelected.text = String(totalCount)
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
        return theData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? MenuTableViewCell else {return UITableViewCell()}
        cell.data = theData[indexPath.row]
        
        cell.activityCart = { [unowned self] in
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.AddAction))
            self.CartView.addGestureRecognizer(tap)
            self.showCart()
//            self.selectedItem
        }
        
        cell.hideCartAction = { [unowned self] in
            self.hideCart()
        }
        
        cell.cellDelegate = self
        cell.addButton.tag = indexPath.row
        return cell
    }
}
