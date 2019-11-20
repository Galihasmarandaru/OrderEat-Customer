//
//  OnGoingViewModel.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 06/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation


enum statusOperation {
    case zero, one, two, three, four
}

class OnGoingViewModel{
    var transactions : [Transaction]? {
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
    func fetchTransactions() {
        isLoading = true

        APIRequest.getTransactions(customerId: CurrentUser.id) { (transactions, error) in
            if let error = error {
                self.errorString = error.rawValue
                self.isLoading = false
                return
            }
            self.errorString = nil
            self.isLoading = false
            self.transactions = transactions
        }
    }
}
