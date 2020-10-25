import Foundation

extension JSONDecoder {
    /// A default implementation of JSONDecoder, with .iso8601 date strategy
    static var iso8601: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }

    static var `default`: JSONDecoder {
        JSONDecoder()
    }
}
