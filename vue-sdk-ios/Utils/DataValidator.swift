import Foundation

class DataValidator {
    static func validateClientToken(_ token: String) -> Bool {
        if Utils.checkEmptyString(token) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_GENERIC,
                "ERROR: \(VueSDKError.emptyToken)"
            )
            return false
        }
        return true
    }
    
    static func validateClientbaseUrl(_ baseUrl: String) -> Bool{
        if !Utils.isValidUrl(baseUrl) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_GENERIC,
                "ERROR: \(VueSDKError.invalidURL)"
            )
            return false
        }
        return true
    }
    
    static func validateUserId(_ userId: String) -> String? {
        if Utils.checkEmptyString(userId) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_GENERIC,
                "ERROR: \(VueSDKError.emptyUserId)"
            )
            return nil
        }
        return userId
    }
    
    static func validateEventSanity(eventName: String) -> Bool {
        if Utils.checkEmptyString(eventName) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_EVENT_TRACKING,
                "ERROR: \(VueSDKError.emptyEventName)"
            )
            return false
        }
        return true
    }
    
    static func validateBloxUUID(_ bloxUUID: String) -> String? {
        if Utils.checkEmptyString(bloxUUID) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_GENERIC,
                "ERROR: \(VueSDKError.emptyBloxUUID)"
            )
            return nil
        }
        return bloxUUID
    }
    
}
