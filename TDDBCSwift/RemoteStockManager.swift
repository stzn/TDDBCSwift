//
//  RemoteStockManager.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

typealias ResponseHandler = (Data?, URLResponse?, Error?) -> Void

protocol RemoteStockFechable {
    func getStocks(of beverage: Beverage, completion: ResponseHandler)
}

struct Stock: Decodable {
    let count: Int
}

struct RemoteStockManager {
    let fetcher: RemoteStockFechable
    
    func getStock(of beverage: Beverage, completion: (Stock?) -> Void) {
        
        fetcher.getStocks(of: beverage) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200..<400 ~= response.statusCode else {
                    completion(nil)
                    return
            }
            
            guard let data = data else {
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
}

