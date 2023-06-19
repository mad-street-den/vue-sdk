import Foundation

public struct MSDError: Codable, Error {
    let requestId: String?
    let correlationId: String?
    let errors: ApiError
    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case correlationId = "correlation_id"
        case errors
    }
    
    init(requestId: String? = nil, correlationId: String? = nil, errors: ApiError) {
        self.requestId = requestId
        self.correlationId = correlationId
        self.errors = errors
    }
}

public struct ApiError: Codable {
    let code: String
    let message: String
    
    public init(code: String, message: String) {
        self.code = code
        self.message = message
    }
    
    fileprivate func toMap() -> [String:Any?] {
        return ["code": code, "message": message]
    }
}

public extension MSDError {
    func toMap() -> [String: Any?] {
        var map: [String:Any?] = [:]
        map["requestId"] = requestId
        map["correlationId"] = correlationId
        map["errors"] = errors.toMap()
        return map
    }
    
    static func errorCode(_ code: ErrorCode) -> [String: Any?] {
        let error = ApiError(code: code.rawValue, message: code.message)
        return MSDError(requestId: nil, correlationId: nil, errors: error).toMap()
    }
    
    static let emptyToken = errorCode(.ERR001)
    static let emptyEventName = errorCode(.ERR002)
    static let missingEventData = errorCode(.ERR003)
    static let missingRecommendationData = errorCode(.ERR004)
    static let internetUnavailable = errorCode(.ERR005)
    static let requestTimeout = errorCode(.ERR006)
    static let invalidURL = errorCode(.ERR007)
    static let emptyUserId = errorCode(.ERR008)
    static let noResponse = errorCode(.ERR009)
    static let unableToDecode = errorCode(.ERR010)
    static let unknownError = errorCode(.ERR011)
    static let serverUnavailable = errorCode(.ERR012)
}

public enum ErrorCode: String {
    case ERR001
    case ERR002
    case ERR003
    case ERR004
    case ERR005
    case ERR006
    case ERR007
    case ERR008
    case ERR009
    case ERR010
    case ERR011
    case ERR012
    
    var message: String {
        switch  self{
        case .ERR001:
            return EMPTY_TOKEN
        case .ERR002:
            return EMPTY_EVENT_NAME
        case .ERR003:
            return MISSING_EVENT_DATA
        case .ERR004:
            return MISSING_RECOMMENDATION_DATA
        case .ERR005:
            return INTERNET_UNAVAILABLE
        case .ERR006:
            return REQUEST_TIMEOUT
        case .ERR007:
            return INVALID_URL
        case .ERR008:
            return EMPTY_USER_ID
        case .ERR009:
            return NO_RESPONSE
        case .ERR010:
            return UNABLE_TO_DECODE
        case .ERR011:
            return UNKNOWN_ERROR
        case .ERR012:
            return SERVER_UNAVAILABLE
        }
    }
}
