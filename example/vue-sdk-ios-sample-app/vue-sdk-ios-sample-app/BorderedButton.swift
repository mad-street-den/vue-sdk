import UIKit

class BorderedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        setTitleColor(UIColor.darkText, for: .normal) // Change to your desired text color
        setTitleColor(UIColor.white, for: .highlighted)
        backgroundColor = UIColor.lightGray // Change
    }
}

