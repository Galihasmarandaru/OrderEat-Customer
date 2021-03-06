//
//  APIRequest.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 10/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//
//

import Foundation
import UIKit

enum ServerAddress : String {
    case dev = "http://167.71.194.60/api"
    case prod = "http://157.245.207.144/api"
}

final class APIRequest { 
    static let api = ServerAddress.prod.rawValue
    
    enum Endpoint : String {
        case customers = "/customer/"
        case merchants = "/merchant/"
        case menus = "/menu/"
        case transactions = "/transaction/"
    }
    
    enum Error : String {
        case offline = "Please check your internet"
        case badRequest = "Bad Request"
        case invalidData = "Unstable Connection"
        case failed = "Failed"
    }
    
    // GET
    class func getMerchants(completion: @escaping ([Merchant]?, Error?) -> Void) {
        let currentWeekday = Calendar.current.component(.weekday, from: Date())
        let url = URL(string: api + "/merchant/t=\(currentWeekday)")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data // offline
                else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        let merchants = try decoder.decode([Merchant].self, from: data)
                        completion(merchants, nil)
                    } catch {
                        completion(nil, .offline)
                    }
                
                case 400:
                    completion(nil, .badRequest)
                
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    class func getDetail(_ endpoint: Endpoint, id: String, completion: @escaping (Any?, Error?) -> Void) {
        let url = URL(string: api + endpoint.rawValue + id)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        switch endpoint {
                        case .merchants:
                            let merchant = try decoder.decode(Merchant.self, from: data)
                            completion(merchant, nil)
                        case .customers:
                            let customer = try decoder.decode(Customer.self, from: data)
                            completion(customer, nil)
                        case .menus:
                            let menu = try decoder.decode(Menu.self, from: data)
                            completion(menu, nil)
                        case .transactions:
                            let transaction = try decoder.decode(Transaction.self, from: data)
                            completion(transaction, nil)
                        }
                    } catch {
                        completion(nil, .offline)
                    }
                
                case 400:
                    completion(nil, .badRequest)
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    class func getTransactions(customerId: String, completion: @escaping ([Transaction]?, Error?) -> Void) {
        let url = URL(string: api + "/customer/" + customerId + "/ongoing")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        let transactions = try decoder.decode([Transaction].self, from: data)
                        completion(transactions, nil)
                    } catch {
                        completion(nil, .offline)
                    }
                
                case 400:
                    completion(nil, .badRequest)
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    class func getHistory (customerId: String, completion: @escaping ([Transaction]?, Error?) -> Void) {
        let url = URL(string: api + "/customer/" + customerId + "/history")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        let transactions = try decoder.decode([Transaction].self, from: data)
                        completion(transactions, nil)
                    } catch {
                        completion(nil, .offline)
                    }
                
                case 400:
                    completion(nil, .badRequest)
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    // GET menu
    class func getMenus(merchantId: String, completion: @escaping ([Menu]?, Error?) -> Void) {
        let url = URL(string: api + "/merchant/" + merchantId + "/menu")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    
                    do {
                        let menus = try decoder.decode([Menu].self, from: data)
                        completion(menus, nil)
                    } catch {
                        completion(nil, .offline)
                    }
                
                case 400:
                    completion(nil, .badRequest)
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    class func post(_ endpoint: Endpoint, object: Codable, completion: @escaping (String?,  Error?) -> Void) {
        let url = URL(string: api + endpoint.rawValue)!
        var request = URLRequest(url: url)
        
        let encoder = JSONEncoder()
        var jsonData : Data {
            do {
                switch endpoint {
                case .customers:
                    let customerObject = object as! Customer
                    return try encoder.encode(customerObject)
                case .merchants:
                    let merchantObject = object as! Merchant
                    return try encoder.encode(merchantObject)
                case .menus:
                    print()
                case .transactions:
                    let transactionObject = object as! Transaction
                    return try encoder.encode(transactionObject)
                }
            } catch {
                completion(nil, .offline)
            }
            return Data()
            
        }
        
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                    
                    let newObjectId = json["id"] as! String
                
                    completion(newObjectId, nil)
                case 400:
                    completion(nil, .badRequest)
                default:
                    break
                    
            }
        }
        
        task.resume()
    }
    
    class func put(_ endpoint: Endpoint, id: String, parameter body: [String : Any]) {
        let url = URL(string: api + endpoint.rawValue + id)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpBody = jsonData!
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(CurrentUser.accessToken)", forHTTPHeaderField: "Authorization")

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    print("Error: Not a valid http response")
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    break
                case 400:
                    break
                default:
                    break
                    
            }
        }
        
        task.resume()
    }
    
    class func signUp(parameter body: [String : Any], completion: @escaping (Bool?, Error?) -> Void) {
        let url = URL(string: api + "/customer/register")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpBody = jsonData!
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    completion(nil, .offline)
                    return
            }
            
            switch(response.statusCode) {
            case 200:
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:String]

//                PusherBeams.removeDeviceInterest(pushInterest: CurrentUser.id)
//                PusherChannels.pusher.unsubscribeAll()
//
//                CurrentUser.id = jsonData!["id"]!
//                CurrentUser.name = jsonData!["name"]!
//                CurrentUser.email = jsonData!["email"]!
//                CurrentUser.accessToken = jsonData!["access_token"]!
//
//                Defaults.clearUserData()
//                Defaults.saveUserLogin(true)
//                Defaults.saveCustomerData(token: token, id: id)
                
                completion(true, nil)
                
            case 400:
                completion(false, .offline)
                
            default:
                completion(false, .offline)
                
            }
        }
        
        task.resume()
        
    }
    
    class func signIn(parameter body: [String : Any], completion: @escaping (Bool?, Error?) -> Void) {
        let url = URL(string: api + "/customer/signin")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpBody = jsonData!
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    completion(nil, .offline)
                    return
            }
            
            
            print(response.statusCode)
            switch(response.statusCode) {
            case 200:
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:String]

                PusherBeams.removeDeviceInterest(pushInterest: CurrentUser.id)
                PusherChannels.pusher.unsubscribeAll()
                
                let token = jsonData!["access_token"]!
                let id = jsonData!["id"]!
                
                CurrentUser.id = id
                CurrentUser.name = jsonData!["name"]!
                CurrentUser.email = jsonData!["email"]!
                CurrentUser.accessToken = token
                
                Defaults.clearUserData()
                Defaults.saveUserLogin(true)
                Defaults.saveCustomerData(token: token, id: id)
                
                completion(true, nil)
                
            case 400:
                completion(nil, .offline)
            default:
                completion(nil, .offline)
            }
        }
        
        task.resume()
    }
    
   
}
