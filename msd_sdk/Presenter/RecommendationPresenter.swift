import Foundation

class RecommendationPresenter: BasePresenter {
    private let msdservice: MSDServiceable
    
    init(msdservice: MSDServiceable) {
        self.msdservice = msdservice
    }
    
    func getRecommendations(searchType: [String: String],  properties: RecommendationRequest, success: @escaping([[String: Any?]]) -> Void, failure: @escaping([String: Any?]) -> Void) async {
        var param: [String : Any?] = properties.toDict()
        param.merge(searchType) { (_, new) in new }
        addDefaultProperties(properties: &param)
        await msdservice.getRecommendations(search: param, success: { response in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_RECOMMENDATION, String(describing: response))
            success(response)
        }, failure: { error in
            SDKLogger.shared.logSDKInfo(LOG_INFO_TAG_RECOMMENDATION, String(describing: error))
            failure(error)
        })
    }
}

