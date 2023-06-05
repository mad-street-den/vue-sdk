enum RequestError: Error {
    case noInternet
    case invalidURL
    case unauthorized
    case badRequest
    case outdated
    case failed
    case unexpectedStatusCode
    case noResponse
    case noData
    case unableToDecode
    case unknown
    
    var customMessage: String {
        switch self {
        case .noInternet:
            return "No internet connection available"
        case .invalidURL:
            return "Invalid URL to request"
        case .unauthorized:
            return "Session expired. You need to be authenticated first"
        case .badRequest:
            return "Bad request"
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .unexpectedStatusCode:
            return "Unexpected Status Code"
        case .noResponse:
            return "No response returned"
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."
        case .unknown:
            return "Unknown error"
        }
    }
}
