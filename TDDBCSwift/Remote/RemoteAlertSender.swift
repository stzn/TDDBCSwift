//
//  RemoteAlertSender.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

struct RemoteAlertSender: RemoteAlertSendable {
    func sendAlert(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
