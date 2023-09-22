import Foundation

class RecommendationPresenter: BasePresenter {
    private let sdkservice: VueSDKServiceable
    
    init(sdkservice: VueSDKServiceable) {
        self.sdkservice = sdkservice
    }
    
    func getRecommendations(searchType: [String: String], properties: RecommendationRequest, correlationId: String?, sdkConfig: VueSDKConfig?, success: @escaping([[String: Any?]]) -> Void, failure: @escaping([String: Any?]) -> Void) async {
        var param: [String : Any?] = properties.toDict()
        param.merge(searchType) { (_, new) in new }

         // Fetch the default properties for the Search API
        addSuperProperties(to: &param,sdkConfig: sdkConfig ?? VueSDKConfig())
        
        //to remove nil values if any
        let filteredProperties = param.compactMapValues { $0 }
        
        await sdkservice.getRecommendations(search: filteredProperties, correlationId: correlationId, success: { response in
            success(response)
        }, failure: { error in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_RECOMMENDATION, String(describing: error))
            failure(error)
        })
    }
}

