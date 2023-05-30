//
//  Utils.swift
//  msd_sdk
//
//  Created by Julien on 29/05/23.
//

import Foundation

class Utils {
    static func checkNullOrEmptyString(_ value: String?) -> Bool {
            guard let stringValue = value, !stringValue.isEmpty else {
                return true // String is null or empty
            }
            return false // String is not null or empty
        }
}
