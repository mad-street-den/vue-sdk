import Foundation

enum RecommendationRequestType: String {
    case strategy_name
    case module_name
    case page_name
}

public class RecommendationRequest {
    let catalogs: [String:Any?]
    let max_content: Int?
    let min_content: Int?
    let page_num: Int?
    let skip_cache: Bool?
    let explain: Bool?
    let config: [[String:Any?]]?
    let min_bundles: Int?
    let max_bundles: Int?
    let unbundle: Bool?
    
    public init(catalogs: [String:Any?], max_content: Int? = nil, min_content: Int? = nil, page_num: Int? = nil, skip_cache: Bool? = nil, explain: Bool? = nil, config: [[String:Any?]]? = nil, min_bundles: Int? = nil, max_bundles: Int? = nil, unbundle: Bool? = nil) {
        self.catalogs = catalogs
        self.max_content = max_content
        self.min_content = min_content
        self.page_num = page_num
        self.skip_cache = skip_cache
        self.explain = explain
        self.config = config
        self.min_bundles = min_bundles
        self.max_bundles = max_bundles
        self.unbundle = unbundle
    }
    
    func toDict() -> [String:Any] {
        var dictionary: [String:Any] = [:]
        dictionary["catalogs"] = catalogs
        if let max_content = max_content {
            dictionary["max_content"] = max_content
        }
        if let min_content = min_content {
            dictionary["min_content"] = min_content
        }
        if let page_num = page_num {
            dictionary["page_num"] = page_num
        }
        if let skip_cache = skip_cache {
            dictionary["skip_cache"] = skip_cache
        }
        if let explain = explain {
            dictionary["explain"] = explain
        }
        if let config = config {
            dictionary["config"] = config
        }
        if let min_bundles = min_bundles {
            dictionary["min_bundles"] = min_bundles
        }
        if let max_bundles = max_bundles {
            dictionary["max_bundles"] = max_bundles
        }
        if let unbundle = unbundle {
            dictionary["unbundle"] = unbundle
        }
        return dictionary
    }
}
