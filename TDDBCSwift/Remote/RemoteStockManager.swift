//
//  RemoteStockManager.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol RemoteStockManageable {
    func sendAlert(of beverage: Beverage, completion: @escaping (Bool) -> Void)
    func getStock(of beverage: Beverage, completion: @escaping (Stock?) -> Void)
    func getAllStocks(completion: @escaping ([Stock]) -> Void)
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
    
    func getAllStocks(completion: @escaping ([Stock]) -> Void) {
        completion([])
    }
    
    func sendAlert(of beverage: Beverage, completion: @escaping (Bool) -> Void) {
        sender.sendAlert(of: beverage, completion: completion)
    }
    
}
