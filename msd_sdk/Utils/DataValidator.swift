//
//  DataValidator.swift
//  msd_sdk
//
//  Created by Julien on 22/05/23.
//

import Foundation

class DataValidator {
    
    static func validateClientData(_ token: String?) throws {
        guard let token = token, !token.isEmpty else {
            throw SDKInitException(message: INIT_SDK_TOKEN_EXCEPTION)
        }
    }
    
    
    static func validateEventSanity(event: String?, properties:  [String: Any?]?) {
        var missingDataKeys: [String] = []
        guard let event = event, !event.isEmpty else{
            SDKLogger.logSDKInfo(
                LOG_INFO_TAG_EVENT_TRACKING,
                "An event was recorded without an event name"
            )
            return
        }
        if let keys = properties?.keys {
            for objectKey in keys {
                if properties?[objectKey] == nil {
                    missingDataKeys.append(objectKey)
                }
            }
        }
        if !missingDataKeys.isEmpty {
            let missingString = missingDataKeys.joined(separator: ", ")
            SDKLogger.logSDKInfo(
                LOG_INFO_TAG_EVENT_TRACKING,
                "An event was recorded without the following mandatory event properties \(missingString)"
            )
        }
    }
    
    static func validateRecommendationSanity(properties: [String: Any?]?, callback: RecommendationCallback) {
        var missingDataKeys: [String] = []
        
        if let keys = properties?.keys {
                for objectKey in keys {
                    if properties?[objectKey] == nil {
                        missingDataKeys.append(objectKey)
                    }
                }
            }
        if !missingDataKeys.isEmpty {
            let missingString = missingDataKeys.joined(separator: ", ")
            SDKLogger.logSDKInfo(
                LOG_INFO_TAG_RECOMMENDATION,
                "A recommendation request was made without the following data \(missingString)"
            )
        }
    }
}
