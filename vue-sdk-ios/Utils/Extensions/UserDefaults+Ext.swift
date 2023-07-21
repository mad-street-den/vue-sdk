import Foundation

enum UserDefaultsKeys: String {
    case MAD_UUID = "mad_uuid"
    case MSD_USER_ID = "msd_user_id"
}

extension UserDefaults {
    func setUserDefaultString(key: String, value: String) {
        set(value, forKey: key)
        synchronize()
    }
    
    func getUserDefaultString(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    func removeData(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        synchronize()
    }
}
