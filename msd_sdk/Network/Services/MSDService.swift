import Foundation

protocol MSDServiceable {
    //TODO: ADD API CALLS HERE
}

class MSDService: MSDServiceable {
    let apiClient: HTTPClient
    
    init(apiClient: HTTPClient) {
        self.apiClient = apiClient
    }
    
}
