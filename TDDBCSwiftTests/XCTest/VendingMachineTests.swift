//
//  BeverageTests.swift
//  TDDBCSwiftTests
//
//  Created by Shinzan Takata on 2018/09/29.
//  Copyright © 2018 tddbc. All rights reserved.
//

import XCTest
@testable import TDDBCSwift

class VendingMachineTests: XCTestCase {
    var vendingMachine: VendingMachine!
    
    override func setUp() {
        vendingMachine = VendingMachine()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // TODO
    // xボタンを押すとコーラが出る
    // x100円コインを投入してからボタンを押すとコーラが出る
    // x100円コインを投入する前にボタンを押すと何も出ない
    // x100円コインを投入してからウーロン茶のボタンを押すと、ウーロン茶が出る
    // x100円コインを投入する前にウーロン茶ボタンを押すと何も出ない
    // xほかの飲み物を追加する
    // X200円を投入するとレッドブルが出る
    // x何も投入しないとレッドブルが出ない
    // x100円だけを投入するとレッドブルが出ない
    // x100円を投入するとコーヒーが出ない
    // x200円を投入するとコーヒーが出ない
    // x300円を投入するとコーヒーが出る
    // x400円を投入するとコーヒーが出て100円のお釣りが出る
    // x入れたお金以下の金額の飲み物のボタンが全て光る
    //   x100円をいれると、コーラとウーロン茶だけが光る
    //   x200円を入れると、コーラ、ウーロン茶とレッドブルだけが光る
    //   x300円入れると、コーラとウーロン茶とレッドブルとコーヒーが光る
    // x600円を投入するとビールが出る
    // x500円を投入するとビールが出ない
    // x100円コインの他に、10円、50円、500円コインも使える
    //   x50円コインを2枚投入してからボタンを押すとコーラが出る
    //   x10円コインを10枚投入してからボタンを押すとコーラが出る
    //   x50円コインを1枚10円コインを5枚投入してからボタンを押すとコーラが出る
    //   x50円コインを1枚、10円コインを4枚投入してからボタンを押すとコーラが出ない
    //   x500円コインを1枚投入してからボタンを押すとコーラが出る
    //   x500円コインを1枚投入してからボタンを押すとコーヒーが出る
    //   x500円コインを1枚、50円を1枚、10円を5枚投入してからボタンを押すとビールが出る
    //   x500円コインを1枚、50円を1枚、10円を4枚投入してからボタンを押すとビールが出ない
    // xボタンを押して飲み物を買うと、お釣りが出る
    //   x500円コインを1枚投入してからコーラのボタンを押してコーラを買うと400円のお釣りが出る
    //   x100円コインを1枚投入してからコーラのボタンを押してコーラを買うとお釣りが出ない
    //   x100円コインを1枚投入してからコーラのボタンを押してコーラを買い、ウーロン茶のボタンを押してもウーロン茶は出てこない
    //   x100円コインを1枚投入してからコーラのボタンを押してコーラを買い、追加で100円を投入してウーロン茶のボタンを押すとウーロン茶は出る
    //   x100円コインを1枚投入してからコーヒーのボタンを押してもコーヒーは出ず、お釣りも出ないが、次にコーラのボタンを押すとコーラは出る
    // x100円を投入してから返却ボタンを押すと100円が出てくる
    // x200円を投入してから返却ボタンを押すと200円が出てくる
    // x500円コインを1枚投入してからコーラのボタンを押してコーラを買い、返却ボタンを押すと400円が出てくる
    // xお金を投入せずに返却ボタンを押すと何も出てこない
    // x在庫がなくなった飲み物は売れない
    //  xコーラの在庫が1の状態でコーラを買うと在庫が0になる
    //  xコーラの在庫が1の状態でコーラを買い、もう一度コーラを買おうとすると買えない
    //  xコーヒーの在庫が1の状態でコーヒーを買うと在庫が0になる
    //  xコーラの在庫が2の状態でコーラを買い、さらにもう一度コーラを買うことができる
    //  xコーラの在庫が1の状態でコーラを買い、 在庫を1つ補充してからもう一度コーラを買おうとすると買える
    //  xコーヒーの在庫が1の状態でコーヒーを買い、 在庫を1つ補充してからもう一度コーヒーを買おうとすると買える
    //  xコーラの在庫が1の状態で在庫を2つ補充すると在庫数は３になる
    // x飲み物はそれぞれ限られた本数しか格納できない
    //  xコーラの在庫が上限の状態で在庫を1つ補充しても在庫数は変わらない
    //  xコーヒーの在庫が上限の状態で在庫を1つ補充しても在庫数は変わらない
    // 通信モジュールから在庫数が取得できる
    //  インターネットに繋がっている場合、コーラの在庫数をリモート監視に問い合わせると、コーラの在庫数が取得できる
    //  インターネットに繋がっている場合、コーヒーの在庫数をリモート監視に問い合わせると、コーヒーの在庫数が取得できる
    //  インターネットに繋がっていない場合、コーラの在庫数をリモート監視に問い合わせると、コーラの在庫数が取得できない

    func test_インターネットに繋がっている場合_コーヒーの在庫数をリモート監視に問い合わせると_コーヒーの在庫数が取得できる() {
        let coffeeStocks = RemoteManager.getStocks(of: .coffee)
        XCTAssertEqual(coffeeStocks, 20)
    }

    func test_インターネットに繋がっている場合_コーラの在庫数をリモート監視に問い合わせると_コーラの在庫数が取得できる() {
        let colaStocks = RemoteManager.getStocks(of: .cola)
        XCTAssertEqual(colaStocks, 10)
    }
    
    func test_コーラの在庫が上限の状態で在庫を1つ補充しても在庫数は変わらない() {
        let colaMaxStockCount = Beverage.cola.maxStockCount
        vendingMachine = VendingMachine(defaultStocks: colaMaxStockCount)
        vendingMachine.supply(.cola, count: 1)
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .cola), colaMaxStockCount)
    }
    
    func test_コーラの在庫が1の状態で在庫を2つ補充すると在庫数は３になる() {
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .cola), 1)
        vendingMachine.supply(.cola, count: 2)
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .cola), 3)
    }

    func test_コーヒーの在庫が1の状態でコーヒーを買い在庫を1つ補充してからもう一度コーヒーを買おうとすると買える() {
        insertMutipleCoins(coins: [.fiveHundred: 1, .hundred: 1])
        _ = vendingMachine.dispence(beverage: .coffee)
        vendingMachine.supply(.coffee, count: 1)
        let secondItem = vendingMachine.dispence(beverage: .coffee)
        XCTAssertEqual(secondItem.beverage, .coffee)
    }

    func test_コーラの在庫が1の状態でコーラを買い在庫を1つ補充してからもう一度コーラを買おうとすると買える() {
        insertMutipleCoins(money: .fiveHundred, times: 1)
        _ = vendingMachine.dispence(beverage: .cola)
        vendingMachine.supply(.cola, count: 1)
        let secondItem = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(secondItem.beverage, .cola)
    }

    func test_コーラの在庫が2の状態でコーラを買いさらにもう一度コーラを買うことができる() {
        vendingMachine = VendingMachine(defaultStocks: 2)
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .cola), 2)
        insertMutipleCoins(money: .fiveHundred, times: 1)
        _ = vendingMachine.dispence(beverage: .cola)
        let secondItem = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(secondItem.beverage, .cola)
    }
    
    func test_コーヒーの在庫が1の状態でコーヒーを買うと在庫が0になる() {
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .coffee), 1)
        insertMutipleCoins(money: .fiveHundred, times: 1)
        _ = vendingMachine.dispence(beverage: .coffee)
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .coffee), 0)
    }

    func test_コーラの在庫が1の状態でコーラを買いもう一度コーラを買おうとすると買えない() {
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .cola), 1)
        insertMutipleCoins(money: .fiveHundred, times: 1)
        _ = vendingMachine.dispence(beverage: .cola)
        let secondItem = vendingMachine.dispence(beverage: .cola)
        XCTAssertNil(secondItem.beverage)
    }
    
    func test_コーラの在庫が1の状態でコーラを買うと在庫が0になる() {
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .cola), 1)
        insertMutipleCoins(money: .fiveHundred, times: 1)
        _ = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(vendingMachine.numberOfStocks(of: .cola), 0)
    }
    
    func test_お金を投入せずに返却ボタンを押すと何も出てこない() {
        let returnedMoney = vendingMachine.pushReturnButton()
        XCTAssertEqual(returnedMoney, 0)
    }
    
    func test_500円コインを1枚投入してからコーラのボタンを押してコーラを買い返却ボタンを押すと400円が出てくる() {
        insertMutipleCoins(money: .fiveHundred, times: 1)
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(item.beverage, .cola)
        let returnedMoney = vendingMachine.pushReturnButton()
        XCTAssertEqual(returnedMoney, 400)
    }

    func test_200円を投入してから返却ボタンを押すと200円が出てくる() {
        insertMutipleCoins(money: .hundred, times: 2)
        let returnedMoney = vendingMachine.pushReturnButton()
        XCTAssertEqual(returnedMoney, 200)
    }

    func test_100円を投入してから返却ボタンを押すと100円が出てくる() {
        insertMutipleCoins(money: .hundred, times: 1)
        let returnedMoney = vendingMachine.pushReturnButton()
        XCTAssertEqual(returnedMoney, 100)
    }
    
    func test_100円コインを1枚投入してからコーヒーのボタンを押してもコーヒーもお釣りも出ないが次にコーラのボタンを押すとコーラは出る() {
        insertMutipleCoins(money: .hundred, times: 1)
        let coffee = vendingMachine.dispence(beverage: .coffee)
        XCTAssertNil(coffee.beverage)
        XCTAssertEqual(coffee.change, 0)
        let cola = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(cola.beverage, .cola)
    }

    func test_100円コインを1枚投入してからコーラのボタンを押してコーラを買い追加で100円を投入してウーロン茶のボタンを押すとウーロン茶は出る() {
        insertMutipleCoins(money: .hundred, times: 1)
        _ = vendingMachine.dispence(beverage: .cola)
        insertMutipleCoins(money: .hundred, times: 1)
        let oolong = vendingMachine.dispence(beverage: .oolongTea)
        XCTAssertEqual(oolong.beverage, .oolongTea)
    }
    
    func test_100円コインを1枚投入してからコーラのボタンを押してコーラを買いウーロン茶のボタンを押してもウーロン茶は出てこない() {
        insertMutipleCoins(money: .hundred, times: 1)
        _ = vendingMachine.dispence(beverage: .cola)
        let oolong = vendingMachine.dispence(beverage: .oolongTea)
        XCTAssertNil(oolong.beverage)
    }

    func test_100円コインを1枚投入してからコーラのボタンを押してコーラを買うとお釣りが出ない() {
        insertMutipleCoins(money: .hundred, times: 1)
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(item.beverage, .cola)
        XCTAssertEqual(item.change, 0)
    }
    
    func test_500円コインを1枚投入してからボタンを押してコーラを買うと400円のお釣りが出る() {
        insertMutipleCoins(money: .fiveHundred, times: 1)
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(item.beverage, .cola)
        XCTAssertEqual(item.change, 400)
    }

    func test_500円コインを1枚50円を1枚10円を4枚投入してからボタンを押すとビールが出ない() {
        insertMutipleCoins(coins: [.fiveHundred: 1, .fifty: 1, .ten: 4])
        let item = vendingMachine.dispence(beverage: .beer)
        XCTAssertNil(item.beverage)
    }

    func test_50円コインを1枚10円コインを5枚投入してからボタンを押すとコーラが出る() {
        insertMutipleCoins(coins: [.fifty: 1, .ten: 5])
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(item.beverage, .cola)
    }

    func test_10円コインを10枚投入してからボタンを押すとコーラが出る() {
        insertMutipleCoins(money: .ten, times: 10)
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(item.beverage, .cola)
    }

    func test_50円コインを2枚投入してからボタンを押すとコーラが出る() {
        insertMutipleCoins(money: .fifty, times: 2)
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(item.beverage, .cola)
    }
    
    func test_600円を投入するとビールが出る() {
        insertMutipleCoins(money: .hundred, times: 6)
        let item = vendingMachine.dispence(beverage: .beer)
        XCTAssertEqual(item.beverage, .beer)
    }

    func test_500円を投入するとビールが出ない() {
        insertMutipleCoins(money: .hundred, times: 5)
        let item = vendingMachine.dispence(beverage: .beer)
        XCTAssertNil(item.beverage)
    }

    func test_100円をいれるとコーラとウーロン茶だけが光る() {
        insertMutipleCoins(money: .hundred, times: 1)
        let lightedButtons = vendingMachine.avalableBeverages()
        XCTAssertEqual(lightedButtons, [.cola, .oolongTea])
    }
    
    func test_200円をいれるとコーラとウーロン茶とレッドブルが光る() {
        insertMutipleCoins(money: .hundred, times: 2)
        let lightedButtons = vendingMachine.avalableBeverages()
        let expected: Set<Beverage> = [.redBull, .cola, .oolongTea]
        XCTAssertEqual(expected, lightedButtons)
    }
    
    func test_300円をいれるとコーラとウーロン茶とレッドブルとコーヒーが光る() {
        insertMutipleCoins(money: .hundred, times: 3)
        let lightedButtons = vendingMachine.avalableBeverages()
        let expected: Set<Beverage> = Set([.coffee, .cola, .oolongTea, .redBull])
        XCTAssertEqual(expected, lightedButtons)
    }

    func test_100円コインを投入する前にコーラボタンを押すと何も出ない() {
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertNil(item.beverage)
    }
    
    func test_100円コインを投入する前にウーロン茶ボタンを押すと何もでない() {
        let item = vendingMachine.dispence(beverage: .oolongTea)
        XCTAssertNil(item.beverage)
    }
    
    func test_100円コインを投入してからウーロン茶ボタンを押すとウーロン茶がでる() {
        insertMutipleCoins(money: .hundred, times: 1)
        let item = vendingMachine.dispence(beverage: .oolongTea)
        XCTAssertEqual(item.beverage, .oolongTea)
    }
    
    func test_200円を投入するとレッドブルが出る() {
        insertMutipleCoins(money: .hundred, times: 2)
        let item = vendingMachine.dispence(beverage: .redBull)
        XCTAssertEqual(item.beverage, .redBull)
    }

    func test_100円だけを投入するとレッドブルが出ない() {
        insertMutipleCoins(money: .hundred, times: 1)
        let item = vendingMachine.dispence(beverage: .redBull)
        XCTAssertNil(item.beverage)
    }
    
    func test_100円だけを投入するとコーヒーが出ない() {
        insertMutipleCoins(money: .hundred, times: 1)
        let item = vendingMachine.dispence(beverage: .coffee)
        XCTAssertNil(item.beverage)
    }

    func test_200円を投入するとコーヒーが出ない() {
        insertMutipleCoins(money: .hundred, times: 2)
        let item = vendingMachine.dispence(beverage: .coffee)
        XCTAssertNil(item.beverage)
    }

    func test_300円を投入するとコーヒーが出る() {
        insertMutipleCoins(money: .hundred, times: 3)
        let item = vendingMachine.dispence(beverage: .coffee)
        XCTAssertEqual(item.beverage, .coffee)
    }

    func test_400円を投入するとコーヒーが出て100円のお釣りが出る() {
        insertMutipleCoins(money: .hundred, times: 4)
        let item = vendingMachine.dispence(beverage: .coffee)
        XCTAssertEqual(item.beverage, .coffee)
        XCTAssertEqual(item.change, 100)
    }
    
    func insertMutipleCoins(money: Coin, times: Int) {
        for _ in 0..<times {
            vendingMachine.insert(money: money)
        }
    }
    
    func insertMutipleCoins(coins: Dictionary<Coin, Int>) {
        for (money, times) in coins {
            for _ in 0..<times {
                vendingMachine.insert(money: money)
            }
        }
    }
}
