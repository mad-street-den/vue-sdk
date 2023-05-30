//
//  DataValidator.swift
//  msd_sdk
//
//  Created by Julien on 22/05/23.
//

import Foundation

class DataValidator {
    
    static func validateClientData(_ token: String?,baseUrl:String?)->String?  {
        //validate API token
        if Utils.checkNullOrEmptyString(token) {
            SDKLogger.shared.logSDKInfo(
                INIT_SDK_TOKEN_EXCEPTION,
                "SDK Init Exception"
            )
            return nil
        }
        
        //validate baseURL
        if Utils.checkNullOrEmptyString(baseUrl) {
            SDKLogger.shared.logSDKInfo(
                INIT_SDK_BASE_URL_EXCEPTION,
                "SDK Init Exception"
            )
            return nil
        }
        
        return token
    }
    
    static func validateUserId(_ userId:String?) -> String?{
        if Utils.checkNullOrEmptyString(userId){
            SDKLogger.shared.logSDKInfo(
                INIT_USER_ID_EXCEPTION,
                "User ID is not specified"
            )
            return nil
        }
        return userId
    }
    
    static func validateEventSanity(event: String?, apiToken:String?, baseUrl:String?, properties:  [String: Any?]?) -> String?{
        //validate API token
        if Utils.checkNullOrEmptyString(apiToken){
            SDKLogger.shared.logSDKInfo(
                INIT_SDK_TOKEN_EXCEPTION,
                "Track Event called before setting API token"
            )
            return nil
        }
        
        //validate base URL
        if Utils.checkNullOrEmptyString(baseUrl){
            SDKLogger.shared.logSDKInfo(
                INIT_SDK_BASE_URL_EXCEPTION,
                "Track Event called before setting base URL"
            )
            return nil
        }
        
        var missingDataKeys: [String] = []
        if Utils.checkNullOrEmptyString(event){
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_EVENT_TRACKING,
                "An event was recorded without an event name"
            )
            return nil
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
            SDKLogger.shared.logSDKInfo(
                LOG_INFO_TAG_EVENT_TRACKING,
                "An event was recorded without the following mandatory event properties \(missingString)"
            )
            return nil
        }
        return event
    }
    
    static func validateRecommendationSanity(apiToken:String?, baseUrl:String?, properties: RecommendationRequest,completionHandler:  @escaping ([String:Any?]?, MSDError?) -> Void) {
        //validate API token
        if Utils.checkNullOrEmptyString(apiToken){
            completionHandler(nil, MSDError(errors: [ApiError(code: "ERR001", message: "Get Recommendations called before setting API token")]))
            SDKLogger.shared.logSDKInfo(
                INIT_SDK_TOKEN_EXCEPTION,
                "Get Recommendations method called before setting API token"
            )
        }
        
        //validate BaseURL
        if Utils.checkNullOrEmptyString(baseUrl){
            completionHandler(nil, MSDError(errors: [ApiError(code: "ERR007", message: "Get Recommendations method called before setting Base URL")]))
            SDKLogger.shared.logSDKInfo(
                INIT_SDK_BASE_URL_EXCEPTION,
                "Get Recommendations method called before setting Base URL"
            )
        }
        
        //TODO: Add Recommendation Sanity Checks
    }
}
