//
//  APILoader.swift
//  GoustoTest
//
//  Created by Matteo Comisso on 27/06/2020.
//  Copyright © 2020 Matteo Comisso. All rights reserved.
//

import Foundation

public protocol APIRequest {
    associatedtype RequestDataType
    associatedtype ResponseDataType

    func makeRequest(from data: RequestDataType) throws -> URLRequest
    func parseResponse(data: Data) throws -> ResponseDataType
}

public class APILoader<Request: APIRequest> {
    let apiRequest: Request
    let urlSession: URLSession
    let apiCacher: APICacher

    init(apiRequest: Request, urlSession: URLSession = .shared, apiCacher: APICacher = .init()) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
        self.apiCacher = apiCacher
    }

    func loadAPIRequest(requestData: Request.RequestDataType,
                        completion: @escaping (Result<Request.ResponseDataType, Error>) -> Void) {
        do {
            let request = try apiRequest.makeRequest(from: requestData)

            urlSession.dataTask(with: request) { (data, response, error) in

                guard let data = data else {
                    self.recover(request: request, completion: completion)
                    return
                }

                do {

                    self.apiCacher.cacheResponse(for: request, response: response, data: data)

                    let parsedResponse = try self.apiRequest.parseResponse(data: data)

                    DispatchQueue.main.async {
                        completion(.success(parsedResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }.resume()
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
            return
        }
    }

    func recover(request: URLRequest, completion: @escaping ((Result<Request.ResponseDataType, Error>) -> Void)) {

        guard
            let data = self.apiCacher.storedData(for: request),
            let response = try? self.apiRequest.parseResponse(data: data) else {
                DispatchQueue.main.async { completion(.failure(APIError.noResponse)) }
                return
        }

        DispatchQueue.main.async {
            completion(.success(response))
        }
    }
}
