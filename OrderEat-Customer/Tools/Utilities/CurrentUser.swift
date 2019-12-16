//
//  CurrentUser.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 10/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import PusherSwift
import PushNotifications

final class CurrentUser {
    static var id = ""
    static var name = ""
    static var email = ""
    static var accessToken: String = ""
        
    class func signUser(data: [String:String]) {
        self.id = data["id"]!
        self.name = data["name"]!
        self.email = data["email"]!
        self.accessToken = data["accessToken"]!
    }
    
    class func reset() {
        id = ""
        name = ""
        email = ""
        accessToken = ""
    }
}
