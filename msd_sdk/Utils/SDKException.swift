import Foundation

class SDKInitException: Error {
    let isNetworkError: Bool
    let code: Int
    let status: Int
    
    init(message: String?, isNetworkError: Bool = false, code: Int = 0, status: Int = 0) {
        self.isNetworkError = isNetworkError
        self.code = code
        self.status = status
    }
}
