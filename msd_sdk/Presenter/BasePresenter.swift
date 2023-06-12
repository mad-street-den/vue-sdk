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
    
    func getCurrentTimestamp() -> Int {
        let timestamp = Int(Date().timeIntervalSince1970)
        return timestamp
    }
    
    func addDefaultProperties(properties: inout [String:Any?]) {
        properties.updateValue(getMadUUID(), forKey: BLOX_UUID)
        properties.updateValue(getUserId(), forKey: USER_ID)
        properties.updateValue(getBundleId(), forKey: URL_STRING)
    }
}
