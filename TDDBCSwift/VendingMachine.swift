//
//  VendingMachine.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/09/29.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

enum Beverage: CaseIterable, Equatable {
    case cola
    case oolongTea
    case coffee
    case redBull
    
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
        }
    }
}

enum Coin: Int {
    case hundred = 100
}

class VendingMachine {

    var paidAmount: Int = 0
    
    func dispence(beverage: Beverage) -> Beverage? {
        return availableBeverage(money: paidAmount, beverage: beverage)
    }
    
    func insert(money: Coin) {
        self.paidAmount += money.rawValue
    }
    
    func availableBeverage(money: Int, beverage: Beverage) -> Beverage? {
        return money < beverage.price ? nil : beverage
    }
    
    func avalableBeverages() -> Set<Beverage> {
        let allCases = Beverage.allCases
            .filter { availableBeverage(money: paidAmount, beverage: $0) != nil }
        return Set(allCases)
    }
}
