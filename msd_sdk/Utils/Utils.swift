import Foundation

class Utils {
    static func checkNullOrEmptyString(_ value: String?) -> Bool {
        guard let stringValue = value, !stringValue.isEmpty else {
            return true
        }
        return false
    }
}
