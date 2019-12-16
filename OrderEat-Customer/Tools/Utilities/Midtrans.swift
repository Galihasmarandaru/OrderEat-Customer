//
//  Midtrans.swift
//  OrderEat-Customer
//
//  Created by Kelvin Hadi Pratama on 05/12/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

final class Midtrans {
    static let api = "http://167.71.194.60/api"

    static var midtransToken: String = ""
    
    enum Error : String {
        case offline = "Please check your internet"
        case badRequest = "Bad Request"
        case invalidData = "Data is invalid"
        case failed = "Failed"
        
    }
    
    class func getMidtransToken(transaction : Transaction, completion: @escaping (Any?, Error?) -> Void) {
            let url = URL(string: api + "/payment/token")!;

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

            let parameters: [String: Any] =  [
                "transactionId": transaction.id!,
                "totalAmount": transaction.total!
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil else {
                        completion(nil, .offline)
                        return
                }
                
    //            guard 200 != response.statusCode else {
    //                completion(nil, .badRequest)
    //                return
    //            }
                
                switch(response.statusCode) {
                case 200:
    //            let responseString = String(data: data, encoding: .utf8)
                    let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
                                        
                    midtransToken = responseData!["token"]!
                    
                    completion(responseData, nil)
                    
                case 400:
                    completion(nil, .offline)
                    
                default:
                    completion(nil, .offline)
                    
                }
                

            }
            
            task.resume()
        }

    class func createGopayPayment(transaction: Transaction, completion: @escaping (Any?, Error?) -> Void) {
        let url = URL(string: api + "/payment/charge/gopay")!;

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] =  [
            "transactionId": transaction.id!,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
            case 200:
                let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
                completion(responseData, nil)
                
            case 400:
                completion(nil, .offline)
                
            default:
                completion(nil, .offline)
                
            }
            

        }
        
        task.resume()
    }
    
    class func getPaymentStatus(transactionId: String, completion: @escaping (Any?, Error?) -> Void) {
        let url = URL(string: api + "/payment/charge/status")!;

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] =  [
            "id": transactionId,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
            case 200:
                let responseData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
                completion(responseData, nil)
                
            case 400:
                completion(nil, .offline)
                
            default:
                completion(nil, .offline)
                
            }
            

        }
        
        task.resume()
    }
}
