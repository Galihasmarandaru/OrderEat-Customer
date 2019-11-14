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
    
    //var isiTable = AddData.getDataMerchant()
    
    var stringMechant = [String]() //INI VARIABLE TAMPUNGAN STRING NAMA RESTO BUAT DI BANDINGIN SAMA VARIABLE SEARCHMERCHANT DI EXTENSIONS SEARCHBAR
    var searchMerchant = [String]() //INI VARIABLE BUAT SEARCHNYA DI PAKE DI EXTENSIONS SEARCHBAR DIBAWAH
    var searching = false //INI VARIABLE NENTUIN APAKAH LAGI SEARCH ATAU TIDAK

    // Injection
    let viewModel = ListOfMerchantViewModel()
    
    // Array
    var merchants = [Merchant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //merchantSearchBar.tintColor = .black
        
        /*
        for isi in isiTable{
            stringMechant.append(isi.merchantName) //INI FUNCTION UNTUK MASUKIN DATA CLASS RESTO ( RESTO NAME ) KE VARIABLE STRINGMERCHANT
        }
        */
        attemptFetchMerchants()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func attemptFetchMerchants() {
        viewModel.fetchMerchants()
        
        viewModel.didFinishFetch = {
            self.merchants = self.viewModel.merchants!
            
            DispatchQueue.main.async {
                self.merchantTableView.reloadData()
            }
        }
    }
}

extension ListMerchantViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        if searching{//INI KALO SEARCH MASUKNYA KESINI
            return searchMerchant.count
        }else{
        return stringMechant.count
        }
        */
        
        return merchants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! ListMerchantTableViewCell
        
        /*
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
        */
        
        cell.merchant = merchants[indexPath.row]
        
        return cell
    }
    
    //MARK:: DidSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let MerchantMenuPage = UIStoryboard(name: "MerchantMenu", bundle: nil).instantiateViewController(withIdentifier: "MerchantMenu") as? MerchantMenuViewController {
            MerchantMenuPage.merchant = merchants[indexPath.row]
            
            if let navigation = navigationController {
                navigation.pushViewController(MerchantMenuPage, animated: true)
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

