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
    var isiCell = OnGoingViewModel.getTransaction()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        historyUnderline.isHidden = true
//        penandaSegmented = 0
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
        return isiCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onGoingCollectionListCellID", for: indexPath) as! OnGoingCollectionListCell
        cell.merchantName.text = isiCell[indexPath.row].merchantName
        cell.orderID.text = "Order No : \(isiCell[indexPath.row].transactionID)"
        cell.orderPrice.text = "Rp \(isiCell[indexPath.row].transactionPrice)"
        cell.orderStatus.text = "Status : \(isiCell[indexPath.row].statusTransaction)"
        cell.orderDate.text = isiCell[indexPath.row].pickUpDate
        cell.orderTime.text = isiCell[indexPath.row].pickUpTime
        cell.layer.cornerRadius = 20
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
        return cell
    }
    
    
}
