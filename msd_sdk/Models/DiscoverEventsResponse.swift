import Foundation

public struct DiscoverEventsResponse: Codable {
    public let data: EventDataContainer?
    enum CodingKeys: String, CodingKey {
        case data
    }
}
public struct EventDataContainer: Codable {
    public let accountMetadata: AccountMetadata?
    public let pages: [Page]?
    public let events: [EventData]?
    enum CodingKeys: String, CodingKey {
        case accountMetadata = "account-metadata"
        case events,pages
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

public struct Page: Codable {
    public let name: String?
    public let type: String?
    public let desktop: PageDetails?
    public let mobile: PageDetails?
    public let ios: PageDetails?
    public let android: PageDetails?
    public let id: String?
    public let clientId: String?
    public let createdTs: String?
    public let updatedTs: String?
    
    enum CodingKeys: String, CodingKey {
        case name, type, desktop, mobile, ios, android, id, clientId = "client_id"
        case createdTs = "created_ts"
        case updatedTs = "updated_ts"
    }
}

public struct PageDetails: Codable {
    public let id: Int?
    public let status: String?
    public let type: String?
    public let slots: [Slot]?
    public let fieldIdentifiers: [FieldIdentifier]?
    public let userIdentifier: UserIdentifier?
    public let createdDate: String?
    public let updatedDate: String?
    public let extras: String?
    public let name: String?
    public let url: String?
    public let previewUrl: String?
    public let pageIdentifier: PageIdentifier?
    public let uuidIdentifier: UserIdentifier?
    public let customParameters: String?
    public let analytics: Analytics?
    public let eventListeners: String?
    public let parentPage: Int?
    public let platform: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, status, type, slots, fieldIdentifiers = "field_identifiers", userIdentifier = "user_identifier", createdDate = "created_date", updatedDate = "updated_date", extras, name, url, previewUrl = "preview_url", pageIdentifier = "page_identifier", uuidIdentifier = "uuid_identifier", customParameters = "custom_parameters", analytics, eventListeners = "event_listeners", parentPage = "parent_page", platform
    }
}

public struct UserIdentifier: Codable {
    public let hash: Bool?
    public let conditions: [Condition]?
}

public struct Condition: Codable {
    public let type: String?
    
    enum CodingKeys: String, CodingKey {
        case type
    }
}

public struct Slot: Codable {
    public let id: Int?
    public let name: String?
    public let slotBehaviour: String?
    public let placement: Placement?
    public let pageId: Int?
    public let extras: String?
    public let clientId: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slotBehaviour = "slot_behaviour", placement, pageId = "page_id", extras, clientId = "client_id"
    }
}

public struct Placement: Codable {
    public let path: String?
    public let type: String?
    public let position: String?
    
    enum CodingKeys: String, CodingKey {
        case path, type, position
    }
}

public struct FieldIdentifier: Codable {
    public let field: String?
    public let catalogId: String?
    public let conditions: [FieldCondition]
    public let primaryKey: Bool?
    public let multiOccurrence: Bool?
    
    enum CodingKeys: String, CodingKey {
        case field, catalogId = "catalog_id", conditions, primaryKey = "primary_key", multiOccurrence = "multi_occurrence"
    }
}

public struct FieldCondition: Codable {
    public let type: String?
    public let value: String?
    
    enum CodingKeys: String, CodingKey {
        case type, value
    }
}

public struct PageIdentifier: Codable {
    public let operation: String?
    public let conditions: [PageCondition]
    
    enum CodingKeys: String, CodingKey {
        case operation = "operation"
        case conditions = "conditions"
    }
}

public struct PageCondition: Codable {
    public let type: String?
    public let value: String?
    public let predicate: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case value = "value"
        case predicate = "predicate"
    }
}


public struct Analytics: Codable {
    public let events: [AnalyticsEvent]?
}

public struct AnalyticsEvent: Codable {
    public let action: String?
    public let eventMeta: String?
    public let eventName: String?
    
    enum CodingKeys: String, CodingKey {
        case action
        case eventMeta = "event_meta"
        case eventName = "event_name"
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

