//
//  OnGoingViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OnGoingViewController: UIViewController {

    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var onGoingButton: UIButton!
    @IBOutlet weak var onGoingUnderline: UIImageView!
    @IBOutlet weak var historyUnderline: UIImageView!
    var isiCell = OnGoingViewModel.getTransaction()
    var a = OnGoingCollectionCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        historyUnderline.isHidden = true
        setupCollection()
        penandaSegmented = 0
    }
    
    @IBAction func onGoingClicked(_ sender: Any) {
        onGoingUnderline.isHidden = false
        historyUnderline.isHidden = true
        onGoingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        historyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        historyView.isHidden = true
    }
    
    @IBAction func historyClicked(_ sender: Any)
    {
        onGoingUnderline.isHidden = true
        historyUnderline.isHidden = false
        onGoingButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        historyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        historyView.isHidden = false
    }

}

extension OnGoingViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isiCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnGoingCollectionViewCell
        cell.merchantName.text = isiCell[indexPath.row].merchantName
        cell.transactionID.text = "Order No : \(isiCell[indexPath.row].transactionID)"
        cell.transactionPrice.text = "Rp \(isiCell[indexPath.row].transactionPrice)"
        cell.statusTransaction.text = "Status : \(isiCell[indexPath.row].statusTransaction)"
        cell.transactionDate.text = isiCell[indexPath.row].pickupDate
        cell.transactionTime.text = isiCell[indexPath.row].pickUpTime
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
        return cell
    }
    
    
}
