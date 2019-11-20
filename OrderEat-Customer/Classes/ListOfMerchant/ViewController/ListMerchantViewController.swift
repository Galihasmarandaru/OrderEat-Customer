//
//  ListMerchantViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit


class ListMerchantViewController: UIViewController {

    @IBOutlet weak var merchantTableView: UITableView!

    // Injection
    let viewModel = ListOfMerchantViewModel()
    
    // Array
    var merchants : [Merchant] = []
    var filteredMerchants : [Merchant] = []
    var selectedMerchant : Merchant!
    
    let searchController = UISearchController(searchResultsController: nil)
    var isFiltering : Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty : Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        merchantTableView.tableFooterView = UIView()
        
        setupSearchController()
        
        attemptFetchMerchants()
        
        let image = #imageLiteral(resourceName: "mcd")
        let upload = UploadImage()
        upload.uploadImage(image: image)
        
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder  = "Where do you want to eat?"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func attemptFetchMerchants() {
        viewModel.fetchMerchants()
        
        viewModel.updateLoadingStatus = {
            
        }
        
        viewModel.showAlertClosure = {
            if let errorString = self.viewModel.errorString {
                Alert.showErrorAlert(on: self, title: errorString) {
                    self.viewModel.fetchMerchants()
                }
            }
        }
        
        viewModel.didFinishFetch = {
            if let merchants = self.viewModel.merchants {
                self.merchants = merchants
            }
            
            DispatchQueue.main.async {
                self.merchantTableView.reloadData()
            }
        }
    }
    
    func filterContentsForSearch(_ searchText: String) {
        filteredMerchants = merchants.filter({ (merchant) -> Bool in
            return (merchant.name?.lowercased().contains(searchText.lowercased()))!
        })
        
        merchantTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MerchantMenuViewController
        
        vc.merchant = selectedMerchant
    }
}

extension ListMerchantViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMerchants.count
        }
        else {
            return merchants.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListMerchantTableViewCell
        
        if isFiltering {
            cell.merchant = filteredMerchants[indexPath.row]
        }
        else {
            cell.merchant = merchants[indexPath.row]
        }
        
        return cell
    }
    
    //MARK:: DidSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListMerchantTableViewCell

        selectedMerchant = cell.merchant
        
        performSegue(withIdentifier: "toMerchantMenu", sender: nil)
    }
}

extension ListMerchantViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentsForSearch(searchController.searchBar.text!)
    }
}

