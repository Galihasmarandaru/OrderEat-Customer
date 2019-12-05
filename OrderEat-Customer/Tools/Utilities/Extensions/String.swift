//
//  String.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    var time : String {
        let formatter = DateFormatter()
        //        formatter.locale = Locale(identifier: "en_US_POSIX")

        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let date = formatter.date(from: self)
        
        formatter.dateFormat = "HH:mm"
        
        let string = formatter.string(from: date!)
        
        return string
    }
    
    var workingHourFormat : String {
        let formatter = DateFormatter()

        formatter.dateFormat = "HH:mm:ss"

        let date = formatter.date(from: self)
        
        formatter.dateFormat = "HH:mm"
        
        let string = formatter.string(from: date!)
        
        return string
    }
    
    var encrypted : String {
        let passwordString = self
        let salt = "aKnasdJaOmuHn{r8+i129sa.[fa"
        let passwordData = Data((passwordString + salt).utf8)

        let hashed = SHA256.hash(data: passwordData)

        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()

        return hashString
    }
}

extension Int {
    
    var currencyFormat : String {
          let currencyValue:Int = self
          let formatter = NumberFormatter()
          formatter.numberStyle = .decimal
          formatter.locale = Locale(identifier: "id_ID")
          formatter.groupingSeparator = "."

          let formattedTipAmount = formatter.string(from: NSNumber(value: currencyValue))
          
          return formattedTipAmount!

      }
}
