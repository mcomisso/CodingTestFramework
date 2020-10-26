import Foundation

public enum APIError: Error {
    case invalidURL
    case noResponse
}

public protocol API {
    var baseAPI: URLComponents { get }
}
