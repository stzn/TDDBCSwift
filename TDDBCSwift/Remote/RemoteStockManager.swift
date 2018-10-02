//
//  RemoteStockManager.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol RemoteStockManageable {
    func sendAlert(of beverage: Beverage, completion: @escaping (Result<Bool, Error>) -> Void)
    func getStock(of beverage: Beverage, completion: @escaping (Result<Stock, Error>) -> Void)
    func getAllStocks(completion: @escaping (Result<[Stock], Error>) -> Void)
}

struct RemoteStockManager: RemoteStockManageable {

    let fetcher: RemoteStockFechable
    let sender: RemoteAlertSendable
    
    func getStock(of beverage: Beverage, completion: @escaping (Result<Stock, Error>) -> Void) {
        fetcher.getStock(of: beverage) { result in
            completion(result)
        }
    }
    
    func getAllStocks(completion: @escaping (Result<[Stock], Error>) -> Void) {
        fetcher.getAllStock { result in
            completion(result)
        }
    }
    
    func sendAlert(of beverage: Beverage, completion: @escaping (Result<Bool, Error>) -> Void) {
        sender.sendAlert(of: beverage, completion: completion)
    }
    
}
