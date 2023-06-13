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
    
    func trackEvent(eventName: String, properties: [String:Any?]?) async {
        if discoverReponseList == nil {
            self.discoverEvents()
        }
        
        var finalProperties = properties ?? [:]
        finalProperties.updateValue(eventName, forKey: "event_name")
        
        // Fetch the default properties for the track API
        var defaultTrackEventProperties = [String:Any?]()
        addDefaultProperties(properties: &defaultTrackEventProperties)
        addTrackDefaultProperties(properties: &defaultTrackEventProperties)
        
        // Update the keys of the properties map based on the current event name
        defaultTrackEventProperties = getPropertiesForEventName(eventName, defaultKeys: defaultTrackEventProperties)
        finalProperties.merge(defaultTrackEventProperties) { (_, new) in new }
        
        await msdservice.track(body: finalProperties, success: { response in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_EVENT_TRACKING, String(describing: response))
        }, failure: { error in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_EVENT_TRACKING, String(describing: error))
        })
    }
}

extension EventPresenter{
    func addTrackDefaultProperties(properties: inout [String:Any?]){
        properties.updateValue(ios, forKey: PLATFORM)
        properties.updateValue(application, forKey: MEDIUM)
        properties.updateValue(getCurrentTimestamp(), forKey:TIME_STAMP)
        properties.updateValue(ios, forKey: REFERRER)
    }
    
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
