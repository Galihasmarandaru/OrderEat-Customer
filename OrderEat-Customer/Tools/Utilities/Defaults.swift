//
//  UserDefaults.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 20/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

struct Defaults {
    static let userLogin = "userLogin"
    static let id = "customerId"
    static let name = "customerName"
    
    static func saveCustomerData(name customerName: String, id customerId: String){
        UserDefaults.standard.set(customerName, forKey: name)
        UserDefaults.standard.set(customerId, forKey: id)
    }
    
    static func getName() -> String{
        let customerName = UserDefaults.standard.string(forKey: name) ?? ""
        
        return customerName
    }
    
    static func getId() -> String{
        let customerId = UserDefaults.standard.string(forKey: id) ?? ""
        
        return customerId
    }
    
    static func saveUserLogin(_ isUserLogin: Bool){
        UserDefaults.standard.set(isUserLogin, forKey: userLogin)
    }
    
    static func getUserLogin() -> Bool{
        let userLogin = UserDefaults.standard.bool(forKey: self.userLogin)
        
        return userLogin
    }
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userLogin)
        UserDefaults.standard.removeObject(forKey: id)
        UserDefaults.standard.removeObject(forKey: name)
    }
}
