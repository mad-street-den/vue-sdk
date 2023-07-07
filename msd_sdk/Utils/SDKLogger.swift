import Foundation

class SDKLogger {
    static let shared = SDKLogger()
    var isLoggingEnabled: Bool = false
    
    private init() {}
    
    func logSDKInfo(_ tag: String, _ message: String,isForceLog : Bool = false) {
        if (isLoggingEnabled || isForceLog){
            print(tag,message)
        }
    }
}
