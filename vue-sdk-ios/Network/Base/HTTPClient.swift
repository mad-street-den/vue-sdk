import Foundation

protocol HTTPClient {
    func sendRequest(endpoint: APIRequestProtocol,success: @escaping([String:Any?]) -> Void, failure: @escaping([String:Any?]) -> Void)
}

class ApiClient: HTTPClient {
    func sendRequest(endpoint: APIRequestProtocol, success: @escaping([String:Any?]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            failure(VueSDKError.internetUnavailable)
            return
        }
        
        guard let msdBaseUrl = AppManager.shared.msdBaseUrl, Utils.isValidUrl(msdBaseUrl) else {
            failure(VueSDKError.invalidURL)
            return
        }
        
        guard let url = URL(string: msdBaseUrl + endpoint.path) else {
            failure(VueSDKError.invalidURL)
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
                        failure(VueSDKError.requestTimeout)
                    case .unsupportedURL, .badURL:
                        failure(VueSDKError.invalidURL)
                    case .notConnectedToInternet, .networkConnectionLost:
                        failure(VueSDKError.internetUnavailable)
                    default:
                        failure(VueSDKError(errors: ApiError(code:"\(urlError.code.rawValue)", message: error.localizedDescription)).toMap())
                    }
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure(VueSDKError.noResponse)
                return
            }
            
            do {
                if self.checkStatusCode(httpResponse) {
                    try self.handleSuccessResponse(data: data, success: success, failure: failure)
                } else {
                    try self.handleFailureResponse(data: data, httpResponse: httpResponse, failure: failure)
                }
            } catch {
                failure(VueSDKError.unableToDecode)
                return
            }
        }.resume()
    }
    
    private func checkStatusCode(_ response: HTTPURLResponse) -> Bool {
        return response.statusCode == 200
    }
    
    private func handleSuccessResponse(data: Data?, success: @escaping ([String: Any?]) -> Void, failure: @escaping ([String: Any?]) -> Void) throws {
        guard let data = data else {
            failure(VueSDKError.noResponse)
            return
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            success(json)
        } else {
            failure(VueSDKError.unableToDecode)
        }
    }
    
    private func handleFailureResponse(data: Data?, httpResponse: HTTPURLResponse, failure: @escaping ([String: Any?]) -> Void) throws {
        guard let data = data else {
            failure(VueSDKError.noResponse)
            return
        }
        
        let statusCode = httpResponse.statusCode
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            failure(json)
        } else {
            switch statusCode {
            case 500...599:
                failure(VueSDKError.serverUnavailable)
            default:
                failure(VueSDKError.unknownError)
            }
        }
    }
    
    func printAPIRequestResponse(urlRequest: URLRequest, responseData: Data?, response: URLResponse?, error: Error?) {
        let logger = SDKLogger.shared
        // Print API request details
        logger.logSDKInfo(nil, "\n------Request------")
        if let url = urlRequest.url {
            logger.logSDKInfo(nil, "URL: \(url)")
        }
        
        if let method = urlRequest.httpMethod {
            logger.logSDKInfo(nil, "HTTP Method: \(method)")
        }
        
        if let headers = urlRequest.allHTTPHeaderFields {
            logger.logSDKInfo(nil, "Headers:")
            for (key, value) in headers {
                logger.logSDKInfo(nil, "\(key): \(value)")
            }
        }
        
        if let bodyData = urlRequest.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            logger.logSDKInfo(nil, "Body: \(bodyString)")
        }
        
        // Print API response details
        logger.logSDKInfo(nil, "\n------Response------")
        if let httpResponse = response as? HTTPURLResponse {
            logger.logSDKInfo(nil, "Response Status Code: \(httpResponse.statusCode)")
            
            if let responseHeaders = httpResponse.allHeaderFields as? [String: Any] {
                logger.logSDKInfo(nil, "Response Headers:")
                for (key, value) in responseHeaders {
                    logger.logSDKInfo(nil, "\(key): \(value)")
                }
            }
        }
        
        if let responseData = responseData, let responseString = String(data: responseData, encoding: .utf8) {
            logger.logSDKInfo(nil, "Response Body: \(responseString)\n")
        }
        
        if let error = error {
            logger.logSDKInfo(nil, "Error: \(error)\n")
        }
    }
}
