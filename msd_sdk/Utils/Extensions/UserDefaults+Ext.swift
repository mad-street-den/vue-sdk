import Foundation

enum UserDefaultsKeys: String {
    case MAD_UUID = "mad_uuid"
}

extension UserDefaults {
    func setUserDefaultString(key: String, value: String) {
        set(value, forKey: key)
        synchronize()
    }
    
    func getUserDefaultString(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    func clearSpecificDataInUserDefault(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        synchronize()
    }
}
