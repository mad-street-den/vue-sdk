import Foundation

public class VueSDK {
    private init(){}
    
    @discardableResult
    public static func initialize(token: String, baseUrl: String) -> VueSDKInstance {
        return VueSDKInstance.initialize(token: token, baseUrl: baseUrl)
    }
    
    public static func mainInstance() -> VueSDKInstance {
        return VueSDKInstance.mainInstance()
    }
}

public class VueSDKInstance{
    private static var shared: VueSDKInstance?
    var eventPresenter: EventPresenter!
    var recommendationPresenter: RecommendationPresenter!
    public var isLoggingEnabled: Bool{
        get {
            return SDKLogger.shared.isLoggingEnabled
        }
        set {
            SDKLogger.shared.isLoggingEnabled = newValue
        }
    }
    
    private init() {
        eventPresenter = EventPresenter(sdkservice: VueSDKService(apiClient: ApiClient()))
        recommendationPresenter = RecommendationPresenter(sdkservice: VueSDKService(apiClient: ApiClient()))
        eventPresenter.discoverEvents()
    }
    
    static func initialize(token: String, baseUrl: String) -> VueSDKInstance {
        let _ = DataValidator.validateClientToken(token)
        AppManager.shared.apiToken = token
        let _ = DataValidator.validateClientbaseUrl(baseUrl)
        AppManager.shared.msdBaseUrl = baseUrl
        self.shared = VueSDKInstance()
        return self.shared!
    }
    
    static func mainInstance() -> VueSDKInstance {
        guard let instance = shared else {
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_GENERIC, "ERROR: \(VueSDKError.initializeError)", isForceLog: true)
            return VueSDKInstance.initialize(token: "", baseUrl: "")
        }
        return instance
    }
    
    public func setUser(userId: String) {
        if let validUserId = DataValidator.validateUserId(userId) {
            BasePresenter().setUserId(userId: validUserId)
        }
    }
    
    public func discoverEvents(success: @escaping(DiscoverEventsResponse) -> Void, failure: @escaping([String:Any?]) -> Void){
        eventPresenter.discoverEvents(success: success,failure:failure)
    }
    
    public func track(eventName: String, properties: [String:Any?]?, correlationId: String? = nil, sdkConfig: VueSDKConfig? = nil) {
        guard DataValidator.validateEventSanity(eventName: eventName) else { return }
        Task {
            await eventPresenter.trackEvent(eventName: eventName, properties: properties, correlationId: correlationId, sdkConfig: sdkConfig)
        }
    }
    
    public func getRecommendationsByModule(moduleReference: String, properties: RecommendationRequest, correlationId: String? = nil, sdkConfig: VueSDKConfig? = nil, success: @escaping([[String:Any?]]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        Task {
            await recommendationPresenter.getRecommendations(searchType: [RecommendationRequestType.module_name.rawValue : moduleReference], properties: properties, correlationId:correlationId, sdkConfig: sdkConfig, success: { response in
                success(response)
            }, failure: { error in
                failure(error)
            })
        }
    }
    
    public func getRecommendationsByStrategy(strategyReference: String, properties: RecommendationRequest, correlationId: String? = nil, sdkConfig: VueSDKConfig? = nil, success: @escaping([[String:Any?]]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        Task{
            await recommendationPresenter.getRecommendations(searchType: [RecommendationRequestType.strategy_name.rawValue : strategyReference], properties: properties, correlationId: correlationId, sdkConfig: sdkConfig, success: { response in
                success(response)
            }, failure: { error in
                failure(error)
            })
        }
    }
    
    public func getRecommendationsByPage(pageReference: String, properties: RecommendationRequest, correlationId: String? = nil, sdkConfig: VueSDKConfig? = nil, success: @escaping([[String:Any?]]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        Task{
            await recommendationPresenter.getRecommendations(searchType: [RecommendationRequestType.page_name.rawValue : pageReference], properties: properties, correlationId: correlationId, sdkConfig: sdkConfig, success: { response in
                success(response)
            }, failure: { error in
                failure(error)
            })
        }
    }
    
    public func resetUser() {
        BasePresenter().removeUserId()
    }
    
    public func setBloxUUID(bloxUUID: String) {
        if let validBloxUUID = DataValidator.validateBloxUUID(bloxUUID) {
            BasePresenter().setMadUUID(madUUID: validBloxUUID)
        }
    }
    
    public func getBloxUUID() -> String? {
        return userDefaults.getUserDefaultString(key: UserDefaultsKeys.MAD_UUID.rawValue)
    }
    
}

