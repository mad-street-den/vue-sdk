protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any?]? { get }
}

extension Endpoint {
    var scheme: String {
        return "http" + "://"
    }
    
    var host: String {
        return "13.234.201.82:6001/v1"
    }
}
