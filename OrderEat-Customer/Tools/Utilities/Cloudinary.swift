//
//  Cloudinary.swift
//  OrderEat-Customer
//
//  Created by Kelvin Hadi Pratama on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

final class Cloudinary {
    
    static let api = APIRequest.api

    enum Error : String {
        case offline = "Please check your internet"
        case badRequest = "Bad Request"
        case invalidData = "Unstable Connection"
        case failed = "Failed"
        case internalServerError = "Internal Server Error"
    }
    
    class func imageUploadRequest(imageView: UIImageView, param: [String:String]?, completion: @escaping (Any?, Error?) -> Void ) {

            let url = URL(string: api + "/merchant/upload/image")!
            
            var request = URLRequest(url: url);
            request.httpMethod = "POST"

            let boundary = generateBoundaryString()

            request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            let imageData = imageView.image!.jpegData(compressionQuality: 1)

            if(imageData==nil)  { return; }

            request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "image", imageDataKey: imageData! as NSData, boundary: boundary) as Data

            //myActivityIndicator.startAnimating();

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let response = response as? HTTPURLResponse, let data = data // offline
                    else {
                        completion(nil, .offline)
                        return
                }
                
                switch(response.statusCode) {
                    case 200:
                        let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
                        completion(jsonData, nil)
                    
                    case 400:
                        completion(nil, .badRequest)
                    
                    case 500:
                        completion(nil, .internalServerError)
                    
                    default:
                        break
                }
            }
            task.resume()
        }


        class func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
            let body = NSMutableData();

            if parameters != nil {
                for (key, value) in parameters! {
                    body.appendString(string: "--\(boundary)\r\n")
                    body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString(string: "\(value)\r\n")
                }
            }

            let filename = "user-profile.jpg"
            let mimetype = "image/jpg"

            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\( filename)\"\r\n")

            body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageDataKey as Data)
            body.appendString(string: "\r\n")

            body.appendString(string: "--\(boundary)--\r\n")

            return body
        }

        class func generateBoundaryString() -> String {
            return "Boundary-\(UUID().uuidString)"
        }

    }


// extension for impage uploading

extension NSMutableData {

    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
