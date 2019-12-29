//
//  Int.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 26/12/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

extension Int {
    
    var asPrice : String {
          let currencyValue:Int = self
          let formatter = NumberFormatter()
          formatter.numberStyle = .decimal
          formatter.locale = Locale(identifier: "id_ID")
          formatter.groupingSeparator = "."

          let formattedTipAmount = formatter.string(from: NSNumber(value: currencyValue))
          
          return formattedTipAmount!

    }
    
    var asCurrency : String {
        
        return "Rp. " + self.asPrice
    }
}
