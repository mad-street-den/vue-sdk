//
//  DemoEndpoint.swift
//  ios_sdk
//
//  Created by Julien on 22/05/23.
//

enum DemoEndpoint {
  case send(events: [String])
}

extension DemoEndpoint: Endpoint {
  var path: String {
    switch self {
    case .send:
      return "path"
    }
  }
  
  var method: RequestMethod {
    switch self {
    case .send:
      return .post
    }
  }
  
  var header: [String: String]? {
    switch self {
    case .send:
      return ["Authorization": "token"]
    }
  }
  
  var body: [String: Any]? {
    switch self {
    case .send(let events):
      return ["values": events]
    }
  }
}
