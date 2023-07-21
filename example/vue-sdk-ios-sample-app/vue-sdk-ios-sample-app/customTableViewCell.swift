import Foundation
import UIKit

class CustomViewCell: UITableViewCell {
    @IBOutlet var imageCell: UIImageView!
    @IBOutlet var title: UILabel!
    
    func configure(with product: Product) {
        title.text = product.title
    }
}

struct Product {
    let title: String
    let link: String
    
    static func products(from response: [[String: Any?]]) -> [Self] {
        var products: [Self] = []
        guard let array = response[0]["data"] as? [[String: Any?]] else { return [] }
        products = array.compactMap { dataObject in
            guard let title = dataObject["title"] as? String,
                  let link = dataObject["image_link"] as? String else { return nil }
            return Product(title: title, link: link)
        }
        return products
    }
}
