import Foundation

protocol MSDServiceable {
    func track(body: [String:Any?], success: @escaping([String:Any?]) -> Void, failure: @escaping([String:Any?]) -> Void) async
    func getRecommendations(search: [String:Any?], success: @escaping([[String:Any?]]) -> Void, failure: @escaping([String:Any?]) -> Void) async
    func discoverEvents(success: @escaping(DiscoverEventsResponse) -> Void, failure: @escaping([String:Any?]) -> Void) async
}

class MSDService: MSDServiceable {
    let apiClient: HTTPClient
    
    init(apiClient: HTTPClient) {
        self.apiClient = apiClient
    }
    
    func track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async {
        let apiEndpoint = MSDEndpoint.track(body: body)
        self.apiClient.sendRequest(endpoint: apiEndpoint, success: { response in
            success(response)
        }, failure: { error in
            failure(error)
        })
    }
    
    func getRecommendations(search: [String:Any?], success: @escaping([[String:Any?]]) -> Void, failure: @escaping([String:Any?]) -> Void) async {
        let apiEndpoint = MSDEndpoint.search(body: search)
        self.apiClient.sendRequest(endpoint: apiEndpoint, success: { response in
            success(response["data"] as? [[String:Any?]] ?? [[:]])},failure: { error in
                failure(error)
            })}
    
    func discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String : Any?]) -> Void) async {
        let apiEndpoint = MSDEndpoint.discover
        self.apiClient.sendRequest(endpoint: apiEndpoint, success: { response in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: response)
                let decoder = JSONDecoder()
                let discoverEventResponse = try decoder.decode(DiscoverEventsResponse.self, from: jsonData)
                success(discoverEventResponse)
            } catch let error{
                failure(MSDError.unableToDecode)
            }
        }, failure: { error in
            failure(error)
        })
    }
}
