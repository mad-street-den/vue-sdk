import Foundation

enum RecommendationRequestType:String{
    case strategy_name
    case module_name
    case page_name
}

public class RecommendationRequest{
    let platform: String
    let medium: String
    let integrationMode: String
    var catalogs: [String: Any?]
    var dynamicdata:[String:String?] = [:]
    
    public init(platform: String, medium: String, integrationMode: String, catalogs: [String : Any?]) {
        self.platform = platform
        self.medium = medium
        self.integrationMode = integrationMode
        self.catalogs = catalogs
    }
}

extension RecommendationRequest {
    func toJSON() -> String? {
        var dictionary: [String: Any] = [
            "platform": platform,
            "medium": medium,
            "integrationMode": integrationMode
        ]
        
        var catalogsDictionary: [String: Any] = [:]
        for (key, value) in catalogs {
            if let unwrappedValue = value {
                catalogsDictionary[key] = unwrappedValue
            }
        }
        dictionary["catalogs"] = catalogsDictionary
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error converting to JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    func setDynamicDataField(dynamicKey:String, dynamicValue:String?){
        self.dynamicdata = [dynamicKey:dynamicValue]
    }
}
