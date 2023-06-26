import Foundation

public struct DiscoverEventsResponse: Codable, Equatable {
    public let data: EventDataContainer?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    public static func == (lhs: DiscoverEventsResponse, rhs: DiscoverEventsResponse) -> Bool {
        return lhs.data == rhs.data
    }
}

public struct EventDataContainer: Codable, Equatable {
    public let accountMetadata: [AccountMetadata]?
    public let events: [EventData]?
    enum CodingKeys: String, CodingKey {
        case accountMetadata = "account-metadata"
        case events
    }
    
    public static func == (lhs: EventDataContainer, rhs: EventDataContainer) -> Bool {
        return lhs.accountMetadata == rhs.accountMetadata &&
               lhs.events == rhs.events
    }
}

public struct AccountMetadata: Codable, Equatable {
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
    
    public static func == (lhs: AccountMetadata, rhs: AccountMetadata) -> Bool {
        return lhs.bloxApiUrl == rhs.bloxApiUrl &&
               lhs.language == rhs.language &&
               lhs.currency == rhs.currency &&
               lhs.currencyCode == rhs.currencyCode &&
               lhs.pdpTargetSame == rhs.pdpTargetSame &&
               lhs.id == rhs.id &&
               lhs.clientId == rhs.clientId &&
               lhs.createdTs == rhs.createdTs &&
               lhs.updatedTs == rhs.updatedTs
    }
}

public struct EventData: Codable, Equatable {
    public let eventName: String?
    public let eventMeta: String?
    public let eventsSchema: [EventSchema]?
    public let action: String?
    
    enum CodingKeys: String, CodingKey {
        case eventName = "event_name"
        case eventMeta = "event_meta"
        case eventsSchema = "events_schema"
        case action
    }
    
    public static func == (lhs: EventData, rhs: EventData) -> Bool {
        return lhs.eventName == rhs.eventName &&
               lhs.eventMeta == rhs.eventMeta &&
               lhs.eventsSchema == rhs.eventsSchema &&
               lhs.action == rhs.action
    }
}

public struct EventSchema: Codable, Equatable {
    public let sourceField: String?
    public let dataType: String?
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
    
    public static func == (lhs: EventSchema, rhs: EventSchema) -> Bool {
        return lhs.sourceField == rhs.sourceField &&
               lhs.dataType == rhs.dataType &&
               lhs.mandatory == rhs.mandatory &&
               lhs.catalogID == rhs.catalogID &&
               lhs.catalogKey == rhs.catalogKey &&
               lhs.meta == rhs.meta &&
               lhs.explodeField == rhs.explodeField
    }
}
