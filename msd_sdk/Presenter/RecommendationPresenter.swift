import Foundation

class RecommendationPresenter: BasePresenter {
    private let msdservice: MSDServiceable
    
    init(msdservice: MSDServiceable) {
        self.msdservice = msdservice
    }
    
    func getRecommendations(searchType: [String: String], properties: RecommendationRequest, correlationId: String?, success: @escaping([[String: Any?]]) -> Void, failure: @escaping([String: Any?]) -> Void) async {
        var param: [String : Any?] = properties.toDict()
        param.merge(searchType) { (_, new) in new }

         // Fetch the default properties for the Search API
        addSuperProperties(to: &param)
        
        //to remove nil values if any
        let filteredProperties = param.compactMapValues { $0 }
        
        await msdservice.getRecommendations(search: filteredProperties, correlationId: correlationId, success: { response in
            success(response)
        }, failure: { error in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_RECOMMENDATION, String(describing: error))
            failure(error)
        })
    }
}

