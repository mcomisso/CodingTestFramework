//
//  APICacher.swift
//  GoustoTest
//
//  Created by Matteo Comisso on 28/06/2020.
//  Copyright © 2020 Matteo Comisso. All rights reserved.
//

import Foundation

public class APICacher {

    let cache: URLCache

    init(cache: URLCache = .shared) {
        self.cache = cache
    }

    func cacheResponse(for request: URLRequest, response: URLResponse?, data: Data) {
        guard let response = response else { return }
        cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
    }

    func storedData(for request: URLRequest) -> Data? {
        cache.cachedResponse(for: request)?.data
    }

}
