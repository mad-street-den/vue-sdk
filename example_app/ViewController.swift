import UIKit
import msd_sdk

class ViewController: UIViewController {
    var msdObject: MSD!
    
    @IBAction func onTapDiscover(_ sender: Any) {
        msdObject?.discoverEvents(success: { (response) in
            print(response.data)
        }, failure: { error in
            print(error)
        })
    }
    
    @IBAction func onTapTrack(_ sender: Any) {
        //Track Method
        msdObject.track(eventName:  "removeFromCart", pageName: "PDP", properties: ["source_prodid": "39596296700022", "page_type": "pdp"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize SDK
        msdObject =  MSD.initialize(token: "YOUR_TOKEN",baseUrl: "MSD_BASE_URL")
        
        // Set User Id
        msdObject.setUser(userId: "YOUR_USER_ID")
        
        // Enable logging
        msdObject.isLoggingEnabled = true
    }
    
    @IBAction func onSearchByPage(_ sender: Any) {
        // Search Recommendations by page
        msdObject.getRecommendationsByPage(
            pageReference: "PDP",
            properties: RecommendationRequest(
                catalogs: [
                    "d18edb1c46": [
                        "fields": [
                            "title",
                            "price",
                            "image_link",
                            "link"
                        ],
                        "context": [
                            "variant_id": "39596296700022"
                        ]
                    ]
                ]
            )
        ) { res in
            print(res)
        } failure: { error in
            print(error)
        }
    }
    
    @IBAction func onSearchByModule(_ sender: Any) {
        // Search Recommendations by module
        msdObject.getRecommendationsByModule(
            moduleReference: "Similar Products",
            properties: RecommendationRequest(
                catalogs: [
                    "d18edb1c46": [
                        "fields": [
                            "title",
                            "price",
                            "image_link",
                            "link"
                        ],
                        "context": [
                            "variant_id": "39596296700022"
                        ]
                    ]
                ],
                unbundle: true
            )
        ) { res in
            print(res)
        } failure: { er in
            print(er)
        }
        
    }
    
    @IBAction func onSearchByStrategy(_ sender: Any) {
        // Search Recommendations by strategy
        msdObject.getRecommendationsByStrategy(
            strategyReference: "PDP - SP",
            properties: RecommendationRequest(
                catalogs: [
                    "d18edb1c46": [
                        "fields": [
                            "title",
                            "price",
                            "image_link",
                            "link"
                        ],
                        "context": [
                            "variant_id": "39596296700022"
                        ]
                    ]
                ],
                max_content: 2,
                min_content: 2,
                page_num: 2,
                skip_cache: true,
                explain: true,
                config: [["grgr": "efe"]],
                min_bundles: 2,
                max_bundles: 2,
                unbundle: true
            )
        ) { res in
            print(res)
        } failure: { error in
            print(error)
        }
    }
}
