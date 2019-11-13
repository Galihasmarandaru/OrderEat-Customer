//
//  AddData.swift
//  OrderEat-Customer
//
//  Created by Galih Asmarandaru on 04/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CoreLocation

class MerchantMenuViewModel {
    var menus : [Menu]? {
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
    func fetchMenu(withMerchantId merchantId: String) {
        APIRequest.getMenus(merchantId: merchantId) { (menus) in
            self.menus = menus
        }
    }
}
