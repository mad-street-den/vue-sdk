import XCTest
import Cuckoo
@testable import msd_sdk

final class eventTrackTests: XCTestCase {
    var mockHTTPClient: MockHTTPClient!
    var eventPresenter: EventPresenter!
    
    override func setUpWithError() throws {
        mockHTTPClient = MockHTTPClient()
        eventPresenter = EventPresenter(msdservice: MSDService(apiClient: mockHTTPClient))
    }
    
    override func tearDownWithError() throws {
        mockHTTPClient = nil
        eventPresenter = nil
    }
    
    func testDiscoverSuccess() async {
        let mockResponse: [String: Any] = ["data": [
            "account-metadata": [
                "blox_api_url": "example_url",
                "language": "en",
                "currency": "USD",
                "currency_code": "USD",
                "pdp_target_same": true,
                "id": "example_id",
                "clientId": "example_client_id",
                "created_ts": "2022-01-01",
                "updated_ts": "2022-01-02"
            ],
            "events": [
                [
                    "event_name": "event1",
                    "event_meta": "meta1",
                    "events_schema": [
                        [
                            "source_field": "field1",
                            "data_type": "type1",
                            "mandatory": true,
                            "catalog_id": "catalog1",
                            "catalog_key": "key1",
                            "meta": "meta1",
                            "explode_field": false
                        ]
                    ],
                    "action": "action1"
                ]
            ]
        ]]
        stub(mockHTTPClient) { mock in
            when(mock.sendRequest(endpoint: any(), success: any(), failure: any())).then { _, success, failure in
                success(mockResponse)
            }
        }
        eventPresenter.discoverEvents(success: { response in
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: mockResponse, options: [])
                let decoder = JSONDecoder()
                let mockResponseModel = try decoder.decode(DiscoverEventsResponse.self, from: jsonData)
                XCTAssertEqual(response, mockResponseModel)
            }catch{
                XCTFail("Failed to get recommendations by strategy")
            }
        }, failure: { error in
            XCTFail("Failed to get recommendations by strategy")
        })
    }
    
    func testDiscoverFail() async {
        let mockError: [String: Any] = ["error":"error-message"]
        stub(mockHTTPClient) { mock in
            when(mock.sendRequest(endpoint: any(), success: any(), failure: any())).then { _, success, failure in
                failure(mockError)
            }
        }
        eventPresenter.discoverEvents(success: { response in
            XCTFail("Failed to get recommendations by strategy")
        }, failure: { error in
            XCTAssertEqual(mockError as? [String:String], error as? [String: String])
        })
    }
}

final class searchRecommendationTests: XCTestCase{
    var recommendationPresenter: RecommendationPresenter!
    var mockService: MockMSDServiceable!
    
    override func setUpWithError() throws {
        mockService = MockMSDServiceable()
        recommendationPresenter = RecommendationPresenter(msdservice: mockService)
    }
    
    override func tearDownWithError() throws {
        mockService = nil
        recommendationPresenter = nil
    }
    
    func testRecommendationSuccess() async{
        let mockResponse: [[String:Any?]] = [["title":"Shirt","imageUrl":"exampleImageUrl"]]
        stub(mockService) { mock in
            when(mock.getRecommendations(search: any(),correlationId: any(), success: any(), failure: any())).then({ body,id,succeess,failure in
                succeess(mockResponse)
            })
        }
        await recommendationPresenter?.getRecommendations(searchType: [:], properties: RecommendationRequest(catalogs: [:]), correlationId: "", success: { res in
            let resDict = res
            XCTAssertEqual(resDict.count, mockResponse.count)
            for (index, dict) in resDict.enumerated() {
                XCTAssertEqual(dict.keys, mockResponse[index].keys)
                for (key, value) in dict {
                    XCTAssertEqual(value as? NSObject, mockResponse[index][key] as? NSObject)
                }
            }
        }, failure: { err in
            XCTFail("Failed to test get Recommendation")
        })
    }
    
    func testRecommendationFailure() async{
        let mockError: [String:Any?] = ["requestId":"1234","error":["errorCode":400, "measage": "Client Side Error"]]
        stub(mockService) { mock in
            when(mock.getRecommendations(search: any(),correlationId: anyString(), success: any(), failure: any())).then { body,id,succeess,failure in
                failure(mockError)
            }
        }
        await recommendationPresenter?.getRecommendations(searchType: [:], properties: RecommendationRequest(catalogs: [:]), correlationId: "", success: { res in
            XCTFail("Failed to test RecommendationFailure")
        }, failure: { err in
            for (key, value) in err {
                XCTAssertEqual(value as? String, mockError[key] as? String)
            }
        })
    }
}

class DataValidatorTests: XCTestCase {
    func testValidClientToken() {
        let token = "valid_token"
        let isValidToken = DataValidator.validateClientToken(token)
        XCTAssertTrue(isValidToken, "Client token validation failed")
    }
    
    func testEmptyClientToken() {
        let token = ""
        let isValidToken = DataValidator.validateClientToken(token)
        XCTAssertFalse(isValidToken, "Empty client token validation failed")
    }
    
    func testValidClientBaseUrl() {
        let baseUrl = "https://example.com"
        let isValidBaseUrl = DataValidator.validateClientbaseUrl(baseUrl)
        XCTAssertTrue(isValidBaseUrl, "Client base URL validation failed")
    }
    
    func testEmptyClientBaseUrl() {
        let baseUrl = ""
        let isValidBaseUrl = DataValidator.validateClientbaseUrl(baseUrl)
        XCTAssertFalse(isValidBaseUrl, "Empty client base URL validation failed")
    }
    
    func testValidUserId() {
        let userId = "user123"
        let validatedUserId = DataValidator.validateUserId(userId)
        XCTAssertEqual(validatedUserId, userId, "User ID validation failed")
    }
    
    func testEmptyUserId() {
        let userId = ""
        let validatedUserId = DataValidator.validateUserId(userId)
        XCTAssertNil(validatedUserId, "Empty user ID validation failed")
    }
    
    func testValidEventName() {
        let eventName = "click_event"
        let isValidEventName = DataValidator.validateEventSanity(eventName: eventName)
        XCTAssertTrue(isValidEventName, "Event name validation failed")
    }
    
    func testEmptyEventName() {
        let eventName = ""
        let isValidEventName = DataValidator.validateEventSanity(eventName: eventName)
        XCTAssertFalse(isValidEventName, "Empty event name validation failed")
    }
}

class UtilsTests: XCTestCase {
    func testCheckNullOrEmptyString() {
        XCTAssertTrue(Utils.checkNullOrEmptyString(nil))
        XCTAssertTrue(Utils.checkNullOrEmptyString(""))
        XCTAssertFalse(Utils.checkNullOrEmptyString("Hello"))
    }
    
    func testCheckEmptyString() {
        XCTAssertTrue(Utils.checkEmptyString(""))
        XCTAssertFalse(Utils.checkEmptyString("Hello"))
    }
    
    func testIsValidUrl() {
        XCTAssertTrue(Utils.isValidUrl("http://www.example.com"))
        XCTAssertTrue(Utils.isValidUrl("https://www.example.com"))
        XCTAssertFalse(Utils.isValidUrl(" https://www.example.com"))
        XCTAssertFalse(Utils.isValidUrl(" http://www.example.com"))
        XCTAssertFalse(Utils.isValidUrl("www.example.com"))
        XCTAssertFalse(Utils.isValidUrl("example.com"))
        XCTAssertFalse(Utils.isValidUrl("ftp://www.example.com"))
        XCTAssertFalse(Utils.isValidUrl("://www.example.com"))
        XCTAssertFalse(Utils.isValidUrl(""))
    }
}

class RecommendationRequestTests: XCTestCase {
    func testToDict() {
        // Create a sample catalogs dictionary
        let catalogs: [String: Any?] = [
            "catalog1": "value1",
            "catalog2": "value2"
        ]
        
        // Create an instance of RecommendationRequest
        let request = RecommendationRequest(
            catalogs: catalogs,
            max_content: 10,
            min_content: 5,
            page_num: 1,
            skip_cache: false,
            explain: true,
            config: [["key1": "value1"], ["key2": "value2"]],
            min_bundles: 2,
            max_bundles: 5,
            unbundle: true
        )
        
        // Call the toDict() method
        let dictionary = request.toDict()
        
        // Verify the dictionary contains the expected key-value pairs
        XCTAssertEqual(dictionary["max_content"] as? Int, 10)
        XCTAssertEqual(dictionary["min_content"] as? Int, 5)
        XCTAssertEqual(dictionary["page_num"] as? Int, 1)
        XCTAssertEqual(dictionary["skip_cache"] as? Bool, false)
        XCTAssertEqual(dictionary["explain"] as? Bool, true)
        XCTAssertEqual(dictionary["min_bundles"] as? Int, 2)
        XCTAssertEqual(dictionary["max_bundles"] as? Int, 5)
        XCTAssertEqual(dictionary["unbundle"] as? Bool, true)
        
        // Verify catalogs dictionary
        if let catalogsDict = dictionary["catalogs"] as? [String: Any?] {
            XCTAssertEqual(catalogsDict["catalog1"] as? String, "value1")
            XCTAssertEqual(catalogsDict["catalog2"] as? String, "value2")
        } else {
            XCTFail("Catalogs dictionary is missing or has an unexpected type.")
        }
        
        // Verify config array
        if let configArray = dictionary["config"] as? [[String: Any?]] {
            XCTAssertEqual(configArray.count, 2)
            XCTAssertEqual(configArray[0]["key1"] as? String, "value1")
            XCTAssertEqual(configArray[1]["key2"] as? String, "value2")
        } else {
            XCTFail("Config array is missing or has an unexpected type.")
        }
    }
}

class DiscoverEventsResponseTests: XCTestCase {
    func testDiscoverEventsResponseEquality() {
        // Create sample data for the test
        let accountMetadata1 = AccountMetadata(
            bloxApiUrl: "https://api.example.com",
            language: "en",
            currency: "USD",
            currencyCode: "USD",
            pdpTargetSame: true,
            id: "123",
            clientId: "456",
            createdTs: "2021-01-01",
            updatedTs: "2021-01-02"
        )
        
        let accountMetadata2 = AccountMetadata(
            bloxApiUrl: "https://api.example.com",
            language: "en",
            currency: "USD",
            currencyCode: "USD",
            pdpTargetSame: true,
            id: "123",
            clientId: "456",
            createdTs: "2021-01-01",
            updatedTs: "2021-01-02"
        )
        
        let eventSchema1 = EventSchema(
            sourceField: "source",
            dataType: "string",
            mandatory: true,
            catalogID: "789",
            catalogKey: "key",
            meta: "meta",
            explodeField: false
        )
        
        let eventSchema2 = EventSchema(
            sourceField: "source",
            dataType: "string",
            mandatory: true,
            catalogID: "789",
            catalogKey: "key",
            meta: "meta",
            explodeField: false
        )
        
        let eventData1 = EventData(
            eventName: "event",
            eventMeta: "meta",
            eventsSchema: [eventSchema1],
            action: "action"
        )
        
        let eventData2 = EventData(
            eventName: "event",
            eventMeta: "meta",
            eventsSchema: [eventSchema2],
            action: "action"
        )
        
        let dataContainer1 = EventDataContainer(
            accountMetadata: accountMetadata1,
            events: [eventData1]
        )
        
        let dataContainer2 = EventDataContainer(
            accountMetadata: accountMetadata2,
            events: [eventData2]
        )
        
        let response1 = DiscoverEventsResponse(data: dataContainer1)
        let response2 = DiscoverEventsResponse(data: dataContainer2)
        
        // Assert that the instances are equal
        XCTAssertEqual(response1, response2)
    }
    
    func testDiscoverEventsResponseEncodingDecoding() {
        // Create sample data for the test
        let accountMetadata = AccountMetadata(
            bloxApiUrl: "https://api.example.com",
            language: "en",
            currency: "USD",
            currencyCode: "USD",
            pdpTargetSame: true,
            id: "123",
            clientId: "456",
            createdTs: "2021-01-01",
            updatedTs: "2021-01-02"
        )
        
        let eventSchema = EventSchema(
            sourceField: "source",
            dataType: "string",
            mandatory: true,
            catalogID: "789",
            catalogKey: "key",
            meta: "meta",
            explodeField: false
        )
        
        let eventData = EventData(
            eventName: "event",
            eventMeta: "meta",
            eventsSchema: [eventSchema],
            action: "action"
        )
        
        let dataContainer = EventDataContainer(
            accountMetadata: accountMetadata,
            events: [eventData]
        )
        
        let response = DiscoverEventsResponse(data: dataContainer)
        
        // Encode the response to JSON data
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(response) else {
            XCTFail("Failed to encode DiscoverEventsResponse to JSON")
            return
        }
        
        // Decode the JSON data back to DiscoverEventsResponse
        let decoder = JSONDecoder()
        guard let decodedResponse = try? decoder.decode(DiscoverEventsResponse.self, from: jsonData) else {
            XCTFail("Failed to decode JSON to DiscoverEventsResponse")
            return
        }
        
        // Assert that the original response and the decoded response are equal
        XCTAssertEqual(response, decodedResponse)
    }
}

class MSDEndpointTests: XCTestCase {
    func testDiscoverEndpoint() {
        let endpoint = MSDEndpoint.discover
        
        XCTAssertEqual(endpoint.path, DISCOVER_EVENTS_ENDPOINT)
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertNil(endpoint.header)
        XCTAssertNil(endpoint.body)
    }
    
    func testTrackEndpoint() {
        let body: [String: Any?] = [
            "key1": "value1",
            "key2": 123
        ]
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer TOKEN"
        ]

        let endpoint = MSDEndpoint.track(body: body, headers: headers)

        XCTAssertEqual(endpoint.path, TRACK_ENDPOINT)
        XCTAssertEqual(endpoint.method, .post)
        XCTAssertEqual(endpoint.header, headers)

        if let endpointBody = endpoint.body,
           let endpointData = try? JSONSerialization.data(withJSONObject: endpointBody),
           let bodyData = try? JSONSerialization.data(withJSONObject: body) {

            let endpointJSON = String(data: endpointData, encoding: .utf8)
            let bodyJSON = String(data: bodyData, encoding: .utf8)

            XCTAssertEqual(endpointJSON, bodyJSON)
        } else {
            XCTFail("Failed to convert endpoint.body to [String: Any?]")
        }
    }
    
    func testSearchEndpoint() {
        let body: [String: Any?] = [
            "query": "example",
            "limit": 10
        ]
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer TOKEN"
        ]
        
        let endpoint = MSDEndpoint.search(body: body, headers: headers)
        
        XCTAssertEqual(endpoint.path, SEARCH_RECOMMENDATION_ENDPOINT)
        XCTAssertEqual(endpoint.method, .post)
        XCTAssertEqual(endpoint.header, headers)
        
        if let endpointBody = endpoint.body,
               let endpointData = try? JSONSerialization.data(withJSONObject: endpointBody),
               let bodyData = try? JSONSerialization.data(withJSONObject: body) {

                let endpointJSON = String(data: endpointData, encoding: .utf8)
                let bodyJSON = String(data: bodyData, encoding: .utf8)

                XCTAssertEqual(endpointJSON, bodyJSON)
            } else {
                XCTFail("Failed to convert endpoint.body to [String: Any?]")
            }
    }
}

class MSDErrorTests: XCTestCase {
    func testMSDErrorInitialization() {
        let apiError = ApiError(code: "ERR001", message: "Empty token")
        let msdError = MSDError(requestId: "123", correlationId: "456", errors: apiError)
        
        XCTAssertEqual(msdError.requestId, "123")
        XCTAssertEqual(msdError.correlationId, "456")
        XCTAssertEqual(msdError.errors.code, "ERR001")
        XCTAssertEqual(msdError.errors.message, "Empty token")
    }

    func testMSDErrorErrorCode() {
        let errorMap = MSDError.errorCode(.ERR002)
        
        let expectedMap: [String: Any?] = [
            "errors": [
                "code": "ERR002",
                "message": EMPTY_EVENT_NAME
            ]
        ]
        
        XCTAssertEqual(errorMap as NSDictionary, expectedMap as NSDictionary)
    }
    
    func testApiErrorInitialization() {
        let apiError = ApiError(code: "ERR003", message: "Missing event data")

        XCTAssertEqual(apiError.code, "ERR003")
        XCTAssertEqual(apiError.message, "Missing event data")
    }

    func testMSDErrorToMap() {
        let apiError = ApiError(code: "ERR003", message: "Missing event data")
        let msdError = MSDError(requestId: "123", correlationId: "456", errors: apiError)

        let expectedMap: [String: Any?] = [
            "requestId": "123",
            "correlationId": "456",
            "errors": [
                "code": "ERR003",
                "message": "Missing event data"
            ]
        ]

        let actualMap = msdError.toMap()

        XCTAssertEqual(actualMap["requestId"] as? String, expectedMap["requestId"] as? String)
        XCTAssertEqual(actualMap["correlationId"] as? String, expectedMap["correlationId"] as? String)

        if let actualErrors = actualMap["errors"] as? [String: Any?],
           let expectedErrors = expectedMap["errors"] as? [String: Any?] {
            XCTAssertEqual(actualErrors["code"] as? String, expectedErrors["code"] as? String)
            XCTAssertEqual(actualErrors["message"] as? String, expectedErrors["message"] as? String)
        } else {
            XCTFail("Failed to cast errors to [String: Any?]")
        }
    }
    
    func testErrorCodeMessage() {
        XCTAssertEqual(ErrorCode.ERR001.message, EMPTY_TOKEN)
        XCTAssertEqual(ErrorCode.ERR002.message, EMPTY_EVENT_NAME)
        XCTAssertEqual(ErrorCode.ERR003.message, MISSING_EVENT_DATA)
        XCTAssertEqual(ErrorCode.ERR004.message, MISSING_RECOMMENDATION_DATA)
        XCTAssertEqual(ErrorCode.ERR005.message, INTERNET_UNAVAILABLE)
        XCTAssertEqual(ErrorCode.ERR006.message, REQUEST_TIMEOUT)
        XCTAssertEqual(ErrorCode.ERR007.message, INVALID_URL)
        XCTAssertEqual(ErrorCode.ERR008.message, EMPTY_USER_ID)
        XCTAssertEqual(ErrorCode.ERR009.message, NO_RESPONSE)
        XCTAssertEqual(ErrorCode.ERR010.message, UNABLE_TO_DECODE)
        XCTAssertEqual(ErrorCode.ERR011.message, UNKNOWN_ERROR)
        XCTAssertEqual(ErrorCode.ERR012.message, SERVER_UNAVAILABLE)
    }
}

class AppManagerTests: XCTestCase {
    func testSharedInstance() {
        let instance1 = AppManager.shared
        let instance2 = AppManager.shared
        
        XCTAssertTrue(instance1 === instance2, "AppManager shared instance should be the same")
    }
    
    func testInitialValues() {
        let appManager = AppManager.shared
        
        XCTAssertNil(appManager.msdBaseUrl, "msdBaseUrl should be nil initially")
        XCTAssertNil(appManager.apiToken, "apiToken should be nil initially")
    }
}

class UserDefaultsExtensionTests: XCTestCase {
    let userDefaults = UserDefaults.standard
    
    override func tearDown() {
        super.tearDown()
        // Clear UserDefaults after each test
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    func testSetUserDefaultString() {
        let key = UserDefaultsKeys.MAD_UUID.rawValue
        let value = "ABC123"
        
        userDefaults.setUserDefaultString(key: key, value: value)
        
        XCTAssertEqual(userDefaults.string(forKey: key), value, "Failed to set UserDefaultString")
    }
    
    func testGetUserDefaultString_WhenValueExists_ReturnsValue() {
        let key = UserDefaultsKeys.MAD_UUID.rawValue
        let value = "ABC123"
        
        userDefaults.set(value, forKey: key)
        
        let retrievedValue = userDefaults.getUserDefaultString(key: key)
        
        XCTAssertEqual(retrievedValue, value, "Failed to retrieve UserDefaultString")
    }
    
    func testGetUserDefaultString_WhenValueDoesNotExist_ReturnsNil() {
        let key = UserDefaultsKeys.MSD_USER_ID.rawValue
        
        let retrievedValue = userDefaults.getUserDefaultString(key: key)
        
        XCTAssertNil(retrievedValue, "Expected nil for UserDefaultString when value does not exist")
    }
    
    func testRemoveData_WhenValueExists_RemovesValue() {
        let key = UserDefaultsKeys.MAD_UUID.rawValue
        let value = "ABC123"
        
        userDefaults.set(value, forKey: key)
        
        userDefaults.removeData(key: key)
        
        XCTAssertNil(userDefaults.string(forKey: key), "Failed to remove data from UserDefaults")
    }
    
    func testRemoveData_WhenValueDoesNotExist_DoesNothing() {
        let key = UserDefaultsKeys.MAD_UUID.rawValue
        
        userDefaults.removeData(key: key)
        
        // No assertion needed as we are just ensuring no crash or error occurs
    }
}
