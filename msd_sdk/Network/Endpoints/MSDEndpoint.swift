enum MSDEndpoint {
    case track(body: [String: Any?])
    case search(body: [String: Any?])
}

extension MSDEndpoint: APIRequestProtocol {
    var path: String {
        switch self {
        case .track:
            return "/products"
        case .search:
            return "/search"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .track, .search:
            return .post
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .track, .search:
            return ["Authorization": "token"]
        }
    }
    
    var body: [String: Any?]? {
        switch self {
        case .track(_):
            return ["page": 1]
        case .search(let body):
            return ["values": body]
        }
    }
}
