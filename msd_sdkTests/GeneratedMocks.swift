// MARK: - Mocks generated from file: msd_sdk/Network/Base/HTTPClient.swift at 2023-06-19 03:43:42 +0000


import Cuckoo
@testable import msd_sdk

import Foundation






 class MockHTTPClient: HTTPClient, Cuckoo.ProtocolMock {
    
     typealias MocksType = HTTPClient
    
     typealias Stubbing = __StubbingProxy_HTTPClient
     typealias Verification = __VerificationProxy_HTTPClient

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HTTPClient?

     func enableDefaultImplementation(_ stub: HTTPClient) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)  {
        
    return cuckoo_manager.call(
    """
    sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)
    """,
            parameters: (endpoint, success, failure),
            escapingParameters: (endpoint, success, failure),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.sendRequest(endpoint: endpoint, success: success, failure: failure))
        
    }
    
    

     struct __StubbingProxy_HTTPClient: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func sendRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(endpoint: M1, success: M2, failure: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(APIRequestProtocol, ([String:Any?]) -> Void, ([String:Any?]) -> Void)> where M1.MatchedType == APIRequestProtocol, M2.MatchedType == ([String:Any?]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(APIRequestProtocol, ([String:Any?]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: endpoint) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockHTTPClient.self, method:
    """
    sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_HTTPClient: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func sendRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(endpoint: M1, success: M2, failure: M3) -> Cuckoo.__DoNotUse<(APIRequestProtocol, ([String:Any?]) -> Void, ([String:Any?]) -> Void), Void> where M1.MatchedType == APIRequestProtocol, M2.MatchedType == ([String:Any?]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(APIRequestProtocol, ([String:Any?]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: endpoint) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return cuckoo_manager.verify(
    """
    sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class HTTPClientStub: HTTPClient {
    

    

    
    
    
    
     func sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}










 class MockApiClient: ApiClient, Cuckoo.ClassMock {
    
     typealias MocksType = ApiClient
    
     typealias Stubbing = __StubbingProxy_ApiClient
     typealias Verification = __VerificationProxy_ApiClient

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ApiClient?

     func enableDefaultImplementation(_ stub: ApiClient) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)  {
        
    return cuckoo_manager.call(
    """
    sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)
    """,
            parameters: (endpoint, success, failure),
            escapingParameters: (endpoint, success, failure),
            superclassCall:
                
                super.sendRequest(endpoint: endpoint, success: success, failure: failure)
                ,
            defaultCall: __defaultImplStub!.sendRequest(endpoint: endpoint, success: success, failure: failure))
        
    }
    
    

     struct __StubbingProxy_ApiClient: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func sendRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(endpoint: M1, success: M2, failure: M3) -> Cuckoo.ClassStubNoReturnFunction<(APIRequestProtocol, ([String:Any?]) -> Void, ([String:Any?]) -> Void)> where M1.MatchedType == APIRequestProtocol, M2.MatchedType == ([String:Any?]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(APIRequestProtocol, ([String:Any?]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: endpoint) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockApiClient.self, method:
    """
    sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_ApiClient: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func sendRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(endpoint: M1, success: M2, failure: M3) -> Cuckoo.__DoNotUse<(APIRequestProtocol, ([String:Any?]) -> Void, ([String:Any?]) -> Void), Void> where M1.MatchedType == APIRequestProtocol, M2.MatchedType == ([String:Any?]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(APIRequestProtocol, ([String:Any?]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: endpoint) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return cuckoo_manager.verify(
    """
    sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class ApiClientStub: ApiClient {
    

    

    
    
    
    
     override func sendRequest(endpoint: APIRequestProtocol, success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: msd_sdk/Network/Services/MSDService.swift at 2023-06-19 03:43:42 +0000


import Cuckoo
@testable import msd_sdk

import Foundation






 class MockMSDServiceable: MSDServiceable, Cuckoo.ProtocolMock {
    
     typealias MocksType = MSDServiceable
    
     typealias Stubbing = __StubbingProxy_MSDServiceable
     typealias Verification = __VerificationProxy_MSDServiceable

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MSDServiceable?

     func enableDefaultImplementation(_ stub: MSDServiceable) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async {
        
    return await cuckoo_manager.call(
    """
    track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """,
            parameters: (body, success, failure),
            escapingParameters: (body, success, failure),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.track(body: body, success: success, failure: failure))
        
    }
    
    
    
    
    
     func getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async {
        
    return await cuckoo_manager.call(
    """
    getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """,
            parameters: (search, success, failure),
            escapingParameters: (search, success, failure),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.getRecommendations(search: search, success: success, failure: failure))
        
    }
    
    
    
    
    
     func discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String:Any?]) -> Void) async {
        
    return await cuckoo_manager.call(
    """
    discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """,
            parameters: (success, failure),
            escapingParameters: (success, failure),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.discoverEvents(success: success, failure: failure))
        
    }
    
    

     struct __StubbingProxy_MSDServiceable: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func track<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(body: M1, success: M2, failure: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([String:Any?], ([String:Any?]) -> Void, ([String:Any?]) -> Void)> where M1.MatchedType == [String:Any?], M2.MatchedType == ([String:Any?]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<([String:Any?], ([String:Any?]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: body) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMSDServiceable.self, method:
    """
    track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getRecommendations<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(search: M1, success: M2, failure: M3) -> Cuckoo.ProtocolStubNoReturnFunction<([String:Any?], ([[String:Any?]]) -> Void, ([String:Any?]) -> Void)> where M1.MatchedType == [String:Any?], M2.MatchedType == ([[String:Any?]]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<([String:Any?], ([[String:Any?]]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: search) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMSDServiceable.self, method:
    """
    getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func discoverEvents<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(success: M1, failure: M2) -> Cuckoo.ProtocolStubNoReturnFunction<((DiscoverEventsResponse) -> Void, ([String:Any?]) -> Void)> where M1.MatchedType == (DiscoverEventsResponse) -> Void, M2.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<((DiscoverEventsResponse) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: success) { $0.0 }, wrap(matchable: failure) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMSDServiceable.self, method:
    """
    discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_MSDServiceable: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func track<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(body: M1, success: M2, failure: M3) -> Cuckoo.__DoNotUse<([String:Any?], ([String:Any?]) -> Void, ([String:Any?]) -> Void), Void> where M1.MatchedType == [String:Any?], M2.MatchedType == ([String:Any?]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<([String:Any?], ([String:Any?]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: body) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return cuckoo_manager.verify(
    """
    track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getRecommendations<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(search: M1, success: M2, failure: M3) -> Cuckoo.__DoNotUse<([String:Any?], ([[String:Any?]]) -> Void, ([String:Any?]) -> Void), Void> where M1.MatchedType == [String:Any?], M2.MatchedType == ([[String:Any?]]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<([String:Any?], ([[String:Any?]]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: search) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return cuckoo_manager.verify(
    """
    getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func discoverEvents<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(success: M1, failure: M2) -> Cuckoo.__DoNotUse<((DiscoverEventsResponse) -> Void, ([String:Any?]) -> Void), Void> where M1.MatchedType == (DiscoverEventsResponse) -> Void, M2.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<((DiscoverEventsResponse) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: success) { $0.0 }, wrap(matchable: failure) { $0.1 }]
            return cuckoo_manager.verify(
    """
    discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class MSDServiceableStub: MSDServiceable {
    

    

    
    
    
    
     func track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String:Any?]) -> Void) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}










 class MockMSDService: MSDService, Cuckoo.ClassMock {
    
     typealias MocksType = MSDService
    
     typealias Stubbing = __StubbingProxy_MSDService
     typealias Verification = __VerificationProxy_MSDService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: MSDService?

     func enableDefaultImplementation(_ stub: MSDService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async {
        
    return await cuckoo_manager.call(
    """
    track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """,
            parameters: (body, success, failure),
            escapingParameters: (body, success, failure),
            superclassCall:
                
                await super.track(body: body, success: success, failure: failure)
                ,
            defaultCall: await __defaultImplStub!.track(body: body, success: success, failure: failure))
        
    }
    
    
    
    
    
     override func getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async {
        
    return await cuckoo_manager.call(
    """
    getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """,
            parameters: (search, success, failure),
            escapingParameters: (search, success, failure),
            superclassCall:
                
                await super.getRecommendations(search: search, success: success, failure: failure)
                ,
            defaultCall: await __defaultImplStub!.getRecommendations(search: search, success: success, failure: failure))
        
    }
    
    
    
    
    
     override func discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String : Any?]) -> Void) async {
        
    return await cuckoo_manager.call(
    """
    discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String : Any?]) -> Void) async
    """,
            parameters: (success, failure),
            escapingParameters: (success, failure),
            superclassCall:
                
                await super.discoverEvents(success: success, failure: failure)
                ,
            defaultCall: await __defaultImplStub!.discoverEvents(success: success, failure: failure))
        
    }
    
    

     struct __StubbingProxy_MSDService: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func track<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(body: M1, success: M2, failure: M3) -> Cuckoo.ClassStubNoReturnFunction<([String:Any?], ([String:Any?]) -> Void, ([String:Any?]) -> Void)> where M1.MatchedType == [String:Any?], M2.MatchedType == ([String:Any?]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<([String:Any?], ([String:Any?]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: body) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMSDService.self, method:
    """
    track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func getRecommendations<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(search: M1, success: M2, failure: M3) -> Cuckoo.ClassStubNoReturnFunction<([String:Any?], ([[String:Any?]]) -> Void, ([String:Any?]) -> Void)> where M1.MatchedType == [String:Any?], M2.MatchedType == ([[String:Any?]]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<([String:Any?], ([[String:Any?]]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: search) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMSDService.self, method:
    """
    getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func discoverEvents<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(success: M1, failure: M2) -> Cuckoo.ClassStubNoReturnFunction<((DiscoverEventsResponse) -> Void, ([String : Any?]) -> Void)> where M1.MatchedType == (DiscoverEventsResponse) -> Void, M2.MatchedType == ([String : Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<((DiscoverEventsResponse) -> Void, ([String : Any?]) -> Void)>] = [wrap(matchable: success) { $0.0 }, wrap(matchable: failure) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockMSDService.self, method:
    """
    discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String : Any?]) -> Void) async
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_MSDService: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func track<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(body: M1, success: M2, failure: M3) -> Cuckoo.__DoNotUse<([String:Any?], ([String:Any?]) -> Void, ([String:Any?]) -> Void), Void> where M1.MatchedType == [String:Any?], M2.MatchedType == ([String:Any?]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<([String:Any?], ([String:Any?]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: body) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return cuckoo_manager.verify(
    """
    track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func getRecommendations<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(search: M1, success: M2, failure: M3) -> Cuckoo.__DoNotUse<([String:Any?], ([[String:Any?]]) -> Void, ([String:Any?]) -> Void), Void> where M1.MatchedType == [String:Any?], M2.MatchedType == ([[String:Any?]]) -> Void, M3.MatchedType == ([String:Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<([String:Any?], ([[String:Any?]]) -> Void, ([String:Any?]) -> Void)>] = [wrap(matchable: search) { $0.0 }, wrap(matchable: success) { $0.1 }, wrap(matchable: failure) { $0.2 }]
            return cuckoo_manager.verify(
    """
    getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func discoverEvents<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(success: M1, failure: M2) -> Cuckoo.__DoNotUse<((DiscoverEventsResponse) -> Void, ([String : Any?]) -> Void), Void> where M1.MatchedType == (DiscoverEventsResponse) -> Void, M2.MatchedType == ([String : Any?]) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<((DiscoverEventsResponse) -> Void, ([String : Any?]) -> Void)>] = [wrap(matchable: success) { $0.0 }, wrap(matchable: failure) { $0.1 }]
            return cuckoo_manager.verify(
    """
    discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String : Any?]) -> Void) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class MSDServiceStub: MSDService {
    

    

    
    
    
    
     override func track(body: [String:Any?], success: @escaping ([String:Any?]) -> Void, failure: @escaping ([String:Any?]) -> Void) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func getRecommendations(search: [String:Any?], success: @escaping ([[String:Any?]]) -> Void, failure: @escaping ([String:Any?]) -> Void) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     override func discoverEvents(success: @escaping (DiscoverEventsResponse) -> Void, failure: @escaping ([String : Any?]) -> Void) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}




