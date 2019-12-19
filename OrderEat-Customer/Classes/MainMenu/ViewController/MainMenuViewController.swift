//
//  MainMenuViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 28/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var mainMenuTableView: UITableView!
    let categoriesViewModel = CategoriesViewModel()
    let todaysViewModel = TodaysViewModel()
   
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
        setupSearchController()
        
        attemptFetchMerchants()

        
    }
    
    func setupSearchController() {
        //searchController.searchResultsUpdater = self as! UISearchResultsUpdating
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
                self.mainMenuTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMerchantMenu" {
            let vc = segue.destination as! MerchantMenuViewController
            
            vc.merchant = selectedMerchant
        }
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        print("LOGOUT")
        
         PusherBeams.removeDeviceInterest(pushInterest: CurrentUser.id)
         PusherChannels.pusher.unsubscribeAll()
         
         Defaults.clearUserData()
         CurrentUser.reset()
         
         let storyboard = UIStoryboard(name: "Signin", bundle: nil)
         let vc = storyboard.instantiateViewController(identifier: "Signin") as! SigninViewController
         let appDelegate = UIApplication.shared.windows
         appDelegate.first?.rootViewController = vc
    }
    


}
extension MainMenuViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
        let sizeWidth = (collectionView.frame.width-22)/3
        let sizeHeight = (collectionView.frame.height)/2
        return CGSize(width: sizeWidth, height: sizeHeight)
        }
        else{
            let sizeWidth = collectionView.frame.width
            print("size cell ", sizeWidth)
            let sizeHeight = collectionView.frame.height
            print("size cell ", sizeHeight)
            return CGSize(width: sizeWidth, height: sizeHeight)
            
        }
    }
   }

extension MainMenuViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2 {
            return 1
        }else if section == 3 {
            return merchants.count
        }else{
            return imageArr.count
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cellCategory = tableView.dequeueReusableCell(withIdentifier: "cellCategories", for: indexPath) as! CategoriesTableViewCell
            cellCategory.categoriesViewCell.register(UINib(nibName: "MainMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainMenuCollectionCell")
            cellCategory.categoriesViewCell.delegate = self
            cellCategory.categoriesViewCell.dataSource = categoriesViewModel
            return cellCategory
        }
        else if indexPath.section == 1{
            let cellToday = tableView.dequeueReusableCell(withIdentifier: "cellToday", for: indexPath) as! TodayDealTableViewCell
            cellToday.todayViewCell.register(UINib(nibName: "TodayDealCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TodayDealCollectionCell")
            tableView.separatorStyle = .none
            cellToday.todayViewCell.delegate = self
            cellToday.todayViewCell.dataSource = todaysViewModel
            
            return cellToday
        }
        else if indexPath.section == 2 {
            let cellLabelOurPicks = tableView.dequeueReusableCell(withIdentifier: "labelOurPick", for: indexPath) as! LabelOurPickTableViewCell
            return cellLabelOurPicks
        }
        else if indexPath.section == 3 {
            
            let cellOurPicks = tableView.dequeueReusableCell(withIdentifier: "cellOurPicks", for: indexPath) as! OurPicksTableViewCell
            
//            cellOurPicks.imageOurPick.image = imageArr[indexPath.row]
//            cellOurPicks.restoNameLabel.text = "BURGER KING"
//            cellOurPicks.restoAddressLabel.text = "Aeon Mall"
//            cellOurPicks.restoDetailLabel.text = "6 km"
//            return cellOurPicks
            
            cellOurPicks.merchant = merchants[indexPath.row]
            return cellOurPicks
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // how to identify which cell is selected ?
        
        if indexPath != IndexPath(row: 0, section: 2) {
            let cell = tableView.cellForRow(at: indexPath) as! OurPicksTableViewCell
            selectedMerchant = cell.merchant
            
            performSegue(withIdentifier: "toMerchantMenu", sender: nil)
        }

    }
}
