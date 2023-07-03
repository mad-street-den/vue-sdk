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
        
        guard let msdBaseUrl = AppManager.shared.msdBaseUrl, Utils.isValidUrl(msdBaseUrl) else {
            failure(MSDError.invalidURL)
            return
        }
        
        guard let url = URL(string: msdBaseUrl + endpoint.path) else {
            failure(MSDError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        request.setValue(AppManager.shared.apiToken ?? "", forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = endpoint.body {
            let jsondata = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsondata
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            SDKLogger.shared.isLoggingEnabled ? self.printAPIRequestResponse(urlRequest: request, responseData: data, response: response, error: error) : nil
            if let error = error {
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .timedOut:
                        failure(MSDError.requestTimeout)
                    case .unsupportedURL, .badURL:
                        failure(MSDError.invalidURL)
                    case .notConnectedToInternet, .networkConnectionLost:
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
                    try self.handleSuccessResponse(data: data, success: success, failure: failure)
                } else {
                    try self.handleFailureResponse(data: data, httpResponse: httpResponse, failure: failure)
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
    
    private func handleSuccessResponse(data: Data?, success: @escaping ([String: Any?]) -> Void, failure: @escaping ([String: Any?]) -> Void) throws {
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
    
    private func handleFailureResponse(data: Data?, httpResponse: HTTPURLResponse, failure: @escaping ([String: Any?]) -> Void) throws {
        guard let data = data else {
            failure(MSDError.noResponse)
            return
        }
        
        let statusCode = httpResponse.statusCode
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            failure(json)
        } else {
            switch statusCode {
            case 500...599:
                failure(MSDError.serverUnavailable)
            default:
                failure(MSDError.unknownError)
            }
        }
    }
    
    func printAPIRequestResponse(urlRequest: URLRequest, responseData: Data?, response: URLResponse?, error: Error?) {
        // Print API request details
        if let url = urlRequest.url {
            print("URL: \(url)")
        }
        
        if let method = urlRequest.httpMethod {
            print("HTTP Method: \(method)")
        }
        
        if let headers = urlRequest.allHTTPHeaderFields {
            print("Headers:")
            for (key, value) in headers {
                print("\(key): \(value)")
            }
        }
        
        if let bodyData = urlRequest.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            print("Body:")
            print(bodyString)
        }
        
        // Print API response details
        if let httpResponse = response as? HTTPURLResponse {
            print("Response Status Code: \(httpResponse.statusCode)")
            
            if let responseHeaders = httpResponse.allHeaderFields as? [String: Any] {
                print("Response Headers:")
                for (key, value) in responseHeaders {
                    print("\(key): \(value)")
                }
            }
        }
        
        if let responseData = responseData, let responseString = String(data: responseData, encoding: .utf8) {
            print("Response Body:")
            print(responseString)
        }
        
        if let error = error {
            print("Error: \(error)")
        }
    }
}
