import Foundation

protocol HTTPClient {
    func sendRequest(endpoint: APIRequestProtocol,success: @escaping([String:Any?]) -> Void, failure: @escaping([String:Any?]) -> Void)
}

class ApiClient: HTTPClient {
    func sendRequest(endpoint: APIRequestProtocol, success: @escaping([String:Any?]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            failure(MSDError.internetUnavailable)
            return
        }
        
        guard let msdBaseUrl = AppManager.shared.msdBaseUrl, !msdBaseUrl.isEmpty,
              let url = URL(string: msdBaseUrl + endpoint.path) else {
            failure(MSDError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = endpoint.method.rawValue
        request.setValue(AppManager.shared.apiToken ?? "", forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = endpoint.body {
            let jsondata = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsondata
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .timedOut:
                        failure(MSDError.requestTimeout)
                    case .unsupportedURL:
                        failure(MSDError.invalidURL)
                    case .notConnectedToInternet:
                        failure(MSDError.internetUnavailable)
                    default:
                        failure(MSDError(errors: ApiError(code:"\(urlError.code.rawValue)", message: error.localizedDescription)).toMap())
                    }
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure(MSDError.noResponse)
                return
            }
            
            do {
                if self.checkStatusCode(httpResponse) {
                    try self.handleResponse(data: data, success: success, failure: failure)
                } else {
                    try self.handleResponse(data: data, success: failure, failure: failure)
                }
            } catch {
                failure(MSDError.unableToDecode)
                return
            }
        }.resume()
    }
    
    private func checkStatusCode(_ response: HTTPURLResponse) -> Bool {
        return response.statusCode == 200
    }
    
    private func handleResponse(data: Data?, success: @escaping ([String: Any?]) -> Void, failure: @escaping ([String: Any?]) -> Void) throws {
        guard let data = data else {
            failure(MSDError.noResponse)
            return
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            success(json)
        } else {
            failure(MSDError.unableToDecode)
        }
    }
}
