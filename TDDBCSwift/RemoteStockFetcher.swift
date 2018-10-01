//
//  RemoteStockFetcher.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

typealias ResponseHandler = (Data?, URLResponse?, Error?) -> Void

protocol RemoteStockFechable {
    func getStock(of beverage: Beverage, completion: @escaping (Data?, Error?) -> Void)
}

struct RemoteStockFetcher: RemoteStockFechable {

    let urlSession: SessionProtocol
    
    func getStock(of beverage: Beverage, completion: @escaping (Data?, Error?) -> Void) {

        guard let url = URL(string: "https://vending.com/stock?name=\(beverage.rawValue)") else {
            completion(nil, RemoteError.invlidURLError)
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil, RemoteError.clientError(error!))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200..<400 ~= response.statusCode else {
                    completion(nil, RemoteError.serverError)
                    return
            }
            
            guard let data = data else {
                completion(nil, RemoteError.dataNilError)
                return
            }
            completion(data, nil)
        }.resume()
    }
}

protocol SessionProtocol {
    func dataTask(with url: URL,
                  completionHandler: @escaping ResponseHandler) -> URLSessionDataTask
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping ResponseHandler) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}
