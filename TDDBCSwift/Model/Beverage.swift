//
//  Beverage.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

enum Beverage: String, CaseIterable, Hashable, Decodable {
    case cola
    case oolongTea
    case coffee
    case redBull
    case beer
    
    var price: Int {
        switch self {
        case .cola:
            return 100
        case .oolongTea:
            return 100
        case .coffee:
            return 300
        case .redBull:
            return 200
        case .beer:
            return 600
        }
    }
    
    var maxStockCount: Int {
        switch self {
        case .cola:
            return 10
        case .oolongTea:
            return 15
        case .coffee:
            return 20
        case .redBull:
            return 100
        case .beer:
            return 1000
        }
    }
}
