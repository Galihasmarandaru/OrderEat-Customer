//
//  Image.swift
//  OrderEat-Customer
//
//  Created by Kelvin Hadi Pratama on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

struct Image {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init? (withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "background.jpeg"
        
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}
