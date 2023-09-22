import Foundation

public class VueSDKConfig {
    let medium: String?
    let url: String?
    let platform: String?
    let referrer: String?
    
    public init(medium: String? = nil, url: String? = nil,platform: String? = nil, referrer: String? = nil) {
        self.medium = medium
        self.url = url
        self.platform = platform
        self.referrer = referrer
    }
}
