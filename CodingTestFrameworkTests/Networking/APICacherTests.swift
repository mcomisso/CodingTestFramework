//
//  APICacherTests.swift
//  GoustoTestTests
//
//  Created by Matteo Comisso on 28/06/2020.
//  Copyright © 2020 Matteo Comisso. All rights reserved.
//

import Foundation
import XCTest
@testable import CodingTestFramework

class APICacherTests: XCTestCase {
    var apiCacher: APICacher!

    override func setUpWithError() throws {
        self.apiCacher = .init(cache: .init(memoryCapacity: 10_000_000, diskCapacity: 10_000_000))
    }

    override func tearDownWithError() throws {
        self.apiCacher = nil
    }

    func testSaveResponse() {

        XCTAssertEqual(self.apiCacher.cache.diskCapacity, 10_000_000)

        let url: URL = "https://google.com"
        let request: URLRequest = .init(url: url)
        let mockedResponse: HTTPURLResponse = .init(url: url, mimeType: nil, expectedContentLength: 200_000, textEncodingName: nil)

        self.apiCacher.cacheResponse(for: request, response: mockedResponse, data: "Content Data".data(using: .utf8)!)

        XCTAssertNotNil(self.apiCacher.storedData(for: request))
    }

    func testSaveTwiceDoesNotDuplicateStoredRequest() {

        XCTAssertEqual(self.apiCacher.cache.diskCapacity, 10_000_000)

        let url: URL = "https://google.com"
        let request: URLRequest = .init(url: url)
        let mockedResponse: HTTPURLResponse = .init(url: url, mimeType: nil, expectedContentLength: 200_000, textEncodingName: nil)

        self.apiCacher.cacheResponse(for: request, response: mockedResponse, data: "Content Data!".data(using: .utf8)!)

        let storedString = String.init(data: self.apiCacher.storedData(for: request)!, encoding: .utf8)
        XCTAssertEqual(storedString, "Content Data!")
    }

    func testOverwriteWithMostRecentsData() {

        XCTAssertEqual(self.apiCacher.cache.diskCapacity, 10_000_000)

        let url: URL = "https://google.com"
        let request: URLRequest = .init(url: url)
        let mockedResponse: HTTPURLResponse = .init(url: url, mimeType: nil, expectedContentLength: 200_000, textEncodingName: nil)

        self.apiCacher.cacheResponse(for: request, response: mockedResponse, data: "Content Data".data(using: .utf8)!)
        self.apiCacher.cacheResponse(for: request, response: mockedResponse, data: "Updated Data!".data(using: .utf8)!)

        let storedString = String.init(data: self.apiCacher.storedData(for: request)!, encoding: .utf8)
        XCTAssertEqual(storedString, "Updated Data!")
    }
}
