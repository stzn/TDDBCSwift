//
//  Result.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/03.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

enum Result<T, Error> {
    case success(T)
    case failure(Error)
    
    var value: T? {
        if case let .success(value) = self {
            return value
        } else {
            return nil
        }
    }
    
    var error: Error? {
        if case let .failure(error) = self {
            return error
        } else {
            return nil
        }
    }
}
