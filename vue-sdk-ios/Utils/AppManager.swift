import Foundation

class AppManager {
    static let shared = AppManager()
    var msdBaseUrl: String?
    var apiToken: String?
    
    private init() {}
}
