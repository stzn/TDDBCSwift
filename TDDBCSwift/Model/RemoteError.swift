//
//  RemoteError.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

enum RemoteError: Error {
    case offlineError
    case clientError(Error)
    case serverError
    case invlidURLError
    case dataNilError
    case JSONDecodeError
}
