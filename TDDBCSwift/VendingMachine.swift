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

    var money: Int = 0
    
    func dispence(beverage: Beverage) -> Beverage? {
        return canBuy(money: money, beverage: beverage)
    }
    
    func insert(money: Coin) {
        self.money += money.rawValue
    }
    
    func canBuy(money: Int, beverage: Beverage) -> Beverage? {
        return money < beverage.price ? nil : beverage
    }
    
    func avalableBeverages() -> Set<Beverage> {
        let allCases = Beverage.allCases
            .filter { canBuy(money: money, beverage: $0) != nil }
        return Set(allCases)
    }
}
