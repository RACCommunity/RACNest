//
//  FormViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 16/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

struct FormViewModel {

    let authenticateAction: Action<Void, Void, NoError>

    let username: MutableProperty<String>
    let password: MutableProperty<String>
    
    init(credentialsValidationRule: (String, String) -> Bool = validateCredentials) {
        
        let username = NSUserDefaults.value(forKey: .Username)
        let password = NSUserDefaults.value(forKey: .Password)
        
        let usernameProperty = MutableProperty(username)
        let passwordProperty = MutableProperty(password)

        let isFormValid = MutableProperty(credentialsValidationRule(username, password))
        isFormValid <~ combineLatest(usernameProperty.producer, passwordProperty.producer).map(credentialsValidationRule)

        let authenticateAction = Action<Void, Void, NoError>(enabledIf: isFormValid, { _ in
            return SignalProducer { o, d in

                let username = usernameProperty.value ?? ""
                let password = passwordProperty.value ?? ""

                NSUserDefaults.setValue(username, forKey: .Username)
                NSUserDefaults.setValue(password, forKey: .Password)

                o.sendCompleted()
            }
        })

        self.username = usernameProperty
        self.password = passwordProperty
        self.authenticateAction = authenticateAction
    }

}

private func validateCredentials(username: String, password: String) -> Bool {
    
    let usernameRule = username.characters.count > 5
    let passwordRule = password.characters.count > 10
    
    return usernameRule && passwordRule
}
