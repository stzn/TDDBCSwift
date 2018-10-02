//
//  RemoteStockFetcherTests.swift
//  TDDBCSwiftTests
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import XCTest
@testable import TDDBCSwift

class RemoteStockFetcherTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // TODO
    // xリモートと正しく通信して在庫数を取得する
    //   xコーラの在庫数を取得する正しいURLで通信した場合、正常なレスポンスを返す
    //   xコーヒーの在庫数を取得する正しいURLで通信した場合、正常なレスポンスを返す
    //   xサーバーからエラーが返ってきた場合、エラーレスポンスを返す
    //   xサーバーからレスポンスのステータスコードが399の場合、正常なレスポンスを返す
    //   xサーバーからレスポンスのステータスコードが199の場合、エラーレスポンスを返す
    //   xサーバーからレスポンスのステータスコードが400の場合、エラーレスポンスを返す
    //   xサーバーからエラーではないがデータが返ってこなかった場合、エラーレスポンスを返す
    // xリモートと正しく通信して全ての在庫数を取得する

    func test_リモートと正しく通信して全ての在庫数を取得する() {
        
        let url = URL(string: "https://vending.com/stocks")!
        
        let stocks = [
            Stock(beverage: .cola, count: 10),
            Stock(beverage: .oolongTea, count: 15),
            Stock(beverage: .coffee, count: 20),
            Stock(beverage: .redBull, count: 25),
            Stock(beverage: .beer, count: 30)
        ]
        let urlSession = createMockURLSessionFrom(item: stocks, url: url, statusCode: 200)
        let exp = expectation(description: "リモートと正しく通信して全ての在庫数を取得する")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedResult: Result<[Stock], Error>? = nil
        fetcher.getAllStock() { result in
            returnedResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertEqual(urlSession.url, url)
            XCTAssertFalse(returnedResult?.value?.isEmpty ?? false)
            XCTAssertNil(returnedResult?.error)
        }
    }
    
    func test_サーバーからエラーではないがデータが返ってこなかった場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=cola")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: nil, urlResponse: httpReponse, error: nil)

        let exp = expectation(description: "サーバーからエラではないがデータが返ってこなかった場合、エラーレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedError: Error?
        fetcher.getStock(of: .cola) { result in
            returnedError = result.error
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertTrue(returnedError is RemoteError)
        }
    }

    
    func test_サーバーからレスポンスのステータスコードが199の場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=cola")!
        let urlSession = createMockURLSessionFrom(item: Optional<Stock>.none, url: url, statusCode: 199)
        
        let exp = expectation(description: "サーバーからレスポンスのステータスコードが199の場合、エラーレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedError: Error?
        fetcher.getStock(of: .cola) { result in
            returnedError = result.error
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertTrue(returnedError is RemoteError)
        }
    }
    
    func test_サーバーからレスポンスのステータスコードが399の場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=cola")!
        let urlSession = createMockURLSessionFrom(item: Optional<Stock>.none, url: url, statusCode: 399)

        let exp = expectation(description: "サーバーからレスポンスのステータスコードが399の場合、エラーレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedError: Error?
        fetcher.getStock(of: .cola) { result in
            returnedError = result.error
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertTrue(returnedError is RemoteError)
        }
    }

    func test_サーバーからエラーが返ってきた場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=cola")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: httpReponse, error: RemoteError.dataNilError)
        
        let exp = expectation(description: "サーバーからエラーが返ってきた場合、エラーレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedError: Error?
        fetcher.getStock(of: .cola) { result in
            returnedError = result.error
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertTrue(returnedError is RemoteError)
        }
    }
    
    func test_コーヒーの在庫数を取得する正しいURLで通信した場合_正常なレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=coffee")!
        let urlSession = createMockURLSessionFrom(item: Stock(beverage: .coffee, count: 10), url: url, statusCode: 200)
        
        let exp = expectation(description: "コーヒーの在庫数を取得する正しいURLで通信した場合、正常なレスポンスを返す")
        
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedData: Stock?
        fetcher.getStock(of: .coffee) { result in
            returnedData = result.value
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertEqual(urlSession.url, url)
            XCTAssertNotNil(returnedData)
        }
    }

    func test_コーラの在庫数を取得する正しいURLで通信した場合_正常なレスポンスを返す() {

        let url = URL(string: "https://vending.com/stock?name=cola")!
        let urlSession = createMockURLSessionFrom(item: Stock(beverage: .cola, count: 3), url: url, statusCode: 200)
        
        let exp = expectation(description: "コーラの在庫数を取得する正しいURLで通信した場合_正常なレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedData: Stock?
        fetcher.getStock(of: .cola) { result in
            returnedData = result.value
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertEqual(urlSession.url, url)
            XCTAssertNotNil(returnedData)
        }
    }
    
    private func createMockURLSessionFrom<T: Encodable>(item: T?, url: URL, statusCode: Int) -> MockURLSession {
        let httpReponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        var data = Data()
        if let stock = item {
            data = try! JSONEncoder().encode(stock)
        }
        return MockURLSession(data: data, urlResponse: httpReponse, error: nil)
    }

}
