enum MSDEndpoint {
    case track(body: [String:Any?])
    case search(body: [String:Any?])
}

extension MSDEndpoint: APIRequestProtocol {
    var path: String {
        switch self {
        case .track:
            return TRACK_ENDPOINT
        case .search:
            return SEARCH_RECOMMENDATION_ENDPOINT
        }
    }
    
    var method: RequestMethod {
        return .post
    }
    
    var header: [String:String]? {
        return [:]
    }
    
    var body: [String:Any?]? {
        switch self {
        case .track(let body):
            return body
        case .search(let body):
            return body
        }
    }
}
