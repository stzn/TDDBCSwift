//
//  Stock.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

final class Stock: Codable {
    let beverage: Beverage
    var count: Int
    
    init(beverage: Beverage, count: Int) {
        self.beverage = beverage
        self.count = count
    }
    
    enum CodingKeys: String, CodingKey {
        case beverage = "name"
        case count
    }
}
