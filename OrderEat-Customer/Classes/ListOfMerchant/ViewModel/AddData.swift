//
//  ListViewModel.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 05/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class ListOfMerchantViewModel{
    var merchants : [Merchant]? {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    var errorString : String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var isLoading : Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    // Closures for callback
    var showAlertClosure : (() -> ())?
    var updateLoadingStatus : (() -> ())?
    var didFinishFetch : (() -> ())?
    
    //Network call
    func fetchMerchants() {
        isLoading = true
        
        APIRequest.getMerchants { (merchants, error) in
            if let error = error {
                self.errorString = error.rawValue
                self.isLoading = false
                return
            }
            self.errorString = nil
            self.isLoading = false
            self.merchants = merchants
        }
    }
}
