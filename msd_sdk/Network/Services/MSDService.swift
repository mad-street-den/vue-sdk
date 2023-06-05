import Foundation

protocol MSDServiceable {
    func track(event: String, properties: [String: Any?], success: @escaping(Response?) -> Void, failure: @escaping(RequestError?) -> Void) async
    func getRecommendations(search: [String: Any?], success: @escaping(Response?) -> Void, failure: @escaping(RequestError?) -> Void) async
}

class MSDService: MSDServiceable {
    let apiClient: HTTPClient
    
    init(apiClient: HTTPClient) {
        self.apiClient = apiClient
    }
    
    func track(event: String,properties: [String: Any?],  success: @escaping(Response?) -> Void, failure: @escaping(RequestError?) -> Void) async {
        //consider event also
        let apiEndpoint = MSDEndpoint.track(body: properties)
        apiClient.sendRequest(endpoint: apiEndpoint, responseModel: Response.self){result in
            switch result {
            case .success(let response):
                print("Received response: \(response)")
                success(response)
            case .failure(let error):
                print("Request failed with error: \(error)")
                failure(error)
            }
        }
    }
    
    func getRecommendations(search: [String: Any?], success: @escaping(Response?) -> Void, failure: @escaping(RequestError?) -> Void) async {
        let apiEndpoint = MSDEndpoint.search(body: search)
        apiClient.sendRequest(endpoint: apiEndpoint, responseModel: Response.self){result in
            switch result {
            case .success(let response):
                print("Received response: \(response)")
                success(response)
            case .failure(let error):
                print("Request failed with error: \(error)")
                failure(error)
            }
        }
    }
}
