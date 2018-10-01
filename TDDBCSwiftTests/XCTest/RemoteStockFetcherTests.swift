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
    // リモートと正しく通信ができる
    //   xコーラの在庫数を正しいURLで通信した場合、正常なレスポンスを返す
    //   xコーヒーの在庫数を正しいURLで通信した場合、正常なレスポンスを返す
    //   コーラの在庫数を間違ったURLで通信したがサーバーからエラーが返ってきた場合、エラーレスポンスを返す

    func test_コーヒーの在庫数を正しいURLで通信した場合_正常なレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/stock?name=coffee")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: httpReponse, error: nil)
        
        let exp = expectation(description: "コーヒーの在庫数を正しいURLで通信した場合、正常なレスポンスを返す")
        
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

    func test_コーラの在庫数を正しいURLで通信した場合_正常なレスポンスを返す() {

        let url = URL(string: "https://vending.com/stock?name=cola")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: httpReponse, error: nil)
        
        let exp = expectation(description: "コーラの在庫数を正しいURLで通信した場合_正常なレスポンスを返す")
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
}

extension RemoteStockFetcherTests {
    
    class MockURLSession: SessionProtocol {
        
        var url: URL?
        var request: URLRequest?
        let dataTask: MockTask
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask(data: data, urlResponse: urlResponse, error: error)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping ResponseHandler) -> URLSessionDataTask {
            self.url = url
            dataTask.responseHandler = completionHandler
            return dataTask
        }
        
        func dataTask(with request: URLRequest, completionHandler: @escaping ResponseHandler) -> URLSessionDataTask {
            self.request = request
            dataTask.responseHandler = completionHandler
            return dataTask
        }
    }
    
    class MockTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        var responseHandler: ResponseHandler?
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.responseHandler?(self.data,
                                      self.urlResponse,
                                      self.responseError)
            }
        }
    }
    
}
