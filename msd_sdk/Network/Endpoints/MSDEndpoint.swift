enum MSDEndpoint {
    case discover
    case track(body: [String:Any?])
    case search(body: [String:Any?])
}

extension MSDEndpoint: APIRequestProtocol {
    var path: String {
        switch self {
        case .discover:
            return DISCOVER_EVENTS_ENDPOINT
        case .track:
            return TRACK_ENDPOINT
        case .search:
            return SEARCH_RECOMMENDATION_ENDPOINT
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .discover:
            return .get
        case .track,.search:
            return .post
        }
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
        default:
            return nil
        }
    }
}
