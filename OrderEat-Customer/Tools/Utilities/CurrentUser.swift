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
    static var accessToken: String = ""
        
    class func reset() {
        id = ""
        accessToken = ""
    }
}
