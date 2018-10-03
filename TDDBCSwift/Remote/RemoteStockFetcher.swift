//
//  RemoteStockFetcher.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol RemoteStockFechable {
    func getStock(of beverage: Beverage, completion: @escaping (Result<Stock, Error>) -> Void)
    func getAllStock(completion: @escaping (Result<[Stock], Error>) -> Void)
}

struct RemoteStockFetcher: RemoteStockFechable, ResponseHandlable {
    
    typealias T = Stock
    
    let urlSession: SessionProtocol
    
    func getStock(of beverage: Beverage, completion: @escaping (Result<Stock, Error>) -> Void) {
        
        guard let url = URL(string: "https://vending.com/stock?name=\(beverage.rawValue)") else {
            completion(.failure(RemoteError.invlidURLError))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in

            self.handleResponse(data: data,  response: response, error: error) { result in
                guard result.error == nil, let data = result.value else {
                    completion(.failure(result.error!))
                    return
                }
                guard let item = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(RemoteError.JSONDecodeError))
                    return
                }
                completion(.success(item))
            }
        }.resume()
    }
    
    func getAllStock(completion: @escaping (Result<[Stock], Error>) -> Void) {
        
        guard let url = URL(string: "https://vending.com/stocks") else {
            completion(.failure(RemoteError.invlidURLError))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            self.handleResponse(data: data, response: response, error: error) { result in
                guard result.error == nil, let data = result.value else {
                    completion(.failure(result.error!))
                    return
                }
                guard let item = try? JSONDecoder().decode([T].self, from: data) else {
                    completion(.failure(RemoteError.JSONDecodeError))
                    return
                }
                completion(.success(item))
            }
        }.resume()
    }
}

