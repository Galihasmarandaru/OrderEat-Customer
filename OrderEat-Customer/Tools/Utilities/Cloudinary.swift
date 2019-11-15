//
//  Cloudinary.swift
//  OrderEat-Customer
//
//  Created by Kelvin Hadi Pratama on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import Alamofire
import Cloudinary
import UIKit

final class Cloudinary {
    
    // Configuration
    static let cloudName = "dkjgwktth"
    static let config = CLDConfiguration(cloudName: "dkjgwktth", apiKey: "318896591113784")
    static let cloudinary = CLDCloudinary(configuration: config)

    // URL generation
    class func createUrl() {
        let url = cloudinary.createUrl().generate("sample.jpg")
        print(url!)
    }
    
    class func uploadImage() {
                 
        // Blackpepper Burger
        // bg-merchat-1.jpg
        let image = UIImage(named: "Blackpepper Burger.jpg")
//        let image = UIImage(named: "bg-merchat-1.jpg")
        let data = image?.jpegData(compressionQuality: 1)

//        cloudinary.createUploader().upload(data: data!, uploadPreset: "unsignedCloud")

//        Cloudinary::Uploader.upload("sample.jpg", :use_filename => true, :folder => "folder1/folder2")

        let params = CLDUploadRequestParams()
            .setUploadPreset("unsignedCDN")
            .setPublicId("MyBurger") // file name
            .setTags("burger").setFolder("merchants")
        
        cloudinary.createUploader().upload(data: data! ,uploadPreset: "unsignedCDN",
            params: params, progress: nil) { (response, error) in
                if (error == nil) {
                    print(response!.url)
                    print("version: \(response!.version)")
                }
        }
    }

}
