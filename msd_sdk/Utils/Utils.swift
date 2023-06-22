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
    
    static func isValidURL(_ urlString: String) -> Bool {
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
}

