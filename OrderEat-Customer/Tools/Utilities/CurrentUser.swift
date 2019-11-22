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
    static var id = "ebab3258-de7f-4af9-aafe-dd57c54b7dfc"
    static var name = "Fred"
    static var accessToken: String = ""
    
    // do this after user sign in
    class func updateUserId(id: String) {
        self.id = id
    }
}
