//
//  RemoteAlertSender.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

protocol RemoteAlertSendable {
    func sendAlert(of beverage: Beverage, completion: @escaping (Bool) -> Void)
}

struct RemoteAlertSender: RemoteAlertSendable {
    
    let urlSession: SessionProtocol
    
    func sendAlert(of beverage: Beverage, completion: @escaping (Bool) -> Void) {

        guard let url = URL(string: "https://vending.com/alert") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        let param = ["name": beverage.rawValue]
        
        guard let data = try? JSONEncoder().encode(param) else {
            completion(false)
            return
        }
        request.httpMethod = "POST"
        request.httpBody = data

        urlSession.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(false)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200..<400 ~= response.statusCode else {
                    completion(false)
                    return
            }
            
            guard let _ = data else {
                completion(false)
                return
            }
            completion(true)
            
        }.resume()
    }
}
