//
//  Response.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/04.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol ResponseHandlable {
    associatedtype T
}

extension ResponseHandlable {
    
    func handleResponse(data: Data?, response: URLResponse?, error: Error?,
                         completion: @escaping (Result<Data, Error>) -> Void) {
        
        if error != nil {
            completion(.failure(RemoteError.clientError(error!)))
            return
        }
        
        guard let response = response as? HTTPURLResponse,
            200..<400 ~= response.statusCode else {
                completion(.failure(RemoteError.dataNilError))
                return
        }
        
        guard let data = data else {
            completion(.failure(RemoteError.dataNilError))
            return
        }
        completion(.success(data))
    }
}
