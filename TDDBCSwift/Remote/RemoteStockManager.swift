//
//  RemoteStockManager.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol RemoteAlertSendable {
    func sendAlert(completion: @escaping (Bool) -> Void)
}

protocol RemoteStockManageable {
    func sendAlert(completion: @escaping (Bool) -> Void)
    func getStock(of beverage: Beverage, completion: @escaping (Stock?) -> Void)
    func getAllStocks(completion: @escaping ([Stock]) -> Void)
}

final class Stock: Decodable {
    let beverage: Beverage
    var count: Int
    
    init(beverage: Beverage, count: Int) {
        self.beverage = beverage
        self.count = count
    }
    
    enum CodingKeys: String, CodingKey {
        case beverage = "name"
        case count
    }
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
    
    
    func sendAlert(completion: @escaping (Bool) -> Void) {
        sender.sendAlert(completion: completion)
    }
    
}
