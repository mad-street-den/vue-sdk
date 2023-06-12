import Foundation

class EventPresenter: BasePresenter {
    private let msdservice: MSDServiceable
    private var discoverReponseList:DiscoverEventsResponse?
    
    init(msdservice: MSDServiceable) {
        self.msdservice = msdservice
    }
    
    func discoverEvents(success: ((DiscoverEventsResponse) -> Void)? = nil, failure: (([String: Any?]) -> Void)? = nil) {
        if let responseList = discoverReponseList {
            success?(responseList)
            return
        }
        
        Task{
            await msdservice.discoverEvents(success: { response in
                self.discoverReponseList = response
                if success == nil {
                    // Log the response during initialization
                    SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_GENERIC, "discover success")
                }
                success?(response)
            }, failure: { error in
                if failure == nil {
                    // Log the error during initialization
                    SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_GENERIC, String(describing: error))
                }
                failure?(error)
            })
        }
    }
    
    func trackEvent(eventName: String, pageName: String, properties: [String:Any?]?) async {
        if discoverReponseList == nil {
            self.discoverEvents()
        }
        
        var finalProperties = [String:Any?]()
        if let fetchedProperties = properties {
            finalProperties = fetchedProperties
        }
        
        finalProperties.updateValue(eventName, forKey: "event_name")
        finalProperties.updateValue(pageName, forKey: "page_name")
        addDefaultProperties(properties: &finalProperties)
        addTrackDefaultProperties(properties: &finalProperties)
        
        await msdservice.track(body: finalProperties, success: { response in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_EVENT_TRACKING, String(describing: response))
        }, failure: { error in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_EVENT_TRACKING, String(describing: error))
        })
    }

    func addTrackDefaultProperties(properties: inout [String:Any?]){
        properties.updateValue(ios, forKey: PLATFORM)
        properties.updateValue(application, forKey: MEDIUM)
        properties.updateValue(getCurrentTimestamp(), forKey:TIME_STAMP)
        properties.updateValue(ios, forKey: REFERRER)
    }
}
