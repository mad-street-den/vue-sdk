enum VueSDKEndpoint {
    case discover
    case track(body: [String: Any?], headers: [String: String]?)
    case search(body: [String: Any?], headers: [String: String]?)
}

extension VueSDKEndpoint: APIRequestProtocol {
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
        case .track, .search:
            return .post
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .track(_, let headers?),
             .search(_, let headers?):
            return headers
        default:
            return nil
        }
    }
    
    var body: [String: Any?]? {
        switch self {
        case .track(body: let body, _):
            return body
        case .search(body: let body, _):
            return body
        default:
            return nil
        }
    }
}
