import UIKit
import msd_sdk

class ViewController: UIViewController {
    var msdObject: MSD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize SDK
        let msdObject =  MSD.initialize(token: "YOUR_TOKEN",baseUrl: "https://api-dev.madstreetden.xyz")
        
        //Set User Id
        msdObject.setUser(userId: "YOUR_USER_ID")
        
        //Track Method
        msdObject.track(eventName: "YOUR_CUSTOM_EVENT_NAME", properties: ["YOUR_KEY":"YOUR_VALUE"])
        
        //getRecommendationsByPage Method
        msdObject.getRecommendationsByPage(pageReference: "YOUR_PAGE_NAME", properties: RecommendationRequest(platform: "YOUR_PLATFORM", medium: "YOUR_MEDIUM_STRING", integrationMode: "SPECIFIED_INTEGRATION_MODE", catalogs: [:])) { response, error in
            if error != nil{
                //Handle Error case
            }else{
                //Handle Success case
            }
        }
        
        //getRecommendationsByText method
        msdObject.getRecommendationsByText(textReference: "YOUR_TEXT_NAME",  properties: RecommendationRequest(platform: "YOUR_PLATFORM", medium: "YOUR_MEDIUM_STRING", integrationMode: "SPECIFIED_INTEGRATION_MODE", catalogs: [:])){ response, error in
            if error != nil{
                //Handle Error case
            }else{
                //Handle Success case
            }
        }
        
        //getRecommendationsByModule method
        msdObject.getRecommendationsByModule(moduleReference: "YOUR_MODULE_NAME",  properties: RecommendationRequest(platform: "YOUR_PLATFORM", medium: "YOUR_MEDIUM_STRING", integrationMode: "SPECIFIED_INTEGRATION_MODE", catalogs: [:]) ){ response, error in
            if error != nil{
                //Handle Error case
            }else{
                //Handle Success case
            }
        }
        
        //getRecommendationsByStrategy method
        msdObject.getRecommendationsByStrategy(strategyReference: "YOUR_STRATEGY_NAME",properties: RecommendationRequest(platform: "YOUR_PLATFORM", medium: "YOUR_MEDIUM_STRING", integrationMode: "SPECIFIED_INTEGRATION_MODE", catalogs: [:])){ response, error in
            if error != nil{
                //Handle Error case
            }else{
                //Handle Success case
            }
        }
    }
}

