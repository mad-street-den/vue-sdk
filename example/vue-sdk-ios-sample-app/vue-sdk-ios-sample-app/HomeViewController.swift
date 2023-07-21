import UIKit
import vue_sdk_ios

class HomeViewController: UIViewController {
    var msdObject: VueSDKInstance!
    var products: [Product] = []
    @IBOutlet var searchTableView: UITableView!
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    var homeViewCorrelationID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msdObject = VueSDK.mainInstance()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        homeViewCorrelationID = "1746e114-9ab3-4924-9899-0f9ccde465e6"
        
        // Configure loading indicator
        loadingIndicator.center = view.center
        loadingIndicator.color = .red
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
    }
    
    @IBAction func goToDetailPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    @IBAction func onSearchByPage(_ sender: Any) {
        showActivityIndicator()
        
        // Search Recommendations by page
        let catalogs = [
            "3089e3d3ba": [
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
        msdObject.getRecommendationsByPage(
            pageReference: "PDP",
            properties: RecommendationRequest(
                catalogs: catalogs
            ),correlationId: homeViewCorrelationID
        ) { res in
            self.stopActivityIndicator()
            self.handleRecommendationResponse(res)
        } failure: { error in
            self.stopActivityIndicator()
            self.clearTableView()
            print(error)
        }
    }
    
    @IBAction func onSearchByModule(_ sender: Any) {
        showActivityIndicator()
        
        // Search Recommendations by module
        let catalogs = [
            "427e26dbfa": [
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
        msdObject.getRecommendationsByModule(
            moduleReference: "Similar Products Module - 27 June",
            properties: RecommendationRequest(
                catalogs: catalogs,
                unbundle: true
            ),correlationId: homeViewCorrelationID
        ) { res in
            self.stopActivityIndicator()
            self.handleRecommendationResponse(res)
        } failure: { error in
            self.clearTableView()
            self.stopActivityIndicator()
            print(error)
        }
        
    }
    
    @IBAction func onSearchByStrategy(_ sender: Any) {
        // Start loading indicator animation
        showActivityIndicator()
        
        // Search Recommendations by strategy
        let catalogs = [
            "427e26dbfa": [
                "fields": [
                    "title",
                    "price",
                    "image_link",
                    "link"
                ],
                "context": [
                    "variant_id": "39596296700022"
                ],
                "search_query": "top",
                "search_fields": [
                    "title"
                ]
            ]
        ]
        msdObject.getRecommendationsByStrategy(
            strategyReference:  "Similar Products - 27June",
            properties: RecommendationRequest(
                catalogs: catalogs
            ),correlationId: homeViewCorrelationID
        ) { [weak self] res in
            self?.stopActivityIndicator()
            self?.handleRecommendationResponse(res)
        } failure: { error in
            self.clearTableView()
            self.stopActivityIndicator()
            print(error)
        }
    }
    
    func handleRecommendationResponse(_ res: [[String: Any?]]) {
        self.products.removeAll()
        self.products = Product.products(from: res)
        
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
    
    func showActivityIndicator(){
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }
    func stopActivityIndicator(){
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
    
    func clearTableView(){
        self.products.removeAll()
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! CustomViewCell
        
        let product = products[indexPath.row]
        cell.configure(with: product)
        
        return cell
    }
}
