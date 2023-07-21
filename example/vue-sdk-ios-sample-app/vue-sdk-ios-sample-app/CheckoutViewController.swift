import Foundation
import UIKit
import vue_sdk_ios

class CheckoutViewController: UIViewController {
    var sdkInstance: VueSDKInstance!
    var checkoutViewCorrelationID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutViewCorrelationID = "checkoutVIewCorrelationID"
        sdkInstance = VueSDK.mainInstance()
    }
    
    @IBAction func onTapDiscover(_ sender: Any) {
        sdkInstance.discoverEvents(success: { (response) in
            print(response.data)
        }, failure: { error in
            print(error)
        })
    }
}
