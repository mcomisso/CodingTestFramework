//
//  APITests.swift
//  GoustoTest
//
//  Created by Matteo Comisso on 27/06/2020.
//  Copyright © 2020 Matteo Comisso. All rights reserved.
//

import Foundation
import XCTest
@testable import CodingTestFramework

class MockedAPIClass: APIRequest {
    typealias RequestDataType = [AnyHashable : Any]
    typealias ResponseDataType = String

    func makeRequest(from data: [AnyHashable : Any]) throws -> URLRequest {
        let url: URL = "https://mcomisso.me"
        return URLRequest(url: url)
    }

    func parseResponse(data: Data) throws -> String {
        return "response"
    }
}

class ProductListAPITests: XCTestCase {
    var api: MockedAPIClass!

    override func setUpWithError() throws {
        self.api = MockedAPIClass()
    }

    func testDefaultInitializerParameters() throws {
        let request = try api.makeRequest(from: [:])
        let urlComponents = request.url
        XCTAssertEqual(urlComponents?.scheme, "https")
        XCTAssertEqual(request.url?.host, "mcomisso.me")
        XCTAssertEqual(request.url?.path, "")
        XCTAssertNil(request.url?.query)
    }

    func testBuildURL_WithNoParameters() throws {
        let request = try api.makeRequest(from: [:])
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.scheme, "https")
        XCTAssertEqual(request.url?.host, "mcomisso.me")
        XCTAssertEqual(request.url?.path, "")
        XCTAssertNil(request.url?.query)
    }
}
