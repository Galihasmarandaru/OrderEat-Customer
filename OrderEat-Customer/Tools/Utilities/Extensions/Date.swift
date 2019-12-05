//
//  Date.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

extension Date {
    var string : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let string = formatter.string(from: self)
        
        return string
    }
    
    var time : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let string = formatter.string(from: self)
        
        return string
    }
}
