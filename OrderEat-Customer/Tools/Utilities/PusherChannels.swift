//
//  PusherChannels.swift
//  OrderEat-Customer
//
//  Created by Kelvin Hadi Pratama on 13/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import PusherSwift

final class PusherChannels: PusherDelegate {

    // Channels
    static var pusher: Pusher!
    static var channel: PusherChannel!
    
    class func initPusherChannel() {
        let options = PusherClientOptions(
           host: .cluster("ap1")
         )
        self.pusher = Pusher(
           key: "6c1e137627b90e824011",
           options: options
         )
    }
    
    class func subscribePushChannel(channel: String) {
        // subscribe to channel
        self.channel = pusher.subscribe(channelName: channel)
        self.pusher.connect()

        print("pusher coonnect done")

    }
    
}

