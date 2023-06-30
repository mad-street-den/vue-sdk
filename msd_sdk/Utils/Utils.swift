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
        let urlPattern = #"""
                (?i)\b((?:https?|ftp):\/\/|www\.)\S+\.\S+\b([-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))
                """#
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlPattern)
        return urlTest.evaluate(with: url)
    }
    
}

