//
//  HTTPClient.swift
//  ios_sdk
//
//  Created by Julien on 22/05/23.
//


import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, completion: @escaping (Result<T, RequestError>) -> Void)
}

class ApiClient: HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, completion: @escaping (Result<T, RequestError>) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            completion(.failure(.noInternet))
            return
        }
        
        let strURL = endpoint.scheme + endpoint.host + endpoint.path
        guard let url = URL(string: strURL) else {
            completion(.failure(.noInternet))
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = endpoint.body {
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsondata
            } catch {
                completion(.failure(.invalidURL))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(.unknown))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            let result = self.handleNetworkResponse(httpResponse)
            
            switch result {
            case .success(_):
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let decodedResponse = try? newJSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.unableToDecode))
                    return
                }
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
                completion(.success(decodedResponse))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }.resume()
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
