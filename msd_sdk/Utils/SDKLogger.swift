//
//  SDKLogger.swift
//  msd_sdk
//
//  Created by Julien on 22/05/23.
//

import Foundation
class SDKLogger{
    
    static let shared = SDKLogger()
   
    var isLoggingEnabled:Bool = true
    private init() {
         // Private initializer to prevent direct instantiation
     }
    func logSDKInfo(_ tag: String,_ message: String) {
        if isLoggingEnabled {
            print(tag,message)
        }
    }
}
