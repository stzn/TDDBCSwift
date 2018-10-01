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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // TODO
    // リモートと正しく通信してアラートを通知する
    //  コーラの在庫数が少ないというアラートを正しいURLで通信した場合、正常なレスポンスを返す
    //  コーヒーの在庫数が少ないというアラートを正しいURLで通信した場合、正常なレスポンスを返す
    //  サーバーからエラーが返ってきた場合、エラーレスポンスを返す
    //  サーバーからレスポンスのステータスコードが399の場合、正常なレスポンスを返す
    //  サーバーからレスポンスのステータスコードが199の場合、エラーレスポンスを返す
    //  サーバーからレスポンスのステータスコードが400の場合、エラーレスポンスを返す
    
    func test_コーラの在庫数が少ないというアラートを正しいURLで通信した場合_正常なレスポンスを返す() {
        
        let sender = RemoteAlertSender()
        var success: Bool = false
        sender.sendAlert { result in
            success = result
        }
        XCTAssertTrue(success)

    }
    
}
