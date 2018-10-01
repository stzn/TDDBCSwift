//
//  RemoteStockManager.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol RemoteStockFechable {
    func getStock(of beverage: Beverage, completion: @escaping (Data?, Error?) -> Void)
}

protocol RemoteAlertSendable {
    func sendAlert()
}

protocol RemoteStockManageable {
    func sendAlert()
    func getStock(of beverage: Beverage, completion: @escaping (Stock?) -> Void)
}

struct Stock: Decodable {
    let count: Int
}

struct RemoteStockManager: RemoteStockManageable {

    let fetcher: RemoteStockFechable
    let sender: RemoteAlertSendable
    
    func getStock(of beverage: Beverage, completion: @escaping (Stock?) -> Void) {
        
        fetcher.getStock(of: beverage) { data, error in
            guard error == nil,
                let data = data
                else {
                    completion(nil)
                    return
            }
            
            guard let stock = try? JSONDecoder().decode(Stock.self, from: data) else {
                completion(nil)
                return
            }
            completion(stock)
        }
    }
    
    func sendAlert() {
        sender.sendAlert()
    }
}
