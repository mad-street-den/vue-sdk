protocol APIRequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String:String]? { get }
    var body: [String:Any?]? { get }
}
