//
//  FormViewController.swift
//  RACNest
//
//  Created by Rui Peres on 16/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
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
        
        viewModel.username <~ usernameField.rex_textSignal
        viewModel.password <~ passwordField.rex_textSignal

        loginButton.rex_pressed <~ SignalProducer(value: CocoaAction(viewModel.authenticateAction) { _ in })
        
        usernameField.becomeFirstResponder()
    }
}

