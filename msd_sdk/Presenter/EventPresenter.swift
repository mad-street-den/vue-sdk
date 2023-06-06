import Foundation

class EventPresenter: BasePresenter {
    private let msdservice: MSDServiceable
    
    init(msdservice: MSDServiceable) {
        self.msdservice = msdservice
    }
    
    func trackEvent(eventName: String, pageName: String, properties: [String:Any?]?) async {
        var finalProperties = [String:Any?]()
        if let fetchedProperties = properties {
            finalProperties = fetchedProperties
        }
        
        finalProperties.updateValue(eventName, forKey: "event_name")
        finalProperties.updateValue(pageName, forKey: "page_name")
        addDefaultProperties(properties: &finalProperties)
        finalProperties.updateValue(getCurrentTimestamp(), forKey:TIME_STAMP)
        
        await msdservice.track(body: finalProperties, success: { response in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_EVENT_TRACKING, String(describing: response))
        }, failure: { error in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_EVENT_TRACKING, String(describing: error))
        })
    }
}
