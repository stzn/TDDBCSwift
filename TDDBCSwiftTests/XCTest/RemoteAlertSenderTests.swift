//
//  RemoteAlertSenderTests.swift
//  TDDBCSwiftTests
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import XCTest
@testable import TDDBCSwift

class RemoteAlertSenderTests: XCTestCase {

    let url = URL(string: "https://vending.com/alert")!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // TODO
    // リモートと正しく通信してアラートを通知する
    //  xコーラの在庫数が少ないというアラートを正しいRequestでPOST通信した場合、正常なレスポンスを返す
    //  xコーヒーの在庫数が少ないというアラートを正しいRequestでPOST通信した場合、正常なレスポンスを返す
    //  xサーバーからエラーが返ってきた場合、エラーレスポンスを返す
    //  xサーバーからのレスポンスのステータスコードが399の場合、正常なレスポンスを返す
    //  サーバーからのレスポンスのステータスコードが199の場合、エラーレスポンスを返す
    //  サーバーからのレスポンスのステータスコードが400の場合、エラーレスポンスを返す

    func test_サーバーからのレスポンスのステータスコードが199の場合_エラーレスポンスを返す() {
    
        let url = URL(string: "https://vending.com/alert")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 199, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: httpReponse, error: nil)
        let sender = RemoteAlertSender(urlSession: urlSession)
        var success: Bool = false
    
        let exp = expectation(description: "サーバーからのレスポンスのステータスコードが199の場合、エラーレスポンスを返す")
        sender.sendAlert(of: .cola) { result in
            success = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertFalse(success)
        }
    }

    func test_サーバーからのレスポンスのステータスコードが399の場合_正常なレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/alert")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 399, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: httpReponse, error: nil)
        let sender = RemoteAlertSender(urlSession: urlSession)
        var success: Bool = false
        
        let exp = expectation(description: "サーバーからのレスポンスのステータスコードが399の場合、正常なレスポンスを返す")
        sender.sendAlert(of: .cola) { result in
            success = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertTrue(success)
        }
        
    }

    func test_サーバーからエラーが返ってきた場合_エラーレスポンスを返す() {
        
        let url = URL(string: "https://vending.com/alert")!
        let httpReponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: httpReponse, error: RemoteError.dataNilError)
        let sender = RemoteAlertSender(urlSession: urlSession)
        var success: Bool = false

        let exp = expectation(description: "サーバーからエラーが返ってきた場合_エラーレスポンスを返す")
        sender.sendAlert(of: .cola) { result in
            success = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            XCTAssertFalse(success)
        }

    }
    
    func test_コーヒーの在庫数が少ないというアラートを正しいRequestでPOST通信した場合_正常なレスポンスを返す() {
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: response, error: nil)
        let sender = RemoteAlertSender(urlSession: urlSession)
        var success: Bool = false
        
        let exp = expectation(description: "コーヒーの在庫数が少ないというアラートを正しいRequestでPOST通信した場合、正常なレスポンスを返す")
        sender.sendAlert(of: .coffee) { result in
            success = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in
            
            guard let beverage = self.getBeverage(body: urlSession.request?.httpBody) else {
                XCTFail()
                return
            }
            XCTAssertEqual(beverage, .coffee)
            XCTAssertEqual(urlSession.request?.httpMethod, "POST")
            XCTAssertTrue(success)
        }
    }
    
    func test_コーラの在庫数が少ないというアラートを正しいRequestで通信した場合_正常なレスポンスを返す() {
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: Data(), urlResponse: response, error: nil)
        let sender = RemoteAlertSender(urlSession: urlSession)
        var success: Bool = false
        
        let exp = expectation(description: "コーラの在庫数が少ないというアラートを正しいRequestで通信した場合_正常なレスポンスを返す")
        sender.sendAlert(of: .cola) { result in
            success = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 3) { error in

            guard let beverage = self.getBeverage(body: urlSession.request?.httpBody) else {
                    XCTFail()
                    return
            }
            XCTAssertEqual(beverage, .cola)
            XCTAssertEqual(urlSession.request?.httpMethod, "POST")
            XCTAssertTrue(success)
        }
    }
    
    private func getBeverage(body: Data?) -> Beverage? {
        
        guard
            let body = body,
            let parameter = try? JSONDecoder().decode([String: String].self, from: body),
            let name = parameter["name"],
            let beverage = Beverage(rawValue: name)
            else {
                return nil
        }
        return beverage
    }
    
}
