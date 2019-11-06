//
//  OnGoingViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OnGoingViewController: UIViewController {

    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var onGoingButton: UIButton!
    @IBOutlet weak var onGoingUnderline: UIImageView!
    @IBOutlet weak var historyUnderline: UIImageView!
    var isiCell = OnGoingViewModel.getTransaction()
    override func viewDidLoad() {
        super.viewDidLoad()
        historyUnderline.isHidden = true

        // Do any additional setup after loading the view.
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnGoingCollectionViewCell
        cell.merchantName.text = isiCell[indexPath.row].merchantName
        cell.transactionID.text = isiCell[indexPath.row].transactionID
        cell.transactionPrice.text = "Rp \(isiCell[indexPath.row].transactionPrice)"
        cell.statusTransaction.text = isiCell[indexPath.row].statusTransaction
        cell.transactionDate.text = isiCell[indexPath.row].pickupDate
        cell.transactionTime.text = isiCell[indexPath.row].pickupTime
        return cell
    }
    
    
}
