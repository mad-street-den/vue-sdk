import Foundation

public protocol RecommendationCallback {
    func onRecommendationsFetched()
    func onError()
}
