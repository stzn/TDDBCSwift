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

    override func setUp() {
        super.setUp()
        remoteStockManager = RemoteStockManager(fetcher: MockRemoteStockFetcher())
    }

    override func tearDown() {
        remoteStockManager = nil
        super.tearDown()
    }
    
    // TODO
    // x通信モジュールから在庫数が取得できる
    //  xコーラの在庫数をリモート監視に問い合わせると、コーラの在庫数が取得できる
    //  xコーヒーの在庫数をリモート監視に問い合わせると、コーヒーの在庫数が取得できる
    //  xインターネットに繋がっていない場合、リモートに問い合わせされず、在庫数は取得できない
    //  xリモートに問い合わせをするがサーバーがエラーを返した場合、在庫数は取得できない
    //  xリモートに問い合わせをするがサーバーがHTTPレスポンスのエラーコードを返した場合、在庫数は取得できない
    
    func test_リモートに問い合わせをするがサーバーがHTTPレスポンスのエラーコードを返した場合_在庫数は取得できない() {
        
        remoteStockManager = RemoteStockManager(fetcher: MockRemoteHttpResponseErrorFetcher())
        
        remoteStockManager.getStock(of: .cola) { stock in
            XCTAssertNil(stock)
        }
    }
    
    func test_リモートに問い合わせをするがサーバーがエラーを返した場合_在庫数は取得できない() {
        
        remoteStockManager = RemoteStockManager(fetcher: MockRemoteErrorFetcher())
        
        remoteStockManager.getStock(of: .cola) { stock in
            XCTAssertNil(stock)
        }
    }
    
    func test_インターネットに繋がっていない場合_リモートに問い合わせされず_在庫数は取得できない() {
        
        (remoteStockManager.fetcher as! MockRemoteStockFetcher).isOnline = false
        
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
        
        var isOnline = true
        
        func getStocks(of beverage: Beverage, completion: (Data?, URLResponse?, Error?) -> Void) {
            
            guard isOnline else {
                completion(nil, nil, RemoteError.offlineError)
                return
            }
            
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
            
            let url = URL(string: "hogehoge")!
            let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            completion(data, httpResponse, nil)
        }
    }
    
    class MockRemoteErrorFetcher: RemoteStockFechable {
        func getStocks(of beverage: Beverage, completion: (Data?, URLResponse?, Error?) -> Void) {
            completion(nil, HTTPURLResponse(), RemoteError.serverError)
        }
    }
    
    class MockRemoteHttpResponseErrorFetcher: RemoteStockFechable {
        func getStocks(of beverage: Beverage, completion: (Data?, URLResponse?, Error?) -> Void) {
            let url = URL(string: "hogehoge")!
            let httpResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
            let data = "{\"count\": 30}".data(using: .utf8)
            completion(data, httpResponse, nil)
        }
    }
}
