//
//  OnGoingViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import PusherSwift

class OnGoingViewController: UIViewController{

    @IBOutlet weak var onGoingCollectionView: UICollectionView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var onGoingButton: UIButton!
    @IBOutlet weak var onGoingUnderline: UIImageView!
    @IBOutlet weak var historyUnderline: UIImageView!
    
    // Injection
    var viewModel = OnGoingViewModel()
    
    // Array
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        historyUnderline.isHidden = true
        
        // bind a callback to handle an event
        let _ = PusherChannels.channel.bind(eventName: "NewTransaction", eventCallback: { (event: PusherEvent) in
            if event.data != nil {
                 // you can parse the data as necessary
                 // print(data)
                print("trying refresh ongoing pagee")
                self.attemptFetchTransactions()

               }
           })
        PusherChannels.pusher.connect()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        attemptFetchTransactions()
    }
    
    @objc private func attemptFetchTransactions() {
        viewModel.fetchTransactions()
        
        viewModel.updateLoadingStatus = {
            
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
                self.onGoingCollectionView.reloadData()
            }
        }
    }
    
    func setupCollection(){
        onGoingCollectionView.register(UINib(nibName: "OnGoingCollectionListCell", bundle: nil), forCellWithReuseIdentifier: "onGoingCollectionListCellID")
        onGoingCollectionView.reloadData()
    }
    
    @IBAction func onGoingClicked(_ sender: Any) {
        onGoingUnderline.isHidden = false
        historyUnderline.isHidden = true
        onGoingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        historyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
    }
    
    @IBAction func historyClicked(_ sender: Any)
    {
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
        case 1: // Waiting for payment
            let storyboard = UIStoryboard(name: "ConfirmPayment", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ConfirmPayment") as! ConfirmPaymentViewController
            
            vc.transaction  = transactions[indexPath.row]
            
            self.present(vc, animated: true, completion: nil)
            
        case 2, 3: // On Process , ready to pickup
            let storyboard = UIStoryboard(name: "OrderDone", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "OrderDone") as! OrderDoneViewController

            vc.transaction = transactions[indexPath.row]

            self.present(vc, animated: true, completion: nil)
            
        default:
            break;
        }
    }
}
