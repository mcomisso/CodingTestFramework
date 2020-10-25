import Foundation

extension URL: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        guard let url = URL(string: value) else {
            fatalError("This does not seem a valid URL")
        }
        self = url
    }

    /// - Parameter queryItems: the list of query items to use
    /// - Returns: Returns the same url, by appending the input queryItems
    func url(with queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!

        components.queryItems = (components.queryItems ?? []) + queryItems

        return components.url!
    }

}
