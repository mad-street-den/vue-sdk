import Foundation

class EventPresenter: BasePresenter {
    private let sdkservice: VueSDKServiceable
    private var discoverReponseList:DiscoverEventsResponse?
    
    init(sdkservice: VueSDKServiceable) {
        self.sdkservice = sdkservice
    }
    
    func discoverEvents(success: ((DiscoverEventsResponse) -> Void)? = nil, failure: (([String: Any?]) -> Void)? = nil) {
        if let responseList = discoverReponseList {
            success?(responseList)
            return
        }
        
        Task{
            await sdkservice.discoverEvents(success: { response in
                self.discoverReponseList = response
                success?(response)
            }, failure: { error in
                SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_DISCOVER_EVENTS, String(describing: error))
                failure?(error)
            })
        }
    }
    
    func trackEvent(eventName: String, properties: [String:Any?]?, correlationId: String?, sdkConfig: VueSDKConfig?) async {
        if discoverReponseList == nil {
            self.discoverEvents()
        }
        
        var finalProperties = properties ?? [:]
        finalProperties.updateValue(eventName, forKey: "event_name")
        
        // Fetch the default properties for the track API
        var defaultTrackEventProperties = [String:Any?]()
        addSuperProperties(to: &defaultTrackEventProperties, sdkConfig: sdkConfig ?? VueSDKConfig())
        
        // Update the keys of the properties map based on the current event name
        defaultTrackEventProperties = getPropertiesForEventName(eventName, defaultKeys: defaultTrackEventProperties)
        finalProperties.merge(defaultTrackEventProperties) { (_, new) in new }
        
        //to remove nil values if any
        let filteredProperties = finalProperties.compactMapValues { $0 }
        
        await sdkservice.track(body: filteredProperties, correlationId: correlationId, success: { response in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_EVENT_TRACKING, String(describing: response))
        }, failure: { error in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_EVENT_TRACKING, String(describing: error))
        })
    }
}

extension EventPresenter{
    func getPropertiesForEventName(_ eventName: String, defaultKeys: [String: Any?]) -> [String: Any] {
        var properties: [String: Any] = [:]
        
        for (defaultKey, value) in defaultKeys {
            let keyToUpdate = findSourceField(eventName: eventName, metaName: defaultKey) ?? defaultKey
            if let unwrappedValue = value {
                properties[keyToUpdate] = unwrappedValue
            }
        }
        return properties
    }
    
    func findSourceField(eventName: String, metaName: String) -> String? {
        guard let event = discoverReponseList?.data?.events?.first(where: { $0.eventName == eventName }),
              let schema = event.eventsSchema?.first(where: { $0.meta == metaName }) else {
            return nil
        }
        return schema.sourceField
    }
}
