//
//  SDKLogger.swift
//  msd_sdk
//
//  Created by Julien on 22/05/23.
//

import Foundation
class SDKLogger{
    static var isLoggingEnabled = true
    
    static func logSDKInfo(_ tag: String,_ message: String) {
        if isLoggingEnabled {
            print(tag,message)
        }
    }
}
