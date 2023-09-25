import Foundation

class BasePresenter {
    func getMadUUID() -> String {
        if let uuid = userDefaults.getUserDefaultString(key: UserDefaultsKeys.MAD_UUID.rawValue), !uuid.isEmpty {
            return uuid
        }
        let generatedUUID = UUID().uuidString
        userDefaults.setUserDefaultString(key: UserDefaultsKeys.MAD_UUID.rawValue, value: generatedUUID)
        return generatedUUID
    }
    
    func setMadUUID(madUUID: String) {
        userDefaults.setUserDefaultString(key: UserDefaultsKeys.MAD_UUID.rawValue, value: madUUID)
    }
    
    func setUserId(userId: String) {
        userDefaults.setUserDefaultString(key: UserDefaultsKeys.MSD_USER_ID.rawValue, value: userId)
    }
    
    func getUserId() -> String? {
        return userDefaults.getUserDefaultString(key: UserDefaultsKeys.MSD_USER_ID.rawValue)
    }
    
    func removeUserId() {
        userDefaults.removeData(key: UserDefaultsKeys.MSD_USER_ID.rawValue)
    }
    
    func getBundleId() -> String? {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            return bundleIdentifier
        } else {
            return nil
        }
    }
    
    func addSuperProperties(to properties: inout [String:Any?], sdkConfig: VueSDKConfig) {
        properties.updateValue(getMadUUID(), forKey: BLOX_UUID)
        properties.updateValue(getUserId(), forKey: USER_ID)
        sdkConfig.medium.map { properties[MEDIUM] = $0 } ?? (properties[MEDIUM] = application)
        sdkConfig.referrer.map { properties[REFERRER] = $0} ?? (properties[REFERRER] = ios)
        sdkConfig.url.map { properties[URL_STRING] = $0 } ?? (properties[URL_STRING] = getBundleId())
        sdkConfig.platform.map { properties[PLATFORM] = $0} ?? (properties[PLATFORM] = ios)
    }
}
