import UIKit
import vue_sdk_ios

class LoginViewController: UIViewController {
    @IBOutlet weak var apiTokenTextField: UITextField!
    @IBOutlet weak var baseURLTextField: UITextField!
    @IBOutlet weak var userIDTextField: UITextField!
    var apiToken: String? = nil
    var baseUrl: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiTokenTextField.delegate = self
        baseURLTextField.delegate = self
        userIDTextField.delegate = self
    }
    
    @IBAction func onContinueButtonTap(_ sender: UIButton) {
        setTextFromTextFields()
        VueSDK.initialize(token:apiToken ?? "", baseUrl: baseUrl ?? "")
        VueSDK.mainInstance().isLoggingEnabled = true
        if let userId = userIDTextField.text,  userId != "" {
            VueSDK.mainInstance().setUser(userId: userId)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "homeVcIdentifier") as? HomeViewController {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    private func setTextFromTextFields() {
        if let apiToken = apiTokenTextField.text, !apiToken.isEmpty {
            self.apiToken = apiToken
        }
        
        if let baseURL = baseURLTextField.text, !baseURL.isEmpty {
            self.baseUrl = baseURL
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        apiTokenTextField.resignFirstResponder()
        baseURLTextField.resignFirstResponder()
        userIDTextField.resignFirstResponder()
        return true
    }
}
