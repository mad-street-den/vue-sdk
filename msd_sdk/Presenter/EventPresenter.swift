import Foundation

class EventPresenter: BasePresenter {
    private let msdservice:MSDServiceable
    
    init(msdservice: MSDServiceable) {
        self.msdservice = msdservice
    }
    
    func trackEvent(eventName: String, properties: [String: Any?]) async {
        await msdservice.track(event: eventName, properties: properties, success: { res in
            print(res)
        }, failure: { error in
            print(error)
        })
    }
}

