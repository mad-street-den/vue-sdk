import Foundation

public class MSD{
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
    }
    
    public static func initialize(token: String, baseUrl: String) -> MSD {
        if(DataValidator.validateClientToken(token)) { AppManager.shared.apiToken = token }
        if(DataValidator.validateClientbaseUrl(baseUrl)) { AppManager.shared.msdBaseUrl = baseUrl }
        return MSD()
    }
    
    public func setUser(userId: String) {
        if let validUserId = DataValidator.validateUserId(userId) {
            BasePresenter().setUserId(userId: validUserId)
        }
    }
    
    public func track(eventName: String, pageName: String, properties: [String:Any?]?) {
        guard DataValidator.validateEventSanity(eventName: eventName,pageName:pageName) else { return }
        Task {
            await eventPresenter.trackEvent(eventName: eventName,pageName: pageName, properties: properties)
        }
    }
}

