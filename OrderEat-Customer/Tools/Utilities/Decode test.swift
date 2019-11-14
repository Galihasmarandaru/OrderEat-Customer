//
//  Decode test.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 11/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

final class DecodeTest {
    class func attemptDecodeTransaction() -> Transaction?{
        let jsonData = """
            {
                "id": "2624db58-a139-4057-a141-21b716015219",
                "pickUpTime": null,
                "status": 0,
                "total": 140000,
                "merchant": {
                    "name": "klenger",
                    "address": "jln keluarga",
                    "phone": null
                },
                "customer": {
                    "name": "fred",
                    "phone": "0899"
                },
                "details": [
                    {
                        "qty": 3,
                        "menu": {
                            "name": "kol",
                            "price": 10000
                        }
                    },
                    {
                        "qty": 4,
                        "menu": {
                            "name": "geprek",
                            "price": 20000
                        }
                    }
                ]
            }
        """.data(using: .utf8)
        
        do {
            let transaction = try JSONDecoder().decode(Transaction.self, from: jsonData!)
            return transaction
        } catch {
            print("Error: ", error.localizedDescription)

        }
        
//        APIRequest.getTransactions(customerId: CurrentUser.id) { (transactions) in
//            print(transactions)
//        }
        return nil
    }
}
