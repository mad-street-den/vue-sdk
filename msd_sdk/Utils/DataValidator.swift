import Foundation

class DataValidator {
    static func validateClientToken(_ token: String) -> Bool {
        if Utils.checkEmptyString(token) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_GENERIC,
                "ERROR: \(MSDError.emptyToken)"
            )
            return false
        }
        return true
    }
    
    static func validateClientbaseUrl(_ baseUrl: String) -> Bool{
        if Utils.checkEmptyString(baseUrl) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_GENERIC,
                "ERROR: \(MSDError.invalidURL)"
            )
            return false
        }
        return true
    }
    
    static func validateUserId(_ userId: String) -> String? {
        if Utils.checkEmptyString(userId) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_GENERIC,
                "ERROR: \(MSDError.emptyUserId)"
            )
            return nil
        }
        return userId
    }
    
    static func validateEventSanity(eventName: String, pageName: String) -> Bool {
        if Utils.checkEmptyString(eventName) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_EVENT_TRACKING,
                "ERROR: \(MSDError.emptyEventName)"
            )
            return false
        }
        
        if Utils.checkEmptyString(pageName) {
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_EVENT_TRACKING,
                "ERROR: \(MSDError.missingEventData)"
            )
            return false
        }
        return true
    }
}
