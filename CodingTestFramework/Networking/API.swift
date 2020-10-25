import Foundation

public enum APIError: Error {
    case invalidURL
    case noResponse
}

public protocol API {
    var baseAPI: URLComponents { get }
}

public extension API {
    var baseAPI: URLComponents {

        guard !LaunchArgumentReader.wasLaunched(.uiTestEnabled) else {
            return URLComponents(string: "http://localhost:8080/")!
        }
        return URLComponents(string: "https://api.gousto.co.uk/products/v2.0/")!
    }
}
