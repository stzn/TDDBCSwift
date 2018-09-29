//
//  BeverageTests.swift
//  TDDBCSwiftTests
//
//  Created by Shinzan Takata on 2018/09/29.
//  Copyright © 2018 tddbc. All rights reserved.
//

import XCTest
@testable import TDDBCSwift

class BeverageTests: XCTestCase {
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
    // x100円を投入するとコーヒー出ない
    // x200円を投入するとコーヒー出ない
    // x300円を投入するとコーヒー出る
    // x400円を投入するとコーヒー出る
    // x入れたお金以下の金額の飲み物のボタンが全て光る
    //   100円をいれると、コーラとウーロン茶だけが光る
    //   200円を入れると、コーラ、ウーロン茶とレッドブルだけが光る
    //   300円入れると、コーラとウーロン茶とレッドブルとコーヒーが光る
    // 600円を投入するとビールが出る
    // 100円コインの他に、10円、50円、500円コインも使える
    //   50円コインを2枚投入してからボタンを押すとコーラが出る
    //   10円コインを10枚投入してからボタンを押すとコーラが出る
    //   50円コインを5枚投入、10円コインを5枚投入してからボタンを押すとコーラが出る
    //   50円コインを1枚、10円コインを4枚投入してからボタンを押すとコーラが出ない
    //   500円コインを1枚投入してからボタンを押すとコーラが出る
    //   500円コインを1枚投入してからボタンを押すとコーヒーが出る
    //   500円コインを1枚、50円を1枚、10円を5枚投入してからボタンを押すとビールが出る
    //   500円コインを1枚投入してからボタンを押すとビールが出ない
    
    func test_600円を投入するとビールが出る() {
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .beer)
        XCTAssertEqual(item, .beer)
    }

    func test_100円をいれるとコーラとウーロン茶だけが光る() {
        vendingMachine.insert(money: .hundred)
        let lightedButtons = vendingMachine.avalableBeverages()
        XCTAssertEqual(lightedButtons, [.cola, .oolongTea])
    }
    
    func test_200円をいれるとコーラとウーロン茶とレッドブルが光る() {
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        let lightedButtons = vendingMachine.avalableBeverages()
        let expected: Set<Beverage> = [.redBull, .cola, .oolongTea]
        XCTAssertEqual(expected, lightedButtons)
    }
    
    func test_300円をいれるとコーラとウーロン茶とレッドブルとコーヒーが光る() {
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        let lightedButtons = vendingMachine.avalableBeverages()
        let expected: Set<Beverage> = Set([.coffee, .cola, .oolongTea, .redBull])
        XCTAssertEqual(expected, lightedButtons)
    }

    func test_100円コインを投入してからコーラボタンを押したらコーラが出る() {
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertEqual(item, .cola)
    }
    
    func test_100円コインを投入する前にコーラボタンを押すと何も出ない() {
        let item = vendingMachine.dispence(beverage: .cola)
        XCTAssertNil(item)
    }
    
    func test_100円コインを投入する前にウーロン茶ボタンを押すと何もでない() {
        let item = vendingMachine.dispence(beverage: .oolongTea)
        XCTAssertNil(item)
    }
    
    func test_100円コインを投入してからウーロン茶ボタンを押すとウーロン茶がでる() {
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .oolongTea)
        XCTAssertEqual(item, .oolongTea)
    }
    
    func test_200円を投入するとレッドブルが出る() {
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .redBull)
        XCTAssertEqual(item, .redBull)
    }

    func test_100円だけを投入するとレッドブルが出ない() {
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .redBull)
        XCTAssertNil(item)
    }
    
    func test_100円だけを投入するとコーヒーが出ない() {
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .coffee)
        XCTAssertNil(item)
    }

    func test_200円を投入するとコーヒーが出ない() {
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .coffee)
        XCTAssertNil(item)
    }

    func test_300円を投入するとコーヒーが出る() {
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .coffee)
        XCTAssertEqual(item, .coffee)
    }

    func test_400円を投入するとコーヒーが出る() {
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        vendingMachine.insert(money: .hundred)
        let item = vendingMachine.dispence(beverage: .coffee)
        XCTAssertEqual(item, .coffee)
    }

}
