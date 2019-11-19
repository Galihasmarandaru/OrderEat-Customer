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
    
    var error : Error? {
        didSet {
            
        }
    }
    
    var isLoading : Bool = false {
        didSet {
            print()
        }
    }
    
    // Closures for callback
    var showAlertClosure : (() -> ())?
    var updateLoadingStatus : (() -> ())?
    var didFinishFetch : (() -> ())?
    
    //Network call
    func fetchMerchants() {
        APIRequest.getMerchants { (merchants) in
            self.merchants = merchants
        }
    }
}
