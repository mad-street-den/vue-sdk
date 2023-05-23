//
//  HTTPClient.swift
//  ios_sdk
//
//  Created by Julien on 22/05/23.
//


import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        guard Reachability.isConnectedToNetwork() else {
            return .failure(.noInternet)
        }
        
        let strURL = endpoint.scheme + endpoint.host + endpoint.path
        guard let url = URL(string: strURL) else { return .failure(.invalidURL) }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = endpoint.body {
            let jsondata = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsondata
        }
        
        
        do {
            var apiResponse: (data: Data, response: URLResponse)? = nil
            if #available(iOS 15.0, *) {
                apiResponse = try await URLSession.shared.data(for: request, delegate: nil)
            } else {
                apiResponse = try await URLSession.shared.data(for: request)
            }
            
            guard let response = apiResponse?.response as? HTTPURLResponse else { return .failure(.noResponse) }
            let result = handleNetworkResponse(response)
            
            switch result {
            case .success(_):
                guard let data = apiResponse?.data else { return .failure(.noData) }
                
                
                guard let decodedResponse = try? newJSONDecoder().decode(T.self, from: data) else { return .failure(.unableToDecode) }
                return .success(decodedResponse)
                
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Bool, RequestError> {
        switch response.statusCode {
        case 200...299: return .success(true)
        case 401...500: return .failure(.unauthorized)
        case 501...599: return .failure(.badRequest)
        case 600: return .failure(.outdated)
        default: return .failure(.unexpectedStatusCode)
        }
    }
}
