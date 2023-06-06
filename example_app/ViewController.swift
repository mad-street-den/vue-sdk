import UIKit
import msd_sdk

class ViewController: UIViewController {
    var msdObject: MSD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize SDK
        let msdObject =  MSD.initialize(token: "YOUR_TOKEN",baseUrl: "MSD_BASE_URL")
        
        //Set User Id
        msdObject.setUser(userId: "YOUR_USER_ID")
        msdObject.isLoggingEnabled = true
        //Track Method
        msdObject.track(eventName:  "pageView", pageName: "PDP", properties: ["source_prodid": "39596296700022", "page_type": "pdp"])
    }
}

