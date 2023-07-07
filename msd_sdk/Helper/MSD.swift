import Foundation

public class MSD {
    private init(){}
    
    @discardableResult
    public static func initialize(token: String, baseUrl: String) -> MSDInstance {
        return MSDInstance.initialize(token: token, baseUrl: baseUrl)
    }
    
    public static func mainInstance() -> MSDInstance {
        return MSDInstance.mainInstance()
    }
}

public class MSDInstance{
    private static var shared: MSDInstance?
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
        eventPresenter = EventPresenter(msdservice: MSDService(apiClient: ApiClient()))
        recommendationPresenter = RecommendationPresenter(msdservice: MSDService(apiClient: ApiClient()))
        eventPresenter.discoverEvents()
    }
    
    static func initialize(token: String, baseUrl: String) -> MSDInstance {
        let _ = DataValidator.validateClientToken(token)
        AppManager.shared.apiToken = token
        let _ = DataValidator.validateClientbaseUrl(baseUrl)
        AppManager.shared.msdBaseUrl = baseUrl
        self.shared = MSDInstance()
        return self.shared!
    }
    
    static func mainInstance() -> MSDInstance {
        guard let instance = shared else {
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_GENERIC, INITIALIZE_ERROR,isForceLog: true)
            return MSDInstance.initialize(token: "", baseUrl: "")
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
    
    public func track(eventName: String, properties: [String:Any?]?, correlationId: String? = nil) {
        guard DataValidator.validateEventSanity(eventName: eventName) else { return }
        Task {
            await eventPresenter.trackEvent(eventName: eventName, properties: properties, correlationId: correlationId)
        }
    }
    
    public func getRecommendationsByModule(moduleReference: String, properties: RecommendationRequest, correlationId: String? = nil, success: @escaping([[String:Any?]]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        Task {
            await recommendationPresenter.getRecommendations(searchType: [RecommendationRequestType.module_name.rawValue : moduleReference], properties: properties, correlationId:correlationId,  success: { response in
                success(response)
            }, failure: { error in
                failure(error)
            })
        }
    }
    
    public func getRecommendationsByStrategy(strategyReference: String, properties: RecommendationRequest, correlationId: String? = nil, success: @escaping([[String:Any?]]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        Task{
            await recommendationPresenter.getRecommendations(searchType: [RecommendationRequestType.strategy_name.rawValue : strategyReference], properties: properties, correlationId: correlationId, success: { response in
                success(response)
            }, failure: { error in
                failure(error)
            })
        }
    }
    
    public func getRecommendationsByPage(pageReference: String, properties: RecommendationRequest, correlationId: String? = nil, success: @escaping([[String:Any?]]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        Task{
            await recommendationPresenter.getRecommendations(searchType: [RecommendationRequestType.page_name.rawValue : pageReference], properties: properties, correlationId: correlationId, success: { response in
                success(response)
            }, failure: { error in
                failure(error)
            })
        }
    }
    
    public func resetUserProfile() {
        BasePresenter().removeUserId()
    }
}

