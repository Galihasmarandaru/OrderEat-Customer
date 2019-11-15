//
//  UploadImage.swift
//  OrderEat-Customer
//
//  Created by Kelvin Hadi Pratama on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

typealias Parameters = [String: String]

class UploadImage {
    
    func uploadImage(image: UIImage) {
        
        let parameters = [
            "name":"MyTestFile",
            "description":"this is data for testing upload image"
        ]
        let imagetest = #imageLiteral(resourceName: "mcd")
        guard let imageData = Image(withImage: imagetest, forKey: "image_test") else { return }
        
        guard let url = URL(string: "http://127.0.0.1:3000/api/transaction/upload/image") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let dataBody = createDataBody(withParameters: parameters, image: imageData, boundary: boundary)
        request.httpBody = dataBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            } else {
                print(error!)
            }
            
        }.resume()
    
    
    }
    
    func createDataBody(withParameters params: Parameters?, image: Image?, boundary: String ) -> Data {
        let linebreak = "\r\n"
        
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + linebreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(linebreak + linebreak)")
                body.append("\(value + linebreak)")
            }
        }

        body.append("--\(boundary + linebreak)")
        body.append("Content-Disposition: form-data; name=\"\(image!.key)\"; filename=\" \(image!.filename)\" \(linebreak + linebreak)")
        body.append("Content-Type: \(image!.mimeType + linebreak + linebreak)")
        body.append(image!.data)
        body.append(linebreak)
        
        body.append("--\(boundary)--\(linebreak)")
        
        return body
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            //append(data)
            self.append(data)
        }
    }
}
