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
