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
    func fetchTransactions() {
        APIRequest.getTransactions(customerId: CurrentUser.id) { (transactions) in
            self.transactions = transactions
        }
    }
}
