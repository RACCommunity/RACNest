//
//  FormViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 16/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import Foundation
import ReactiveCocoa


final class FormViewModel {
    
    let username: MutableProperty<String>
    let password: MutableProperty<String>
    
    var authenticate: CocoaAction!
    
    init(credentialsValidationRule: (String, String) -> Bool = validateCredentials) {
        
        let username = NSUserDefaults.value(forKey: .Username)
        let password = NSUserDefaults.value(forKey: .Password)
        
        self.username = MutableProperty(username)
        self.password = MutableProperty(password)
        
        let validCredentials = MutableProperty(credentialsValidationRule(username, password))
        validCredentials <~ combineLatest(self.username.producer, self.password.producer).map(credentialsValidationRule)
        
        let action = authenticationAction(validCredentials)
        authenticate = CocoaAction(action, input: ())
    }
    
    private func authenticationAction(enableProperty: MutableProperty<Bool>) -> Action<(), Void, NoError> {
        
        return Action<(), Void, NoError>(enabledIf: enableProperty, { [weak self] _ in
            return SignalProducer { o, d in
                
                let username = self?.username.value ?? ""
                let password = self?.password.value ?? ""
                
                NSUserDefaults.setValue(username, forKey: .Username)
                NSUserDefaults.setValue(password, forKey: .Password)
                
                o.sendCompleted()
            }
            })
    }
}

private func validateCredentials(username: String, password: String) -> Bool {
    
    let usernameRule = username.characters.count > 5
    let passwordRule = password.characters.count > 10
    
    return usernameRule && passwordRule
}
