import Foundation

class EventPresenter: BasePresenter {
    private let msdservice:MSDServiceable
    
    init(msdservice: MSDServiceable) {
        self.msdservice = msdservice
    }
    
    func trackEvent(eventName: String, properties: [String: Any?]) async {
        //TODO: CALL TRACK SERVICE HERE
    }
}

