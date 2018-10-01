//
//  VendingMachine.swift
//  TDDBCSwift
//
//  Created by Shinzan Takata on 2018/09/29.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation

final class VendingMachine {
    
    var paidAmount: Int = 0
    var stocks: [Beverage : Int] = [:]
    let manager: RemoteStockManageable
    var isBroken = false
    private let sendAlertUpperLimit = 2
    
    init(manager: RemoteStockManageable, defaultStocks: Int = 1) {
        self.manager = manager
        
        manager.getAllStocks { stocks in
            self.stocks = stocks.reduce([Beverage:Int]()) { (result, stock) -> [Beverage: Int] in
                var result = result
                result[stock.beverage] = stock.count
                return result
            }
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
        
        sendAlertIfNeeded(of: beverage)
        
        return PurchaseResult(beverage: product, change: change)
    }
    
    func sendAlertIfNeeded(of beverage: Beverage) {
        if stocks[beverage]! <= sendAlertUpperLimit {
            manager.sendAlert { [unowned self] success in
                self.isBroken = !success
            }
        }
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
    
    func supply(_ bevarage: Beverage, count: Int) {
        guard stocks[bevarage, default: 0] < bevarage.maxStockCount else {
            return
        }
        return stocks[bevarage, default: 0] += count
    }
    
    private func availableBeverage(money: Int, beverage: Beverage) -> Beverage? {
        return money < beverage.price ? nil : beverage
    }
}



