//
//  ListMerchantViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit


class ListMerchantViewController: UIViewController, UISearchControllerDelegate {

    @IBOutlet weak var merchantSearchBar: UISearchBar!
    @IBOutlet weak var merchantTableView: UITableView!
    var isiTable = AddData.getDataMerchant()
    
    var stringMechant = [String]() //INI VARIABLE TAMPUNGAN STRING NAMA RESTO BUAT DI BANDINGIN SAMA VARIABLE SEARCHMERCHANT DI EXTENSIONS SEARCHBAR
    var searchMerchant = [String]() //INI VARIABLE BUAT SEARCHNYA DI PAKE DI EXTENSIONS SEARCHBAR DIBAWAH
    var searching = false //INI VARIABLE NENTUIN APAKAH LAGI SEARCH ATAU TIDAK

    override func viewDidLoad() {
        super.viewDidLoad()
        self.merchantTableView.tableFooterView = UIView()
        merchantSearchBar.tintColor = .black
        for isi in isiTable{
            stringMechant.append(isi.merchantName) //INI FUNCTION UNTUK MASUKIN DATA CLASS RESTO ( RESTO NAME ) KE VARIABLE STRINGMERCHANT
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

extension ListMerchantViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{//INI KALO SEARCH MASUKNYA KESINI
            return searchMerchant.count
        }else{
        return stringMechant.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! ListMerchantTableViewCell
        
        //INI KALO SEARCH MASUKNYA KESINI BUAT NAMPILIN DATA
        if searching {
            for isi in isiTable{
                if isi.merchantName == searchMerchant[indexPath.row]{
                    cell.merchantName.text = isi.merchantName
                    cell.merchantADdress.text = isi.merchantAddress
                    cell.merchantImage.image = isi.merchantImage
                    cell.merchantDistance.text = "-"
                    cell.merchantDistanceTime.text = "-"
                }
            }
        } else { //INI KALO GAK SEARCH NAMPILIN DATANYA DISINI
            cell.merchantName.text = isiTable[indexPath.row].merchantName
            cell.merchantADdress.text = isiTable[indexPath.row].merchantAddress
            cell.merchantImage.image = isiTable[indexPath.row].merchantImage
            cell.merchantDistance.text = "-"
            cell.merchantDistanceTime.text = "-"
        }
        return cell
    }
    
    //MARK:: DidSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let MerchantMenuPage = UIStoryboard(name: "MerchantMenu", bundle: nil).instantiateViewController(withIdentifier: "MerchantMenu") as? MerchantMenuViewController {
            if let navigator = navigationController {
                navigator.pushViewController(MerchantMenuPage, animated: true)
            }
        }
    }
}

extension ListMerchantViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMerchant = stringMechant.filter({$0.prefix(searchText.count) == searchText}) //INI NGEBANDINGIN YANG DIKETIK DI SEARCH SAMA DATA YANG ADA
        searching = true
        merchantTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        merchantTableView.reloadData()
    }
}

