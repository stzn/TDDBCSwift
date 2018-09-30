//
//  RemoteStockFetcher.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

struct RemoteStockFetcher: RemoteStockFechable {

    let urlSession: SessionProtocol
    
    func getStocks(of beverage: Beverage, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {

        guard let url = URL(string: "https://vending.com/stock?name=\(beverage.rawValue)") else {
            completion(nil, nil, RemoteError.invlidURLError)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            completion(data, response, error)
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
