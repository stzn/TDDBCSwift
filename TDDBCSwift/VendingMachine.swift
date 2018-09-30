//
//  VendingMachine.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/09/29.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

enum Beverage: CaseIterable, Hashable {
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
}

enum Coin: Int {
    case ten = 10
    case fifty = 50
    case hundred = 100
    case fiveHundred = 500
}

struct PurchaseResult {
    let beverage: Beverage?
    let change: Int
}

final class VendingMachine {
    
    var paidAmount: Int = 0
    var stocks: [Beverage : Int] = [:]
    
    init(defaultStocks: Int = 1) {
        Beverage.allCases.forEach {
            stocks[$0] = defaultStocks
        }
    }
    
    func dispence(beverage: Beverage) -> PurchaseResult {
        guard
            let product = availableBeverage(money: paidAmount, beverage: beverage),
            let stock = stocks[beverage], stock != 0
            else {
                return PurchaseResult(beverage: nil, change: 0)
        }
        let change = paidAmount - beverage.price
        paidAmount = change
        stocks[beverage]! = stock - 1
        return PurchaseResult(beverage: product, change: change)
    }
    
    func insert(money: Coin) {
        self.paidAmount += money.rawValue
    }
    
    func avalableBeverages() -> Set<Beverage> {
        let allCases = Beverage.allCases
            .filter { availableBeverage(money: paidAmount, beverage: $0) != nil }
        return Set(allCases)
    }
    
    func pushReturnButton() -> Int {
        return paidAmount
    }
    
    func numberOfStocks(of beverage: Beverage) -> Int {
        return stocks[beverage] ?? 0
    }
    
    private func availableBeverage(money: Int, beverage: Beverage) -> Beverage? {
        return money < beverage.price ? nil : beverage
    }
}

