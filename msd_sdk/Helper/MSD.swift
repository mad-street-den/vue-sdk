//
//  MSD.swift
//  ios_sdk
//
//  Created by JIju S Jacob on 22/05/23.
//

import Foundation

public class MSD{
    
    init(token: String?) throws{
        try DataValidator.validateClientData(token)
        let eventPresenter = EventPresenter()
    }
    
    public static func getInstance(token:String)throws -> MSD {
        return try MSD(token: token)
    }
    
    public func track(eventName: String, properties: [String: Any?]){
        DataValidator.validateEventSanity(event: eventName, properties: properties)
        EventPresenter().trackEvent(eventName: eventName, properties: properties)
        
    }
    
    public func getRecommendations(properties: [String: Any?], callback: RecommendationCallback){
        //search recommendations
        DataValidator.validateRecommendationSanity(properties: properties, callback: callback)
        
    }
    
}

