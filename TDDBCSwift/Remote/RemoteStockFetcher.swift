//
//  RemoteStockFetcher.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol RemoteStockFechable {
    func getStock(of beverage: Beverage, completion: @escaping (Data?, Error?) -> Void)
    func getStocks(completion: @escaping (Data?, Error?) -> Void)
}

struct RemoteStockFetcher: RemoteStockFechable {
    
    let urlSession: SessionProtocol
    
    func getStock(of beverage: Beverage, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL(string: "https://vending.com/stock?name=\(beverage.rawValue)") else {
            completion(nil, RemoteError.invlidURLError)
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            let result = self.handleResponse(
                data: data, response: response, error: error
            )
            completion(result.data, result.error)
            
            }.resume()
    }
    
    func getStocks(completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL(string: "https://vending.com/stocks") else {
            completion(nil, RemoteError.invlidURLError)
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            
            let result = self.handleResponse(
                data: data, response: response, error: error
            )
            completion(result.data, result.error)
            
            }.resume()
    }
    
    private func handleResponse(
        data: Data?,
        response: URLResponse?,
        error: Error?) -> (data: Data?, error: Error?){
        
        if error != nil {
            return (nil, RemoteError.clientError(error!))
        }
        
        guard let response = response as? HTTPURLResponse,
            200..<400 ~= response.statusCode else {
                return (nil, RemoteError.serverError)
        }
        
        guard let data = data else {
            return (nil, RemoteError.dataNilError)
        }
        return (data, nil)
    }
}

typealias ResponseHandler = (Data?, URLResponse?, Error?) -> Void

protocol SessionProtocol {
    func dataTask(with url: URL,
                  completionHandler: @escaping ResponseHandler) -> URLSessionDataTask
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping ResponseHandler) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}


