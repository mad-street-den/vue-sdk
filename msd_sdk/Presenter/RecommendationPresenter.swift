import Foundation

class RecommendationPresenter: BasePresenter {
    private let msdservice: MSDServiceable
    
    init(msdservice: MSDServiceable) {
        self.msdservice = msdservice
    }
    
    func getRecommendations(searchType: [String: String],  properties: RecommendationRequest, success: @escaping([[String: Any?]]) -> Void, failure: @escaping([String: Any?]) -> Void) async {
        //Call recommendations API here
    }
}

