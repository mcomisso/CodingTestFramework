import Foundation

public enum Method: String {
    case get = "GET"
    case post =  "POST"
    case delete = "DELETE"
    case put = "PUT"

    // Can be completed with other HTTP methods
}

public struct Request<Value> {
    
    var method: Method
    var path: String
    var queryParams: [String: String]
    
    init(method: Method = .get, path: String, pars: [String: String]) {
        self.method = method
        self.path = path
        self.queryParams = pars
    }
    
}
