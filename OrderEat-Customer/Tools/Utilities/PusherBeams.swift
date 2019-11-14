//
//  PusherBeams.swift
//  OrderEat-Customer
//
//  Created by Kelvin Hadi Pratama on 13/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import PushNotifications

final class PusherBeams {
    
    // Beams
    static let pushNotifications = PushNotifications.shared
    static let instanceId = "f4175959-3847-4a45-aadc-2ca1a3cf752a"
    
    class func initPushNotifications() {
        // Pusher Beams Notification
        pushNotifications.start(instanceId: instanceId)
        pushNotifications.registerForRemoteNotifications()
        
        if ( !CurrentUser.id.isEmpty ) {
            registerDeviceInterest(pushInterest: CurrentUser.id)
        }
        print("push notif init done")
    }
    
    class func registerDeviceInterest(pushInterest: String) {
            try? self.pushNotifications.addDeviceInterest(interest: pushInterest)
    }
    
    class func removeDeviceInterest(pushInterest: String) {
            try? self.pushNotifications.removeDeviceInterest(interest: pushInterest)
    }
}
