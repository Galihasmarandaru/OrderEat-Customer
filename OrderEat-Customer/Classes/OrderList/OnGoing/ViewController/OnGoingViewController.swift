//
//  OnGoingViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import PusherSwift
import Lottie

class OnGoingViewController: UIViewController{

    @IBOutlet weak var onGoingCollectionView: UICollectionView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var onGoingButton: UIButton!
    @IBOutlet weak var onGoingUnderline: UIImageView!
    @IBOutlet weak var historyUnderline: UIImageView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var emptyStateView: UIStackView!
    
    @IBOutlet weak var beliYukButton: UIButton!
    
    @IBOutlet weak var noTransactionImage: UIImageView!
    @IBOutlet weak var noTransactionLabel: UILabel!
    
    var isWaitingForConfirmation : Bool = false
    var pendingTransaction : Transaction!
    
    enum noTransactionImageList: String {
        case noOngoing = "No Order"
        case noHistory = "No Orderr"
    }
    enum noTransactionLblText: String{
        case noOngoing = "There is no ongoing transaction"
        case noHistory = "There is no finish transaction yet"
    }
    
    // Injection
    var viewModel = OnGoingViewModel()
    
    // Array
    var transactions = [Transaction]()
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        historyUnderline.isHidden = true
        beliYukButton.isHidden = false
        // bind a callback to handle an event
        let _ = PusherChannels.channel.bind(eventName: "Transaction", eventCallback: { (event: PusherEvent) in
            
            if event.data != nil {
                 // you can parse the data as necessary
                
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
               }
           })
        

        DispatchQueue.main.async {
            print(self.isWaitingForConfirmation)
            if self.isWaitingForConfirmation {
                let storyboard01 = UIStoryboard(name: "WaitingforRestoConfirm", bundle: nil)
                let waitingConfirmationPageVC = storyboard01.instantiateViewController(identifier: "WaitingforRestoConfirm") as! WaitingforRestoConfirmViewController

                waitingConfirmationPageVC.transaction = self.pendingTransaction
                print(self.pendingTransaction)
                
                self.present(waitingConfirmationPageVC, animated: true, completion: nil)
                
            }
        }
        
        let collectionViewLayout = onGoingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 25, right: 0)
        collectionViewLayout?.invalidateLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        attemptFetchTransactions()
        PusherChannels.pusher.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        PusherChannels.pusher.disconnect()
    }
    
    @IBAction func beliYukClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ListOfMerchant", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ListOfMerchant") as! ListMerchantViewController
        let appDelegate = UIApplication.shared.windows
        appDelegate.first?.rootViewController = vc
    }
    func startAnimation() {
        DispatchQueue.main.async {
            self.emptyStateView.isHidden = true
            self.animationView.isHidden = false
        }
        
        let animation = Animation.named("loading")
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        
        animationView.loopMode  = .loop
        
        animationView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
        
        DispatchQueue.main.async {
            self.animationView.isHidden = true
        }
        
    }
    
    @objc func attemptFetchTransactions() {
        viewModel.fetchTransactions()
        
        viewModel.updateLoadingStatus = {
            //let _ = self.viewModel.isLoading ? self.startAnimation() : self.stopAnimation()
        }
        
        viewModel.showAlertClosure = {
            if let errorString = self.viewModel.errorString {
                Alert.showErrorAlert(on: self, title: errorString) {
                    self.viewModel.fetchTransactions()
                }
            }
        }
        
        viewModel.didFinishFetch = {
            if let transactions = self.viewModel.transactions {
                self.transactions = transactions
            }
            
            DispatchQueue.main.async {
                self.emptyStateView.isHidden = self.transactions.count > 0
                
                self.onGoingCollectionView.reloadData()
            }
        }
    }
    
    @objc func attemptFetchHistory() {
        viewModel.fetchHistory()
        
        viewModel.updateLoadingStatus = {
            //let _ = self.viewModel.isLoading ? self.startAnimation() : self.stopAnimation()
        }
        
        viewModel.showAlertClosure = {
            if let errorString = self.viewModel.errorString {
                Alert.showErrorAlert(on: self, title: errorString) {
                    self.viewModel.fetchTransactions()
                }
            }
        }
        
        viewModel.didFinishFetch = {
            if let transactions = self.viewModel.transactions {
                self.transactions = transactions
            }
            
            DispatchQueue.main.async {
                
                self.emptyStateView.isHidden = self.transactions.count > 0
                
                self.onGoingCollectionView.reloadData()
            }
        }
    }
    
    func setupCollection(){
        onGoingCollectionView.register(UINib(nibName: "OnGoingCollectionListCell", bundle: nil), forCellWithReuseIdentifier: "onGoingCollectionListCellID")
        
        noTransactionImage.image = UIImage(named: noTransactionImageList.noOngoing.rawValue)
        noTransactionLabel.text = noTransactionLblText.noOngoing.rawValue
        
        onGoingCollectionView.reloadData()
    }
    
    @IBAction func onGoingClicked(_ sender: Any) {
        
        attemptFetchTransactions()

        self.emptyStateView.isHidden = true
        noTransactionImage.image = UIImage(named: noTransactionImageList.noOngoing.rawValue)
        noTransactionLabel.text = noTransactionLblText.noOngoing.rawValue
        onGoingUnderline.isHidden = false
        historyUnderline.isHidden = true


        onGoingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        historyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
    }
    
    @IBAction func historyClicked(_ sender: Any)
    {
        attemptFetchHistory()

        self.emptyStateView.isHidden = true
//        noTransactionImage.image = UIImage(named: noTransactionImageList.noOngoing.rawValue)
        noTransactionLabel.text = noTransactionLblText.noHistory.rawValue
        onGoingUnderline.isHidden = true
        historyUnderline.isHidden = false

        onGoingButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        historyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        
    }

}

extension OnGoingViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onGoingCollectionListCellID", for: indexPath) as! OnGoingCollectionListCell
        
        cell.transaction = transactions[indexPath.row]
        cell.view.layer.cornerRadius = 8
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! OnGoingCollectionListCell
        let status = cell.transaction.status!
        
        switch status {
        case 2: // Waiting for payment
            let storyboard = UIStoryboard(name: "ConfirmPayment", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ConfirmPayment") as! ConfirmPaymentViewController
            
            vc.transaction  = transactions[indexPath.row]
            
            self.present(vc, animated: true, completion: nil)
            
        case 3, 4: // On Process , ready to pickup
            let storyboard = UIStoryboard(name: "OrderDone", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "OrderDone") as! OrderDoneViewController

            vc.transaction = transactions[indexPath.row]

            self.present(vc, animated: true, completion: nil)
        default:
            break;
        }
    }
}
