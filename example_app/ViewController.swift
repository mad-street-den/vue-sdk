import UIKit
import msd_sdk

class ViewController: UIViewController {
    var msdObject: MSD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize SDK
        let msdObject =  MSD.initialize(token: "YOUR_TOKEN",baseUrl: "MSD_BASE_URL")
        
        // Set User Id
        msdObject.setUser(userId: "YOUR_USER_ID")
        
        // Enable logging
        msdObject.isLoggingEnabled = true
        
        // Track Method
        msdObject.track(eventName: "pageView", pageName: "PDP", properties: [
            "source_prodid": "39596296700022",
            "page_type": "pdp"
        ])
        
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
}
