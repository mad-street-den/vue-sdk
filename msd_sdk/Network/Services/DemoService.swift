//
//  DemoService.swift
//  ios_sdk
//
//  Created by Julien on 22/05/23.
//

import Foundation

protocol DemoServiceable {
    func send(events: [String]) async -> Result<Response, RequestError>
}

struct DemoService: HTTPClient, DemoServiceable {
    func send(events: [String]) async -> Result<Response, RequestError> {
        let apiEndpoint = DemoEndpoint.send(events: events)
        return await sendRequest(endpoint: apiEndpoint, responseModel: Response.self)
    }
}
