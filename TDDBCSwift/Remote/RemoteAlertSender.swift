//
//  RemoteAlertSender.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol RemoteAlertSendable {
    func sendAlert(of beverage: Beverage, completion: @escaping (Result<Bool, Error>) -> Void)
}

struct RemoteAlertSender: RemoteAlertSendable {
    
    let urlSession: SessionProtocol
    
    func sendAlert(of beverage: Beverage, completion: @escaping (Result<Bool, Error>) -> Void) {

        guard let url = URL(string: "https://vending.com/alert") else {
            completion(.failure(RemoteError.invlidURLError))
            return
        }

        var request = URLRequest(url: url)
        let param = ["name": beverage.rawValue]
        
        guard let data = try? JSONEncoder().encode(param) else {
            completion(.failure(RemoteError.dataNilError))
            return
        }
        request.httpMethod = "POST"
        request.httpBody = data

        urlSession.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(RemoteError.clientError(error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200..<400 ~= response.statusCode else {
                    completion(.failure(RemoteError.dataNilError))
                    return
            }
            
            guard let _ = data else {
                completion(.failure(RemoteError.dataNilError))
                return
            }
            completion(.success(true))
            
        }.resume()
    }
}
