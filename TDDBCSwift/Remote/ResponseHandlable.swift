//
//  Response.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/04.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol ResponseHandlable {}

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
    
    func handleResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        
        self.handleResponse(data: data, response: response, error: error) { result in
            
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
    }
}
