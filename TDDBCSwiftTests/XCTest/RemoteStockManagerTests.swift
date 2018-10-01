//
//  RemoteManagerTests.swift
//  TDDBCSwiftTests
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import XCTest
@testable import TDDBCSwift

class RemoteStockManagerTests: XCTestCase {

    var remoteStockManager: RemoteStockManager!
    var fetcher: MockRemoteStockFetcher!
    var sender: MockRemoteAlertSender!

    override func setUp() {
        super.setUp()
        fetcher = MockRemoteStockFetcher()
        sender = MockRemoteAlertSender()
        remoteStockManager = RemoteStockManager(fetcher: fetcher, sender: sender)
    }

    override func tearDown() {
        remoteStockManager = nil
        fetcher = nil
        sender = nil
        super.tearDown()
    }
    
    // TODO
    // x通信モジュールから在庫数が取得できる
    //  xコーラの在庫数をリモートに問い合わせると、コーラの在庫数が取得できる
    //  xコーヒーの在庫数をリモートに問い合わせると、コーヒーの在庫数が取得できる
    //  xリモートに問い合わせをするがサーバーがエラーを返した場合、在庫数は取得できない
    //  xリモートに問い合わせをするがサーバーがHTTPレスポンスのエラーコードを返した場合、在庫数は取得できない
    // x在庫数が2つ以下になった時にリモートにアラートを通知する
    //  xアラートをリモートに送るメソッドを呼ぶと、リモートへの通信が開始される

    func test_アラートをリモートに送るメソッドを呼ぶと_リモートへの通信が開始される() {
        remoteStockManager.sendAlert { result in
            XCTAssertTrue(result)
        }
    }
    
    func test_リモートに問い合わせをするがサーバーがHTTPレスポンスのエラーコードを返した場合_在庫数は取得できない() {
        
        remoteStockManager = RemoteStockManager(fetcher: MockRemoteHttpResponseErrorFetcher(), sender: sender)
        
        remoteStockManager.getStock(of: .cola) { stock in
            XCTAssertNil(stock)
        }
    }
    
    func test_リモートに問い合わせをするがサーバーがエラーを返した場合_在庫数は取得できない() {
        
        remoteStockManager = RemoteStockManager(fetcher: MockRemoteErrorFetcher(), sender: sender)
        
        remoteStockManager.getStock(of: .cola) { stock in
            XCTAssertNil(stock)
        }
    }
    
    func test_コーヒーの在庫数をリモート監視に問い合わせると_コーヒーの在庫数が取得できる() {
        
        remoteStockManager.getStock(of: .coffee) { stock in
            
            guard let stock = stock else {
                XCTFail()
                return
            }
            XCTAssertEqual(stock.count, 20)
        }
    }
    
    func test_コーラの在庫数をリモート監視に問い合わせると_コーラの在庫数が取得できる() {
        
        remoteStockManager.getStock(of: .cola) { stock in
            guard let stock = stock else {
                XCTFail()
                return
            }
            XCTAssertEqual(stock.count, 10)
        }
    }
    
    class MockRemoteStockFetcher: RemoteStockFechable {
        
        func getStock(of beverage: Beverage, completion: @escaping (Data?, Error?) -> Void) {
            
            let jsonString: String
            switch beverage {
            case .cola:
                jsonString = "{\"count\": 10}"
            case .oolongTea:
                jsonString = "{\"count\": 15}"
            case .coffee:
                jsonString = "{\"count\": 20}"
            case .redBull:
                jsonString = "{\"count\": 25}"
            case .beer:
                jsonString = "{\"count\": 30}"
            }
            let data = jsonString.data(using: .utf8)            
            completion(data, nil)
        }
    }
    
    class MockRemoteErrorFetcher: RemoteStockFechable {
        func getStock(of beverage: Beverage, completion: @escaping (Data?, Error?) -> Void) {
            let error = NSError(domain: "error", code: 999, userInfo: nil)
            completion(nil, RemoteError.clientError(error))
        }
    }
    
    class MockRemoteHttpResponseErrorFetcher: RemoteStockFechable {
        func getStock(of beverage: Beverage, completion: @escaping (Data?, Error?) -> Void) {
            let data = "{\"count\": 30}".data(using: .utf8)
            completion(data, RemoteError.serverError)
        }
    }
    
    class MockRemoteAlertSender: RemoteAlertSendable {
        
        var didSendAlert = false

        func sendAlert(completion: @escaping (Bool) -> Void) {
            didSendAlert = true
            completion(true)
        }
    }
}
