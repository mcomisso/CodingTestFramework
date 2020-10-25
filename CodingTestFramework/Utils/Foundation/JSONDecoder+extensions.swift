import Foundation

extension JSONDecoder {
    /// A default implementation of JSONDecoder, with .iso8601 date strategy
    static var `default`: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }
}
