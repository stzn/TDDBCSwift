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

struct RemoteStockFetcher: RemoteStockFechable {

    let urlSession: SessionProtocol
    
    func getStock(of beverage: Beverage, completion: @escaping (Result<Stock, Error>) -> Void) {
        
        guard let url = URL(string: "https://vending.com/stock?name=\(beverage.rawValue)") else {
            completion(.failure(RemoteError.invlidURLError))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            let result = self.handleResponse(
                type: Stock.self, data: data,
                response: response, error: error
            )
            completion(result)
            
            }.resume()
    }
    
    func getAllStock(completion: @escaping (Result<[Stock], Error>) -> Void) {
        
        guard let url = URL(string: "https://vending.com/stocks") else {
            completion(.failure(RemoteError.invlidURLError))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            let result = self.handleResponse(
                type: [Stock].self, data: data,
                response: response, error: error
            )
            completion(result)
            
            }.resume()
    }
    
    private func handleResponse<T: Decodable>(
        type: T.Type, data: Data?,
        response: URLResponse?,
        error: Error?) -> Result<T, Error> {

        if error != nil {
            return .failure(RemoteError.clientError(error!))
        }
        
        guard let response = response as? HTTPURLResponse,
            200..<400 ~= response.statusCode else {
                return .failure(RemoteError.serverError)
        }
        
        guard let data = data else {
            return .failure(RemoteError.dataNilError)
        }

        guard let item = try? JSONDecoder().decode(T.self, from: data) else {
            return .failure(RemoteError.JSONDecodeError)
        }
        return .success(item)
    }
}

