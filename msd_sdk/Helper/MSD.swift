import Foundation

public class MSD{
    let apiToken: String?
    let baseUrl:String?
    var userId: String?
    
    init(token: String?,baseUrl:String?) {
        self.apiToken = token
        self.baseUrl = baseUrl
        let _ = DataValidator.validateClientData(token, baseUrl: baseUrl)
    }
    
    public static func initialize(token:String,baseUrl:String?,isLoggingEnabled: Bool = true) -> MSD {
        SDKLogger.shared.isLoggingEnabled = isLoggingEnabled
        let _ =  DataValidator.validateClientData(token, baseUrl: baseUrl)
        return MSD(token: token, baseUrl: baseUrl)
    }
    
    public func setUser(userId: String?){
        if let validUserId = DataValidator.validateUserId(userId) {
            self.userId = validUserId
        }
    }
    
    public func track(eventName: String, properties: [String: Any?]) {
        guard let _ =  DataValidator.validateEventSanity(event: eventName,apiToken: self.apiToken,baseUrl: self.baseUrl,properties: properties)else{
            return
        }
        let eventPresenter = EventPresenter(msdservice: MSDService(apiClient: ApiClient()))
        Task{
            await eventPresenter.trackEvent(eventName: eventName, properties: properties)
        }
    }
    
    public func getRecommendationsByModule(moduleReference:String,  properties: RecommendationRequest, completionHandler: @escaping ([String:Any?]?, MSDError?) -> Void){
        DataValidator.validateRecommendationSanity(apiToken: apiToken, baseUrl: baseUrl, properties: properties,completionHandler: completionHandler)
        properties.setDynamicDataField(dynamicKey: RecommendationRequestType.module_name.rawValue, dynamicValue: moduleReference)
    }
    
    public func getRecommendationsByStrategy(strategyReference:String,properties:RecommendationRequest,completionHandler:  @escaping ([String:Any?]?, MSDError?) -> Void){
        DataValidator.validateRecommendationSanity(apiToken: apiToken, baseUrl: baseUrl, properties: properties,completionHandler: completionHandler)
    }
    
    public func getRecommendationsByPage(pageReference:String,properties: RecommendationRequest, completionHandler:  @escaping ([String:Any?]?, MSDError?) -> Void){
        DataValidator.validateRecommendationSanity(apiToken: apiToken, baseUrl: baseUrl, properties: properties,completionHandler: completionHandler)
    }
    
    public func getRecommendationsByText(textReference:String,properties:RecommendationRequest, completionHandler:  @escaping ([String:Any?]?, MSDError?) -> Void){
        DataValidator.validateRecommendationSanity(apiToken: apiToken, baseUrl: baseUrl, properties: properties,completionHandler: completionHandler)
    }
    
    public func reset(){
        self.userId = nil
    }
}

