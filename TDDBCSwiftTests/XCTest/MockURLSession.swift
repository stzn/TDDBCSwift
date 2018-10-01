//
//  MockURLSession.swift
//  TDDBCSwiftTests
//
//  Created by Shinzan Takata on 2018/10/01.
//  Copyright © 2018 tddbc. All rights reserved.
//

import Foundation
@testable import TDDBCSwift

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
