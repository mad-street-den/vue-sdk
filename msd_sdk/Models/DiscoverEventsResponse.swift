import Foundation

public struct DiscoverEventsResponse: Codable {
    public let data: EventDataContainer?
    enum CodingKeys: String, CodingKey {
        case data
    }
}
public struct EventDataContainer: Codable {
    public let accountMetadata: AccountMetadata?
    public let events: [EventData]?
    enum CodingKeys: String, CodingKey {
        case accountMetadata = "account-metadata"
        case events
    }
}

public struct AccountMetadata: Codable {
    public let bloxApiUrl: String?
    public let language: String?
    public let currency: String?
    public let currencyCode: String?
    public let pdpTargetSame: Bool?
    public let id: String?
    public let clientId: String?
    public let createdTs: String?
    public let updatedTs: String?
    
    enum CodingKeys: String, CodingKey {
        case bloxApiUrl = "blox_api_url"
        case language, currency, currencyCode = "currency_code"
        case pdpTargetSame = "pdp_target_same"
        case id, clientId = "client_id"
        case createdTs = "created_ts"
        case updatedTs = "updated_ts"
    }
}

public struct EventData: Codable {
    public  let eventName: String?
    public  let eventMeta: String?
    public let eventsSchema: [EventSchema]?
    public let action: String?
    
    enum CodingKeys: String, CodingKey {
        case eventName = "event_name"
        case eventMeta = "event_meta"
        case eventsSchema = "events_schema"
        case action
    }
}

public struct EventSchema: Codable {
    public  let sourceField: String?
    public  let dataType: String?
    public let mandatory: Bool?
    public let catalogID: String?
    public let catalogKey: String?
    public let meta: String?
    public let explodeField: Bool?
    
    enum CodingKeys: String, CodingKey {
        case sourceField = "source_field"
        case dataType = "data_type"
        case mandatory, catalogID = "catalog_id", catalogKey = "catalog_key"
        case meta = "meta", explodeField = "explode_field"
    }
}

