//
//  APIRequest.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 10/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

final class APIRequest {
    static let api = "http://157.245.196.14/api"
    
    enum Endpoint : String {
        case customers = "/customer/"
        case merchants = "/merchant/"
        case menus = "/menu/"
        case transactions = "/transaction/"
    }
    
    // GET
    class func getMerchants(completion: @escaping ([Merchant]?) -> Void) {
        let url = URL(string: api + "/merchant")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    print("Error: Not a valid http response")
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        let merchants = try decoder.decode([Merchant].self, from: data)
                        completion(merchants)
                    } catch {
                        print("Error: ",error.localizedDescription)
                    }
                
                case 400:
                    print(error!)
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    class func getDetail(_ endpoint: Endpoint, id: String, completion: @escaping (Any?) -> Void) {
        let url = URL(string: api + endpoint.rawValue + id)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    print("Error: Not a valid http response")
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        switch endpoint {
                        case .merchants:
                            let merchant = try decoder.decode(Merchant.self, from: data)
                            completion(merchant)
                        case .customers:
                            let customer = try decoder.decode(Customer.self, from: data)
                            completion(customer)
                        case .menus:
                            let menu = try decoder.decode(Menu.self, from: data)
                            completion(menu)
                        case .transactions:
                            let transaction = try decoder.decode(Transaction.self, from: data)
                            completion(transaction)
                        }
                    } catch {
                        print("Error: ",error.localizedDescription)
                    }
                
                case 400:
                    print(error!)
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    class func getTransactions(customerId: String, completion: @escaping ([Transaction]?) -> Void) {
        let url = URL(string: api + "/customer/" + customerId + "/ongoing")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    print("Error: Not a valid http response")
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        let transactions = try decoder.decode([Transaction].self, from: data)
                        completion(transactions)
                    } catch {
                        print("Error: ",error.localizedDescription)
                    }
                
                case 400:
                    print(error!)
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    // GET menu
    class func getMenus(merchantId: String, completion: @escaping ([Menu]?) -> Void) {
        let url = URL(string: api + "/merchant/" + merchantId + "/menu")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    print("Error: Not a valid http response")
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    let decoder = JSONDecoder()
                    
                    do {
                        let menus = try decoder.decode([Menu].self, from: data)
                        completion(menus)
                    } catch {
                        print("Error: ",error.localizedDescription)
                    }
                
                case 400:
                    print(error!)
                default:
                    break

            }
        }
        
        task.resume()
    }
    
    class func post(_ endpoint: Endpoint, object: Codable, completion: @escaping (String?) -> Void) {
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
                print(error.localizedDescription)
            }
            return Data()
        }
        
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    print("Error: Not a valid http response")
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    print(data.prettyPrintedJSONString!)
                    
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                    
                    let newObjectId = json["id"] as! String
                
                    completion(newObjectId)
                case 400:
                    print(error!)
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
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data
                else {
                    print("Error: Not a valid http response")
                    return
            }
            
            switch(response.statusCode) {
                case 200:
                    print(data.prettyPrintedJSONString!)
                case 400:
                    print(error!)
                default:
                    break
                    
            }
        }
        
        task.resume()
    }
}
