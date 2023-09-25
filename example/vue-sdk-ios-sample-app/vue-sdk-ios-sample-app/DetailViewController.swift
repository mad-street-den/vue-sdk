import Foundation
import UIKit
import vue_sdk_ios

class DetailViewController:UIViewController{
    var sdkInstance: VueSDKInstance!
    @IBOutlet var userIdTextField: UITextField!
    var detailViewCorrelationID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewCorrelationID = "detailViewCorrelationID"
        userIdTextField.delegate = self
        sdkInstance = VueSDK.mainInstance()
    }
    
    @IBAction func onTapSetUserId(_ sender: Any) {
        if let userId = userIdTextField.text,  userId != "" {
            sdkInstance.setUser(userId: userId)
        }
        userIdTextField.resignFirstResponder()
    }
    
    @IBAction func onTapResetUserProfile(_ sender: Any) {
        sdkInstance.resetUser()
    }
    
    @IBAction func onTapDiscover(_ sender: Any) {
        sdkInstance.discoverEvents(success: { (response) in
            print(response.data)
        }, failure: { error in
            print(error)
        })
    }
    
    @IBAction func onTapPageView(_ sender: Any) {
        let properties = ["page_type":"pdp",
                          "page_name": "PDP",
                          "product_id": "39596296700022"
                         ]
        sdkInstance.track(eventName: "pageView", properties: properties,
                          correlationId: detailViewCorrelationID,sdkConfig: VueSDKConfig(medium: "MED",url: "",platform: "ios"))
    }
    
    @IBAction func onTapPageViewForHome(_ sender: Any) {
        let properties = ["page_type":"Home",
                          "page_name": "Home",
                         ]
        sdkInstance.track(eventName: "pageView", properties: properties,
                          correlationId: detailViewCorrelationID)
    }
    
    @IBAction func onTapBuy(_ sender: Any) {
        let properties = ["page_type": "oc",
                          "page_name": "Order Confirmation",
                          "product_id": ["39596296700022"],
                          "product_price": [125.50],
                          "order_id": "AE75634",
                          "quantity": [1],
                          "price": ["125.10"]] as [String : Any]
        sdkInstance.track(eventName: "Buy", properties: properties, correlationId: detailViewCorrelationID)
    }
    
    @IBAction func onTapModuleView(_ sender: Any) {
        let properties = ["page_type":"pdp",
                          "page_name": "PDP",
                          "product_id": "5789256482843",
                          "slot_id": "android_slot2",
                          "module_id": "a5777370-b133-426a-ae3a-5a883a787130"]
        sdkInstance.track(eventName: "ModuleView", properties: properties, correlationId: detailViewCorrelationID)
    }
    
    @IBAction func onTapModuleClick(_ sender: Any) {
        let properties = ["page_type":"pdp",
                          "page_name": "PDP",
                          "product_id": "5789256482843",
                          "clicked_product_id": "39946630725750",
                          "position_of_reco": 1,
                          "slot_id": "android_slot2",
                          "module_id": "a5777370-b133-426a-ae3a-5a883a787130",
                          "strategy_id": "04092a30-22e2-4565-83ee-3ffd83cb6375"] as [String : Any]
        sdkInstance.track(eventName: "ModuleClick", properties: properties, correlationId: detailViewCorrelationID)
    }
    
    @IBAction func onTapPlaceOrder(_ sender: Any) {
        let properties = ["page_type": "pdp",
                          "page_name": "PDP",
                          "product_id": "5789256482843"]
        sdkInstance.track(eventName: "placeOrder", properties: properties, correlationId: detailViewCorrelationID)
    }
    
//    @IBAction func goToChekoutPage(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "checkoutVC") as? CheckoutViewController {
//            navigationController?.pushViewController(destinationVC, animated: true)
//        }
//    }
    
    @IBAction func onTapAddToCart(_ sender: Any) {
        let properties = ["page_type":"pdp",
                          "page_name": "PDP",
                          "product_id": "5789256482843",
                          "clicked_product_id": "39946630725750",
                          "source_prodid": "s18naqdp743b"]
        sdkInstance.track(eventName: "addToCart", properties: properties, correlationId: detailViewCorrelationID,sdkConfig: VueSDKConfig(medium: "medium"))
    }
    
    @IBAction func onTapRemoveFromCart(_ sender: Any) {
        let properties = ["page_type":"pdp",
                          "page_name": "PDP",
                          "product_id": "5789256482843",
                          "clicked_product_id": "39946630725750"]
        sdkInstance.track(eventName: "Removefromcart", properties: properties, correlationId: detailViewCorrelationID)
    }
    
    @IBAction func onTapLeftSwipe(_ sender: Any) {
        let properties = ["page_type":"pdp",
                          "page_name": "PDP",
                          "product_id": "5789256482843",
                          "slot_id": "android_slot2",
                          "module_id": "a5777370-b133-426a-ae3a-5a883a787130"]
        sdkInstance.track(eventName: "leftSwipe", properties: properties, correlationId: detailViewCorrelationID)
    }
    
    @IBAction func onTapRightSwipe(_ sender: Any) {
        let properties = ["page_type":"pdp",
                          "page_name": "PDP",
                          "product_id": "5789256482843",
                          "slot_id": "android_slot2",
                          "module_id": "a5777370-b133-426a-ae3a-5a883a787130"]
        sdkInstance.track(eventName: "rightSwipe", properties:properties, correlationId: detailViewCorrelationID)
    }
    
}

extension DetailViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userIdTextField.resignFirstResponder()
        return true
    }
}
