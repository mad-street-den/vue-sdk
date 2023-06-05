import Foundation

public struct MSDError: Codable {
    let requestId: String?
    let correlationId: String?
    let errors: [ApiError]
    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case correlationId = "correlation_id"
        case errors
    }
    init(requestId: String? = nil, correlationId: String? = nil, errors: [ApiError]) {
        self.requestId = requestId
        self.correlationId = correlationId
        self.errors = errors
    }
}

struct ApiError: Codable {
    let code: String
    let message: String
}
