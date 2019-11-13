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
        let isiTable:[Merchant] = [Merchant(merchantID: "1", merchantName: "Burger King", QRMerchant: UIImage.init(named: "qr.png")!, merchantAddress: "BSD City", merchantImage: UIImage(named: "BK.png")), Merchant(merchantID: "2", merchantName: "Onezo", QRMerchant: UIImage.init(named: "qr.png")!, merchantAddress: "Intermoda BSD", merchantImage: UIImage.init(named: "BK.png")), Merchant(merchantID: "3", merchantName: "Burgushi", QRMerchant: UIImage.init(named: "qr.png")!, merchantAddress: "Summarecon Mall Serpong", merchantImage: UIImage.init(named: "BK.png"))]
        return isiTable
    }
    */
    
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
