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
    func getStock(of beverage: Beverage, completion: @escaping (Stock?) -> Void)
    func getAllStocks(completion: @escaping ([Stock]) -> Void)
}

struct RemoteStockManager: RemoteStockManageable {

    let fetcher: RemoteStockFechable
    let sender: RemoteAlertSendable
    
    func getStock(of beverage: Beverage, completion: @escaping (Stock?) -> Void) {
        fetcher.getStock(of: beverage) { data, error in
            
            guard let stock = self.handleResponse(
                type: Stock.self, data: data, error: error) else {
                    completion(nil)
                    return
            }
            completion(stock)
        }
    }
    
    func getAllStocks(completion: @escaping ([Stock]) -> Void) {
        fetcher.getAllStock { data, error in
            
            guard let stocks = self.handleResponse(
                type: [Stock].self, data: data, error: error) else {
                    completion([])
                    return
            }
            completion(stocks)
        }
    }
    
    private func handleResponse<T: Decodable>(type: T.Type, data: Data?, error: Error?) -> T? {
        
        guard error == nil, let data = data else {
            return nil
        }
        
        guard let item = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return item
    }
    
    func sendAlert(of beverage: Beverage, completion: @escaping (Result<Bool, Error>) -> Void) {
        sender.sendAlert(of: beverage, completion: completion)
    }
    
}
