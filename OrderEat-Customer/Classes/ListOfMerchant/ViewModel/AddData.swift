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
    /*
    static func getDataMerchant() -> [Merchant]{
        let isiTable:[Merchant] = [Merchant(merchantID: "1", merchantName: "Burger King", QRMerchant: UIImage.init(named: "qr.png")!, merchantAddress: "BSD City", merchantImage: UIImage(named: "mcd")), Merchant(merchantID: "2", merchantName: "Onezo", QRMerchant: UIImage.init(named: "qr.png")!, merchantAddress: "Intermoda BSD", merchantImage: UIImage.init(named: "bk.spain_.bannernassicabrandpage.1080x1080_0")), Merchant(merchantID: "3", merchantName: "Burgushi", QRMerchant: UIImage.init(named: "qr.png")!, merchantAddress: "Summarecon Mall Serpong", merchantImage: UIImage.init(named: "WingstopMeal_Lead"))]
        return isiTable
    }
    */
    
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
