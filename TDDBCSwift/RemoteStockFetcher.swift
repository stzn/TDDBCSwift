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
    
    func getStocks(of beverage: Beverage, completion: (Data?, URLResponse?, Error?) -> Void) {
        completion(nil, nil, nil)
    }
}

protocol SessionProtocol {
    func dataTask(with url: URL,
                  completionHandler: @escaping ResponseHandler) -> URLSessionDataTask
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping ResponseHandler) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}
