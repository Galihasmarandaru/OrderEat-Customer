//
//  ListMerchantTableViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit



class ListMerchantTableViewController: UITableViewController{

    let isiTable:[Test] = [Test(from: "Burger King", restorAddress: "Aeon Mall"),Test(from: "Onezo", restorAddress: "Aeon Mall"),Test(from: "Yoshinoya", restorAddress: "Aeon Mall"),]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return isiTable.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! ListMerchantTableViewCell
        cell.merchantName.text = isiTable[indexPath.row].restoName
        cell.merchantADdress.text = isiTable[indexPath.row].restoAddress
        return cell
    }



}
