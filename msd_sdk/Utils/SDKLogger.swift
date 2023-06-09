import Foundation

class SDKLogger {
    static let shared = SDKLogger()
    var isLoggingEnabled: Bool = false
    
    private init() {}
    
    func logSDKInfo(_ tag: String, _ message: String) {
        if isLoggingEnabled {
            print(tag,message)
        }
    }
}
