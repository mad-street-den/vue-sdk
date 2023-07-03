import Foundation
import UIKit

class Utils {
    static func checkNullOrEmptyString(_ value: String?) -> Bool {
        guard let stringValue = value, !stringValue.isEmpty else {
            return true
        }
        return false
    }
    
    static func checkEmptyString(_ value: String) -> Bool {
        guard !value.isEmpty else {
            return true
        }
        return false
    }
    
    static func isValidUrl(_ url: String) -> Bool {
        if url.isEmpty {
            return false
        }
        return url.lowercased().hasPrefix("http://") || url.lowercased().hasPrefix("https://")
    }
}

