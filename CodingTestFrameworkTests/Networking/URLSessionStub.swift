//
//  URLSessionMock.swift
//  GoustoTest
//
//  Created by Matteo Comisso on 27/06/2020.
//  Copyright © 2020 Matteo Comisso. All rights reserved.
//

import Foundation
import XCTest

final class URLSessionStub: URLProtocol {

    static var mockedRequest: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = Self.mockedRequest else {
            fatalError("Please provide a mocked request")
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }
}

extension URLSessionConfiguration {
    static var mockedConfiguration: URLSessionConfiguration {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLSessionStub.self]
        return config
    }
}

extension URLSession {
    static var mocked: URLSession {
        URLSession(configuration: .mockedConfiguration)
    }
}
