//
//  OnGoingViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OnGoingViewController: UIViewController {

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
//        penandaSegmented = 0
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(attemptFetchTransactions), for: .valueChanged)
        onGoingCollectionView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        attemptFetchTransactions()
    }
    
    @objc private func attemptFetchTransactions() {
        viewModel.fetchTransactions()
        
        viewModel.didFinishFetch = {
            self.transactions = self.viewModel.transactions!
            
            DispatchQueue.main.async {
                self.onGoingCollectionView.reloadData()
                
                self.onGoingCollectionView.refreshControl?.endRefreshing()
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
//        return isiCell.count
        
        print(transactions.count)
        return transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onGoingCollectionListCellID", for: indexPath) as! OnGoingCollectionListCell
        
        cell.transaction = transactions[indexPath.row]
        cell.layer.cornerRadius = 20
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
            
        case 2, 3: // On Process           
            let storyboard = UIStoryboard(name: "OrderDone", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "OrderDone") as! OrderDoneViewController

            vc.transaction = transactions[indexPath.row]

            self.present(vc, animated: true, completion: nil)
            
//        case 3: // Ready To Pick Up
//            let storyboard = UIStoryboard(name: "OrderDone", bundle: nil)
//            let vc = storyboard.instantiateViewController(identifier: "OrderDone") as! OrderDoneViewController
//
//            vc.transaction = transactions[indexPath.row]
//
//            self.present(vc, animated: true, completion: nil)
        default:
            break;
        }
    }
}
