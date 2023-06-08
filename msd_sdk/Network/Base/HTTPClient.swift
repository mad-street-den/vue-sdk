import Foundation

protocol HTTPClient {
    func sendRequest(endpoint: APIRequestProtocol,success: @escaping([String:Any?]) -> Void, failure: @escaping([String:Any?]) -> Void)
}

class ApiClient: HTTPClient {
    func sendRequest(endpoint: APIRequestProtocol, success: @escaping([String:Any?]) -> Void, failure: @escaping([String:Any?]) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            //handle error
            return
        }
        
        guard let msdBaseUrl = AppManager.shared.msdBaseUrl, !msdBaseUrl.isEmpty else {
            //handle error
            return
        }
        
        let strURL = msdBaseUrl + endpoint.path
        guard let url = URL(string: strURL) else {
            //handle error
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
            if error != nil {
                //handle error
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                //handle error
                return
            }
            
            do {
                if self.checkStatusCode(httpResponse) {
                    try self.handleResponse(data: data, success: success, failure: failure)
                } else {
                    try self.handleResponse(data: data, success: failure, failure: failure)
                }
            } catch {
                //handle error
                return
            }
        }.resume()
    }
    
    private func checkStatusCode(_ response: HTTPURLResponse) -> Bool {
        return response.statusCode == 200
    }
    
    private func handleResponse(data: Data?, success: @escaping ([String: Any?]) -> Void, failure: @escaping ([String: Any?]) -> Void) throws {
        guard let data = data else {
            //handle error
            return
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] {
            success(json)
        } else {
            //handle error
        }
    }
}
