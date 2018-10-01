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
    // リモートと正しく通信して全ての在庫数を取得する

    func test_リモートと正しく通信して全ての在庫数を取得する() {
        
        let url = URL(string: "https://vending.com/stocks")!
        let urlSession = createMockURLSessionFrom(url: url, statusCode: 200)
        let exp = expectation(description: "リモートと正しく通信して全ての在庫数を取得する")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedData: Data?
        fetcher.getStocks() { data, error in
            returnedData = data
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertEqual(urlSession.url, url)
            XCTAssertNotNil(returnedData)
        }
    }
    
    func test_サーバーからエラーではないがデータが返ってこなかった場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=cola")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: nil, urlResponse: httpReponse, error: nil)

        let exp = expectation(description: "サーバーからエラではないがデータが返ってこなかった場合、エラーレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedError: Error?
        fetcher.getStock(of: .cola) { data, error in
            returnedError = error
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertTrue(returnedError is RemoteError)
        }
    }

    
    func test_サーバーからレスポンスのステータスコードが199の場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=cola")!
        let urlSession = createMockURLSessionFrom(url: url, statusCode: 199)
        
        let exp = expectation(description: "サーバーからレスポンスのステータスコードが199の場合、エラーレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedError: Error?
        fetcher.getStock(of: .cola) { data, error in
            returnedError = error
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertTrue(returnedError is RemoteError)
        }
    }
    
    func test_サーバーからレスポンスのステータスコードが399の場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=cola")!
        let urlSession = createMockURLSessionFrom(url: url, statusCode: 399)

        let exp = expectation(description: "サーバーからレスポンスのステータスコードが399の場合、エラーレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedError: Error?
        fetcher.getStock(of: .cola) { data, error in
            returnedError = error
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertNil(returnedError)
        }
    }

    func test_サーバーからエラーが返ってきた場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=cola")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: httpReponse, error: RemoteError.dataNilError)
        
        let exp = expectation(description: "サーバーからエラーが返ってきた場合、エラーレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedError: Error?
        fetcher.getStock(of: .cola) { data, error in
            returnedError = error
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertTrue(returnedError is RemoteError)
        }
    }
    
    func test_コーヒーの在庫数を取得する正しいURLで通信した場合_正常なレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=coffee")!
        let urlSession = createMockURLSessionFrom(url: url, statusCode: 200)
        
        let exp = expectation(description: "コーヒーの在庫数を取得する正しいURLで通信した場合、正常なレスポンスを返す")
        
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedData: Data?
        fetcher.getStock(of: .coffee) { data, error in
            returnedData = data
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertEqual(urlSession.url, url)
            XCTAssertNotNil(returnedData)
        }
    }

    func test_コーラの在庫数を取得する正しいURLで通信した場合_正常なレスポンスを返す() {

        let url = URL(string: "https://vending.com/stock?name=cola")!
        let urlSession = createMockURLSessionFrom(url: url, statusCode: 200)
        
        let exp = expectation(description: "コーラの在庫数を取得する正しいURLで通信した場合_正常なレスポンスを返す")
        let fetcher = RemoteStockFetcher(urlSession: urlSession)
        var returnedData: Data?
        fetcher.getStock(of: .cola) { data, error in
            returnedData = data
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertEqual(urlSession.url, url)
            XCTAssertNotNil(returnedData)
        }
    }
    
    private func createMockURLSessionFrom(url: URL, statusCode: Int) -> MockURLSession {
        let httpReponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        return MockURLSession(data: Data(), urlResponse: httpReponse, error: nil)
    }

}
