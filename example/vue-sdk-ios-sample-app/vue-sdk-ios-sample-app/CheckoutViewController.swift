import Foundation
import UIKit
import vue_sdk_ios

class CheckoutViewController: UIViewController {
    var msd: VueSDKInstance!
    var checkoutViewCorrelationID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutViewCorrelationID = "checkoutVIewCorrelationID"
        msd = VueSDK.mainInstance()
    }
    
    @IBAction func onTapDiscover(_ sender: Any) {
        msd.discoverEvents(success: { (response) in
            print(response.data)
        }, failure: { error in
            print(error)
        })
    }
}
