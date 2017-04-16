import UIKit
import ReactiveSwift
import ReactiveCocoa

final class FormViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var viewModel: FormViewModel = FormViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.text = viewModel.username.value
        passwordField.text = viewModel.password.value
        
        viewModel.username <~ usernameField.reactive.continuousTextValues.filterMap { $0 }
        viewModel.password <~ passwordField.reactive.continuousTextValues.filterMap { $0 }

        loginButton.reactive.pressed = CocoaAction(viewModel.authenticateAction)
        
        usernameField.becomeFirstResponder()
    }
}
